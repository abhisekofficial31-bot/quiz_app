import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';

class ThemeSelectionScreen extends StatefulWidget {
  final bool isModal; // true = shown from profile, false = full screen
  const ThemeSelectionScreen({super.key, this.isModal = false});

  @override
  State<ThemeSelectionScreen> createState() => _ThemeSelectionScreenState();
}

class _ThemeSelectionScreenState extends State<ThemeSelectionScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;
  String _selectedCategory = 'all';
  HeroTheme? _previewTheme;

  final List<Map<String, String>> _categories = [
    {'id': 'all',     'label': 'All',    'emoji': '🎨'},
    {'id': 'classic', 'label': 'Classic','emoji': '🏆'},
    {'id': 'marvel',  'label': 'Marvel', 'emoji': '⚡'},
    {'id': 'dc',      'label': 'DC',     'emoji': '🦇'},
  ];

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: _categories.length, vsync: this);
    _tabCtrl.addListener(() {
      setState(() => _selectedCategory = _categories[_tabCtrl.index]['id']!);
    });
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  List<HeroTheme> get _filtered {
    if (_selectedCategory == 'all') return AppThemes.all;
    return AppThemes.all.where((t) => t.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final currentTheme = themeProvider.current;
    final isDark = currentTheme.background.computeLuminance() < 0.3;

    return Scaffold(
      backgroundColor: currentTheme.background,
      body: Stack(
        children: [
          // Background decoration
          Positioned.fill(
            child: _BackgroundDecoration(theme: currentTheme),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                _buildHeader(context, currentTheme, isDark),

                // Category tabs
                _buildCategoryTabs(currentTheme, isDark),

                const SizedBox(height: 12),

                // Theme grid
                Expanded(
                  child: _buildThemeGrid(themeProvider, currentTheme),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, HeroTheme t, bool isDark) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        children: [
          if (widget.isModal)
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: t.cardBg,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Icon(Icons.arrow_back_ios_new_rounded,
                    size: 18, color: t.textDark),
              ),
            ),
          if (widget.isModal) const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🎨 Choose Your Theme',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: t.textDark,
                  ),
                ),
                Text(
                  'Pick your superhero and transform the app!',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: t.textLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2, end: 0);
  }

  Widget _buildCategoryTabs(HeroTheme t, bool isDark) {
    return Container(
      height: 44,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final cat = _categories[i];
          final isActive = _selectedCategory == cat['id'];
          return GestureDetector(
            onTap: () {
              _tabCtrl.animateTo(i);
              setState(() => _selectedCategory = cat['id']!);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isActive ? t.primary : t.cardBg,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: isActive ? t.primary : t.textLight.withOpacity(0.3),
                ),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: t.primary.withOpacity(0.35),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ]
                    : [],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(cat['emoji']!, style: const TextStyle(fontSize: 14)),
                  const SizedBox(width: 6),
                  Text(
                    cat['label']!,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight:
                          isActive ? FontWeight.w700 : FontWeight.w500,
                      color: isActive ? Colors.white : t.textDark,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ).animate().fadeIn(delay: 100.ms, duration: 400.ms);
  }

  Widget _buildThemeGrid(ThemeProvider provider, HeroTheme currentTheme) {
    final themes = _filtered;
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 0.82,
      ),
      itemCount: themes.length,
      itemBuilder: (context, i) {
        final theme = themes[i];
        final isActive = provider.current.id == theme.id;
        return _ThemeCard(
          theme: theme,
          isActive: isActive,
          index: i,
          onTap: () async {
            await provider.selectTheme(theme);
            if (widget.isModal && context.mounted) {
              Navigator.pop(context);
            }
          },
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Individual Theme Card
// ─────────────────────────────────────────────────────────────────────────────
class _ThemeCard extends StatefulWidget {
  final HeroTheme theme;
  final bool isActive;
  final int index;
  final VoidCallback onTap;

  const _ThemeCard({
    required this.theme,
    required this.isActive,
    required this.index,
    required this.onTap,
  });

  @override
  State<_ThemeCard> createState() => _ThemeCardState();
}

class _ThemeCardState extends State<_ThemeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerCtrl;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _shimmerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.theme;
    final isDark = t.background.computeLuminance() < 0.3;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: t.gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: widget.isActive
                  ? t.accent
                  : Colors.white.withOpacity(0.2),
              width: widget.isActive ? 3 : 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: t.primary.withOpacity(widget.isActive ? 0.5 : 0.25),
                blurRadius: widget.isActive ? 20 : 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Pattern background
              Positioned(
                right: -10,
                bottom: -10,
                child: Text(
                  t.patternEmoji,
                  style: TextStyle(
                    fontSize: 80,
                    color: Colors.white.withOpacity(0.07),
                  ),
                ),
              ),
              Positioned(
                left: -15,
                top: -10,
                child: Text(
                  t.patternEmoji,
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.white.withOpacity(0.05),
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Emoji + active badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(t.emoji,
                            style: const TextStyle(fontSize: 36)),
                        if (widget.isActive)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: t.accent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Active',
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ),
                      ],
                    ),

                    const Spacer(),

                    // Name
                    Text(
                      t.name,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 4),

                    // Tagline
                    Text(
                      t.tagline,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: Colors.white.withOpacity(0.75),
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 12),

                    // Color palette preview
                    Row(
                      children: [
                        _ColorDot(color: t.primary),
                        const SizedBox(width: 4),
                        _ColorDot(color: t.accent),
                        const SizedBox(width: 4),
                        _ColorDot(color: t.secondary),
                        const Spacer(),
                        // Category badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            t.category.toUpperCase(),
                            style: GoogleFonts.poppins(
                              fontSize: 8,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Shimmer effect for active card
              if (widget.isActive)
                Positioned.fill(
                  child: AnimatedBuilder(
                    animation: _shimmerCtrl,
                    builder: (_, __) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          gradient: LinearGradient(
                            begin: Alignment(-1.5 + _shimmerCtrl.value * 3, 0),
                            end: Alignment(-0.5 + _shimmerCtrl.value * 3, 0),
                            colors: [
                              Colors.transparent,
                              Colors.white.withOpacity(0.07),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        )
            .animate()
            .fadeIn(
              delay: Duration(milliseconds: 60 * widget.index),
              duration: 400.ms,
            )
            .slideY(
              begin: 0.3,
              end: 0,
              delay: Duration(milliseconds: 60 * widget.index),
              duration: 400.ms,
              curve: Curves.easeOut,
            ),
      ),
    );
  }
}

class _ColorDot extends StatelessWidget {
  final Color color;
  const _ColorDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.5), width: 1),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Animated background decoration
// ─────────────────────────────────────────────────────────────────────────────
class _BackgroundDecoration extends StatelessWidget {
  final HeroTheme theme;
  const _BackgroundDecoration({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -60,
          right: -60,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.primary.withOpacity(0.08),
            ),
          ),
        ),
        Positioned(
          bottom: 100,
          left: -40,
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.accent.withOpacity(0.06),
            ),
          ),
        ),
      ],
    );
  }
}
