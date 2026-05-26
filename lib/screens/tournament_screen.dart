import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';

class TournamentScreen extends StatefulWidget {
  const TournamentScreen({super.key});

  @override
  State<TournamentScreen> createState() => _TournamentScreenState();
}

class _TournamentScreenState extends State<TournamentScreen>
    with TickerProviderStateMixin {
  // ── Countdown target ───────────────────────────────────────────────────
  // Set to 30 days from now for demo; change to your real launch date
  final DateTime _launchDate =
      DateTime.now().add(const Duration(days: 30));

  Duration _remaining = Duration.zero;
  Timer? _countdownTimer;
  bool _registered = false;
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();

  // Animated particles
  late AnimationController _particleCtrl;
  late AnimationController _pulseCtrl;
  late AnimationController _rotateCtrl;

  // Fake registered count
  int _registeredCount = 1247;

  @override
  void initState() {
    super.initState();
    _loadRegistration();
    _startCountdown();

    _particleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _rotateCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  Future<void> _loadRegistration() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _registered = prefs.getBool('tournament_registered') ?? false;
      _nameCtrl.text = prefs.getString('tournament_name') ?? '';
      _emailCtrl.text = prefs.getString('tournament_email') ?? '';
    });
  }

  void _startCountdown() {
    _updateRemaining();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateRemaining();
    });
  }

  void _updateRemaining() {
    final now = DateTime.now();
    final diff = _launchDate.difference(now);
    if (mounted) {
      setState(() {
        _remaining = diff.isNegative ? Duration.zero : diff;
      });
    }
  }

  Future<void> _register() async {
    if (_nameCtrl.text.trim().isEmpty || _emailCtrl.text.trim().isEmpty) {
      _showSnack('Please enter your name and email', isError: true);
      return;
    }
    if (!_emailCtrl.text.contains('@')) {
      _showSnack('Please enter a valid email', isError: true);
      return;
    }
    HapticFeedback.mediumImpact();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('tournament_registered', true);
    await prefs.setString('tournament_name', _nameCtrl.text.trim());
    await prefs.setString('tournament_email', _emailCtrl.text.trim());
    setState(() {
      _registered = true;
      _registeredCount++;
    });
    _showSnack('You\'re registered! 🎉 We\'ll notify you at launch.');
  }

  void _showSnack(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: GoogleFonts.poppins()),
        backgroundColor: isError ? AppTheme.error : AppTheme.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _particleCtrl.dispose();
    _pulseCtrl.dispose();
    _rotateCtrl.dispose();
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  String _pad(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final days = _remaining.inDays;
    final hours = _remaining.inHours % 24;
    final mins = _remaining.inMinutes % 60;
    final secs = _remaining.inSeconds % 60;

    return Scaffold(
      backgroundColor: AppTheme.secondary,
      body: Stack(
        children: [
          // ── Animated background particles ──────────────────────────────
          ..._buildParticles(),

          // ── Rotating ring decoration ───────────────────────────────────
          _buildRotatingRing(),

          // ── Main content ───────────────────────────────────────────────
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // ── Badge ──────────────────────────────────────────────
                    _buildBadge(),
                    const SizedBox(height: 20),

                    // ── Trophy + Title ─────────────────────────────────────
                    _buildTitle(),
                    const SizedBox(height: 32),

                    // ── Countdown ──────────────────────────────────────────
                    _buildCountdown(days, hours, mins, secs),
                    const SizedBox(height: 32),

                    // ── How it works ───────────────────────────────────────
                    _buildHowItWorks(),
                    const SizedBox(height: 28),

                    // ── Feature cards ──────────────────────────────────────
                    _buildFeatureCards(),
                    const SizedBox(height: 28),

                    // ── Registered count ───────────────────────────────────
                    _buildRegisteredCount(),
                    const SizedBox(height: 28),

                    // ── Registration form / success ────────────────────────
                    _registered
                        ? _buildRegisteredSuccess()
                        : _buildRegistrationForm(),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Particles ────────────────────────────────────────────────────────────
  List<Widget> _buildParticles() {
    final rng = Random(42);
    return List.generate(18, (i) {
      final x = rng.nextDouble();
      final y = rng.nextDouble();
      final size = rng.nextDouble() * 6 + 3;
      final colors = [
        AppTheme.primary,
        AppTheme.accent,
        AppTheme.purple,
        AppTheme.teal,
        Colors.white24,
      ];
      return AnimatedBuilder(
        animation: _particleCtrl,
        builder: (_, __) {
          final t = (_particleCtrl.value + i / 18) % 1.0;
          final opacity = (sin(t * pi) * 0.6 + 0.1).clamp(0.0, 1.0);
          return Positioned(
            left: MediaQuery.of(context).size.width * x,
            top: MediaQuery.of(context).size.height *
                ((y + _particleCtrl.value * 0.3) % 1.0),
            child: Opacity(
              opacity: opacity,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: colors[i % colors.length],
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
        },
      );
    });
  }

  // ── Rotating ring ────────────────────────────────────────────────────────
  Widget _buildRotatingRing() {
    return Positioned(
      top: -60,
      right: -60,
      child: AnimatedBuilder(
        animation: _rotateCtrl,
        builder: (_, child) => Transform.rotate(
          angle: _rotateCtrl.value * 2 * pi,
          child: child,
        ),
        child: Container(
          width: 220,
          height: 220,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppTheme.primary.withOpacity(0.15),
              width: 2,
            ),
          ),
          child: Center(
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.accent.withOpacity(0.1),
                  width: 2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Badge ────────────────────────────────────────────────────────────────
  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.primary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.primary.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _pulseCtrl,
            builder: (_, __) => Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: AppTheme.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary
                        .withOpacity(0.4 + _pulseCtrl.value * 0.4),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'COMING SOON',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppTheme.primary,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 500.ms)
        .slideY(begin: -0.3, end: 0);
  }

  // ── Title ────────────────────────────────────────────────────────────────
  Widget _buildTitle() {
    return Column(
      children: [
        AnimatedBuilder(
          animation: _pulseCtrl,
          builder: (_, child) => Transform.scale(
            scale: 1.0 + _pulseCtrl.value * 0.05,
            child: child,
          ),
          child: const Text('🏆', style: TextStyle(fontSize: 72)),
        )
            .animate()
            .scale(
              begin: const Offset(0, 0),
              duration: 700.ms,
              curve: Curves.elasticOut,
            ),
        const SizedBox(height: 16),
        Text(
          'Quiz Tournament',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 34,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: -1,
          ),
        )
            .animate()
            .fadeIn(delay: 200.ms, duration: 500.ms)
            .slideY(begin: 0.3, end: 0),
        const SizedBox(height: 10),
        Text(
          '2 players · Same questions · Same time\nFirst to answer correctly wins! ⚡',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.white60,
            height: 1.5,
          ),
        )
            .animate()
            .fadeIn(delay: 350.ms, duration: 500.ms),
      ],
    );
  }

  // ── Countdown ────────────────────────────────────────────────────────────
  Widget _buildCountdown(int d, int h, int m, int s) {
    return Column(
      children: [
        Text(
          'LAUNCHING IN',
          style: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: Colors.white38,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _CountdownUnit(value: _pad(d), label: 'DAYS', color: AppTheme.primary),
            _CountdownSeparator(),
            _CountdownUnit(value: _pad(h), label: 'HRS', color: AppTheme.purple),
            _CountdownSeparator(),
            _CountdownUnit(value: _pad(m), label: 'MINS', color: AppTheme.teal),
            _CountdownSeparator(),
            _CountdownUnit(value: _pad(s), label: 'SECS', color: AppTheme.accent),
          ],
        ),
      ],
    ).animate().fadeIn(delay: 400.ms, duration: 500.ms);
  }

  // ── How it works ─────────────────────────────────────────────────────────
  Widget _buildHowItWorks() {
    final steps = [
      ('1️⃣', 'Register', 'Sign up below to join the waitlist'),
      ('2️⃣', 'Match', 'Get matched with an opponent of similar level'),
      ('3️⃣', 'Battle', '10 questions · 10 sec each · Same time'),
      ('4️⃣', 'Win', 'Most correct answers fastest wins 💎 Diamonds'),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How It Works',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          ...steps.asMap().entries.map((e) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(e.value.$1, style: const TextStyle(fontSize: 22)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.value.$2,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          e.value.$3,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(
                  delay: Duration(milliseconds: 500 + 100 * e.key),
                  duration: 400.ms,
                );
          }),
        ],
      ),
    ).animate().fadeIn(delay: 450.ms, duration: 500.ms);
  }

  // ── Feature cards ────────────────────────────────────────────────────────
  Widget _buildFeatureCards() {
    final features = [
      (Icons.bolt_rounded, 'Real-time', '10 sec per question', AppTheme.primary),
      (Icons.people_rounded, '1v1 Battle', 'Head to head duels', AppTheme.purple),
      (Icons.emoji_events_rounded, 'Prizes', 'Top players win diamonds', AppTheme.accent),
      (Icons.shield_rounded, 'Fair Play', 'Same questions, same time', AppTheme.teal),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: features.length,
      itemBuilder: (_, i) {
        final f = features[i];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: f.$4.withOpacity(0.12),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: f.$4.withOpacity(0.25)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(f.$1, color: f.$4, size: 26),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    f.$2,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    f.$3,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ).animate().fadeIn(
              delay: Duration(milliseconds: 600 + 80 * i),
              duration: 400.ms,
            )
            .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1));
      },
    );
  }

  // ── Registered count ─────────────────────────────────────────────────────
  Widget _buildRegisteredCount() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primary.withOpacity(0.2),
            AppTheme.purple.withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primary.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🔥', style: TextStyle(fontSize: 24)),
          const SizedBox(width: 10),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$_registeredCount ',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w800,
                    fontSize: 22,
                    color: AppTheme.primary,
                  ),
                ),
                TextSpan(
                  text: 'players already registered!',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 700.ms, duration: 500.ms);
  }

  // ── Registration form ────────────────────────────────────────────────────
  Widget _buildRegistrationForm() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.07),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('📋', style: TextStyle(fontSize: 24)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Register for Early Access',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Be first to know when we launch',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Name field
          _TournamentField(
            controller: _nameCtrl,
            hint: 'Your name',
            icon: Icons.person_outline_rounded,
          ),
          const SizedBox(height: 12),

          // Email field
          _TournamentField(
            controller: _emailCtrl,
            hint: 'Your email',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),

          // Perks
          _buildPerk('🎁', 'Early access when launched'),
          _buildPerk('💎', '+50 bonus diamonds on launch day'),
          _buildPerk('🏆', 'Exclusive "Founder" badge in tournaments'),
          const SizedBox(height: 20),

          // Register button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _register,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: Text(
                'Notify Me at Launch 🚀',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 800.ms, duration: 500.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _buildPerk(String emoji, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 10),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  // ── Registered success ───────────────────────────────────────────────────
  Widget _buildRegisteredSuccess() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.success.withOpacity(0.15),
            AppTheme.teal.withOpacity(0.15),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.success.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          const Text('🎉', style: TextStyle(fontSize: 52))
              .animate()
              .scale(
                begin: const Offset(0, 0),
                duration: 600.ms,
                curve: Curves.elasticOut,
              ),
          const SizedBox(height: 16),
          Text(
            'You\'re on the list!',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Hey ${_nameCtrl.text.trim().split(' ').first} 👋\nWe\'ll email you at ${_emailCtrl.text.trim()} the moment tournaments go live!',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.white60,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 24),

          // Perks confirmed
          _SuccessPerk(emoji: '💎', label: '+50 Diamonds', sublabel: 'Credited on launch day'),
          const SizedBox(height: 10),
          _SuccessPerk(emoji: '🏆', label: 'Founder Badge', sublabel: 'Exclusive tournament badge'),
          const SizedBox(height: 10),
          _SuccessPerk(emoji: '⚡', label: 'Early Access', sublabel: 'Before public release'),

          const SizedBox(height: 24),

          // Share hype
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              _showSnack('Share feature coming with the tournament! 🎯');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white24),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.share_rounded, color: Colors.white70, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'Invite friends',
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).scale(
          begin: const Offset(0.95, 0.95),
          end: const Offset(1, 1),
        );
  }
}

// ── Sub-widgets ─────────────────────────────────────────────────────────────

class _CountdownUnit extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _CountdownUnit({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, anim) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -0.5),
              end: Offset.zero,
            ).animate(anim),
            child: FadeTransition(opacity: anim, child: child),
          ),
          child: Container(
            key: ValueKey(value),
            width: 66,
            height: 66,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withOpacity(0.3), width: 1.5),
            ),
            child: Center(
              child: Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: color,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Colors.white38,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}

class _CountdownSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 4, right: 4),
      child: Text(
        ':',
        style: GoogleFonts.poppins(
          fontSize: 26,
          fontWeight: FontWeight.w900,
          color: Colors.white24,
        ),
      ),
    );
  }
}

class _TournamentField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final TextInputType? keyboardType;

  const _TournamentField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(color: Colors.white38, fontSize: 14),
        prefixIcon: Icon(icon, color: Colors.white38, size: 20),
        filled: true,
        fillColor: Colors.white.withOpacity(0.08),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.white12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.white12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppTheme.primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}

class _SuccessPerk extends StatelessWidget {
  final String emoji;
  final String label;
  final String sublabel;

  const _SuccessPerk({
    required this.emoji,
    required this.label,
    required this.sublabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.07),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
              Text(
                sublabel,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.check_circle_rounded,
              color: AppTheme.success, size: 20),
        ],
      ),
    );
  }
}
