import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../data/theme_provider.dart';
import '../theme/app_theme.dart';

class ThemePickerScreen extends StatefulWidget {
  const ThemePickerScreen({super.key});

  @override
  State<ThemePickerScreen> createState() => _ThemePickerScreenState();
}

class _ThemePickerScreenState extends State<ThemePickerScreen> {
  String _previewId = '';

  @override
  void initState() {
    super.initState();
    _previewId = context.read<ThemeProvider>().id;
  }

  @override
  Widget build(BuildContext context) {
    final tp = context.watch<ThemeProvider>();
    final themes = AppThemes.all;
    final preview = AppThemes.fromId(_previewId);

    return Scaffold(
      backgroundColor: preview.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ─────────────────────────────────────────────────────
            _buildHeader(context, tp, preview),

            // ── Live preview card ──────────────────────────────────────────
            _buildPreviewCard(preview),

            const SizedBox(height: 16),

            // ── Theme grid ─────────────────────────────────────────────────
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: themes.length,
                itemBuilder: (_, i) => _ThemeCard(
                  theme: themes[i],
                  isSelected: themes[i].id == tp.id,
                  isPreviewing: themes[i].id == _previewId,
                  isLocked: themes[i].isLocked,
                  onPreview: () {
                    HapticFeedback.selectionClick();
                    setState(() => _previewId = themes[i].id);
                  },
                  onSelect: () async {
                    if (themes[i].isLocked) {
                      HapticFeedback.heavyImpact();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '🔒 ${themes[i].name} is locked! Complete more challenges to unlock.',
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                          ),
                          backgroundColor: Colors.grey.shade800,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          margin: const EdgeInsets.all(16),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                      return;
                    }
                    HapticFeedback.mediumImpact();
                    await context.read<ThemeProvider>().setTheme(themes[i].id);
                    setState(() => _previewId = themes[i].id);
                    if (context.mounted) {
                      _showAppliedSnack(context, themes[i]);
                    }
                  },
                ).animate().fadeIn(
                      delay: Duration(milliseconds: 60 * i),
                      duration: 350.ms,
                    ).scale(begin: const Offset(0.9, 0.9)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeProvider tp, AppThemeData preview) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      decoration: BoxDecoration(
        color: preview.secondary,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white, size: 18),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose Your Theme',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Active: ${tp.current.name} ${tp.current.hero}',
                  style: GoogleFonts.poppins(
                      fontSize: 12, color: Colors.white54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewCard(AppThemeData preview) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [preview.primary, preview.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: preview.primary.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          // Hero emoji
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              preview.hero,
              key: ValueKey(preview.id),
              style: const TextStyle(fontSize: 56),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    preview.name,
                    key: ValueKey('name_${preview.id}'),
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    '"${preview.tagline}"',
                    key: ValueKey('tag_${preview.id}'),
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 2,
                  ),
                ),
                const SizedBox(height: 10),
                // Color palette dots
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: Row(
                    key: ValueKey('colors_${preview.id}'),
                    children: [
                      preview.primary,
                      preview.accent,
                      preview.extra1,
                      preview.extra2,
                      preview.secondary,
                    ].map((c) => Container(
                      width: 18, height: 18,
                      margin: const EdgeInsets.only(right: 6),
                      decoration: BoxDecoration(
                        color: c,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.white.withOpacity(0.5), width: 1.5),
                      ),
                    )).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAppliedSnack(BuildContext context, AppThemeData theme) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${theme.hero} ${theme.name} theme applied!',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: theme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

// ── Individual theme card ─────────────────────────────────────────────────────
class _ThemeCard extends StatelessWidget {
  final AppThemeData theme;
  final bool isSelected;
  final bool isPreviewing;
  final bool isLocked;
  final VoidCallback onPreview;
  final VoidCallback onSelect;

  const _ThemeCard({
    required this.theme,
    required this.isSelected,
    required this.isPreviewing,
    required this.isLocked,
    required this.onPreview,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLocked ? onSelect : onPreview,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          gradient: !isLocked && (isPreviewing || isSelected)
              ? LinearGradient(
                  colors: [theme.primary, theme.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isLocked
              ? Colors.grey.shade100
              : isPreviewing || isSelected
                  ? null
                  : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isLocked
                ? Colors.grey.shade300
                : isSelected
                    ? theme.accent
                    : isPreviewing
                        ? theme.primary
                        : Colors.grey.shade200,
            width: isSelected ? 3 : isPreviewing ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isLocked
                  ? Colors.black.withOpacity(0.03)
                  : isPreviewing || isSelected
                      ? theme.primary.withOpacity(0.35)
                      : Colors.black.withOpacity(0.05),
              blurRadius: isPreviewing ? 16 : 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background decoration
            Positioned(
              right: -10, bottom: -10,
              child: Text(
                isLocked ? '🔒' : theme.hero,
                style: TextStyle(
                  fontSize: 60,
                  color: isLocked
                      ? Colors.grey.withOpacity(0.15)
                      : isPreviewing || isSelected
                          ? Colors.white.withOpacity(0.15)
                          : Colors.grey.withOpacity(0.1),
                ),
              ),
            ),

            // Locked overlay
            if (isLocked)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero + selected/locked badge
                  Row(
                    children: [
                      ColorFiltered(
                        colorFilter: isLocked
                            ? const ColorFilter.matrix([
                                0.2126, 0.7152, 0.0722, 0, 0,
                                0.2126, 0.7152, 0.0722, 0, 0,
                                0.2126, 0.7152, 0.0722, 0, 0,
                                0,      0,      0,      1, 0,
                              ])
                            : const ColorFilter.mode(
                                Colors.transparent, BlendMode.saturation),
                        child: Text(theme.hero,
                            style: const TextStyle(fontSize: 30)),
                      ),
                      const Spacer(),
                      if (isLocked)
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.lock_rounded,
                              color: Colors.white, size: 12),
                        )
                      else if (isSelected)
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: theme.accent,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.check_rounded,
                              color: Colors.white, size: 12),
                        ),
                    ],
                  ),
                  const Spacer(),

                  // Name
                  Text(
                    theme.name,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: isLocked
                          ? Colors.grey.shade400
                          : isPreviewing || isSelected
                              ? Colors.white
                              : AppTheme.textDark,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Description
                  Text(
                    isLocked ? 'Coming soon...' : theme.description,
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: isLocked
                          ? Colors.grey.shade400
                          : isPreviewing || isSelected
                              ? Colors.white60
                              : AppTheme.textLight,
                    ),
                    maxLines: 1,
                  ),

                  const SizedBox(height: 8),

                  // Color dots row (greyed out if locked)
                  Row(
                    children: [theme.primary, theme.accent, theme.extra1]
                        .map((c) => Container(
                              width: 14, height: 14,
                              margin: const EdgeInsets.only(right: 4),
                              decoration: BoxDecoration(
                                color: isLocked ? Colors.grey.shade300 : c,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isLocked
                                      ? Colors.grey.shade200
                                      : isPreviewing || isSelected
                                          ? Colors.white30
                                          : Colors.grey.shade300,
                                ),
                              ),
                            ))
                        .toList(),
                    ),

                  const SizedBox(height: 8),

                  // Lock / Apply button
                  GestureDetector(
                    onTap: isSelected ? null : onSelect,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: isLocked
                            ? Colors.grey.shade200
                            : isSelected
                                ? theme.accent.withOpacity(0.3)
                                : isPreviewing
                                    ? Colors.white.withOpacity(0.2)
                                    : theme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isLocked
                              ? Colors.grey.shade300
                              : isSelected
                                  ? theme.accent
                                  : isPreviewing
                                      ? Colors.white30
                                      : theme.primary.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        isLocked ? '🔒 Locked' : isSelected ? '✓ Active' : 'Apply',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: isLocked
                              ? Colors.grey.shade400
                              : isSelected
                                  ? (isPreviewing ? Colors.white : theme.accent)
                              : isPreviewing
                                  ? Colors.white
                                  : theme.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
