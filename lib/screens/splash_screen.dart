import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/auth_provider.dart';
import '../widgets/themed_widgets.dart';
import 'main_nav.dart';
import 'onboarding_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this,
        duration: const Duration(seconds: 2));
    _ctrl.forward();
    Future.delayed(const Duration(milliseconds: 2800), _navigate);
  }

  Future<void> _navigate() async {
    if (!mounted) return;
    final auth   = context.read<AuthProvider>();
    final prefs  = await SharedPreferences.getInstance();
    final onboardingDone = prefs.getBool('onboarding_done') ?? false;

    Widget next;
    if (!onboardingDone)    next = const OnboardingScreen();
    else if (auth.isLoggedIn) next = const MainNav();
    else                     next = const LoginScreen();

    if (!mounted) return;
    Navigator.pushReplacement(context, PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) => next,
      transitionsBuilder: (_, anim, __, child) =>
          FadeTransition(opacity: anim, child: child),
    ));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return ThScaffold(
      useDarkBg: true,
      showPattern: true,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Hero emoji — big and bouncy
              Text('🎯', style: const TextStyle(fontSize: 90))
                  .animate()
                  .scale(begin: const Offset(0, 0),
                      duration: 700.ms, curve: Curves.elasticOut)
                  .then().shake(duration: 300.ms),

              const SizedBox(height: 20),

              ThText('Quiz Master',
                  fontSize: 40, fontWeight: FontWeight.w900,
                  color: Colors.white)
                  .animate().fadeIn(delay: 400.ms, duration: 500.ms)
                  .slideY(begin: 0.3, end: 0),

              const SizedBox(height: 8),

              // Theme tagline
              ThText('"${'Test Your Knowledge'}"',
                  fontSize: 13, color: Colors.white54)
                  .animate().fadeIn(delay: 600.ms),

              const SizedBox(height: 6),

              ThText('Play · Learn · Grow',
                  fontSize: 13, color: Colors.white38,
                  letterSpacing: 2)
                  .animate().fadeIn(delay: 700.ms),

              const Spacer(),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: const Duration(milliseconds: 2400),
                        builder: (_, val, __) => LinearProgressIndicator(
                          value: val,
                          backgroundColor: Colors.white12,
                          valueColor: AlwaysStoppedAnimation(AppTheme.primary),
                          minHeight: 4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    ThText('Loading your experience...',
                        fontSize: 12, color: Colors.white30)
                        .animate().fadeIn(delay: 800.ms),
                  ],
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
