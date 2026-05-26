import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../data/auth_provider.dart';
import '../data/user_provider.dart';
import '../theme/app_theme.dart';
import 'main_nav.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl    = TextEditingController();
  final _passCtrl     = TextEditingController();
  final _emailFocus   = FocusNode();
  final _passFocus    = FocusNode();
  bool _obscure       = true;
  bool _loading       = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _emailFocus.dispose();
    _passFocus.dispose();
    super.dispose();
  }

  // ── Validate ──────────────────────────────────────────────────────────────
  String? _validateEmail(String v) {
    if (v.trim().isEmpty) return 'Email is required';
    if (!v.contains('@') || !v.contains('.')) return 'Enter a valid email';
    return null;
  }

  String? _validatePass(String v) {
    if (v.isEmpty) return 'Password is required';
    if (v.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  // ── Login ─────────────────────────────────────────────────────────────────
  Future<void> _login() async {
    FocusScope.of(context).unfocus();
    final emailErr = _validateEmail(_emailCtrl.text);
    final passErr  = _validatePass(_passCtrl.text);

    if (emailErr != null) { _showSnack(emailErr, isError: true); return; }
    if (passErr  != null) { _showSnack(passErr,  isError: true); return; }

    setState(() => _loading = true);
    final auth = context.read<AuthProvider>();
    auth.clearError();

    final ok = await auth.signIn(
      email:    _emailCtrl.text.trim().toLowerCase(),
      password: _passCtrl.text,
    );

    if (!mounted) return;
    setState(() => _loading = false);

    if (ok) {
      HapticFeedback.mediumImpact();
      // Sync name + avatar from auth into UserProvider
      final user = context.read<UserProvider>();
      if (user.name.isEmpty && auth.user != null) {
        await user.setupProfile(
            name: auth.user!.name, avatar: auth.user!.avatar);
      }
      _goHome();
    } else {
      _showSnack(auth.error ?? 'Login failed', isError: true);
    }
  }

  // ── Guest ─────────────────────────────────────────────────────────────────
  Future<void> _guest() async {
    setState(() => _loading = true);
    final auth = context.read<AuthProvider>();
    await auth.continueAsGuest();

    if (!mounted) return;
    // Setup UserProvider with guest details
    final user = context.read<UserProvider>();
    await user.setupProfile(name: 'Guest Player', avatar: '🥷');
    setState(() => _loading = false);
    _goHome();
  }

  void _goHome() {
    Navigator.pushReplacement(context, PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 600),
      pageBuilder: (_, __, ___) => const MainNav(),
      transitionsBuilder: (_, anim, __, child) =>
          FadeTransition(opacity: anim, child: child),
    ));
  }

  void _showSnack(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg, style: GoogleFonts.poppins()),
      backgroundColor: isError ? AppTheme.error : AppTheme.success,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(16),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 36),

                // ── Logo + heading ─────────────────────────────────────────
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 90, height: 90,
                        decoration: BoxDecoration(
                          color: AppTheme.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                            child: Text('🏆',
                                style: TextStyle(fontSize: 46))),
                      )
                          .animate()
                          .scale(begin: const Offset(0, 0),
                              duration: 600.ms, curve: Curves.elasticOut),

                      const SizedBox(height: 16),

                      Text('Welcome Back!',
                        style: GoogleFonts.poppins(
                          fontSize: 28, fontWeight: FontWeight.w800,
                          color: AppTheme.textDark))
                          .animate().fadeIn(delay: 200.ms),

                      Text('Sign in to continue your journey',
                        style: GoogleFonts.poppins(
                            fontSize: 14, color: AppTheme.textLight))
                          .animate().fadeIn(delay: 300.ms),
                    ],
                  ),
                ),

                const SizedBox(height: 36),

                // ── Email ──────────────────────────────────────────────────
                _Label('Email'),
                const SizedBox(height: 8),
                _InputField(
                  controller: _emailCtrl,
                  focusNode: _emailFocus,
                  hint: 'your@email.com',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  onNext: () => FocusScope.of(context).requestFocus(_passFocus),
                ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2, end: 0),

                const SizedBox(height: 16),

                // ── Password ───────────────────────────────────────────────
                _Label('Password'),
                const SizedBox(height: 8),
                _InputField(
                  controller: _passCtrl,
                  focusNode: _passFocus,
                  hint: '••••••••',
                  icon: Icons.lock_outline_rounded,
                  obscure: _obscure,
                  suffix: IconButton(
                    icon: Icon(
                      _obscure ? Icons.visibility_off_outlined
                               : Icons.visibility_outlined,
                      color: AppTheme.textLight, size: 20,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                  onSubmit: _login,
                ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2, end: 0),

                const SizedBox(height: 28),

                // ── Login Button ───────────────────────────────────────────
                SizedBox(
                  width: double.infinity, height: 56,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    child: _loading
                        ? const SizedBox(width: 22, height: 22,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2.5))
                        : Text('Sign In',
                            style: GoogleFonts.poppins(
                              fontSize: 16, fontWeight: FontWeight.w700,
                              color: Colors.white)),
                  ),
                ).animate().fadeIn(delay: 600.ms),

                const SizedBox(height: 18),

                // ── Divider ────────────────────────────────────────────────
                Row(children: [
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Text('or', style: GoogleFonts.poppins(
                        color: AppTheme.textLight)),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                ]).animate().fadeIn(delay: 650.ms),

                const SizedBox(height: 18),

                // ── Guest Button ───────────────────────────────────────────
                SizedBox(
                  width: double.infinity, height: 56,
                  child: OutlinedButton.icon(
                    onPressed: _loading ? null : _guest,
                    icon: const Text('🥷', style: TextStyle(fontSize: 20)),
                    label: Text('Continue as Guest',
                      style: GoogleFonts.poppins(
                        fontSize: 15, fontWeight: FontWeight.w600,
                        color: AppTheme.textDark)),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey.shade300, width: 2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ).animate().fadeIn(delay: 700.ms),

                const SizedBox(height: 12),

                // ── Guest warning ──────────────────────────────────────────
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.amber.shade200),
                  ),
                  child: Row(
                    children: [
                      const Text('⚠️', style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Guest progress is not saved permanently. Create an account to keep your progress!',
                          style: GoogleFonts.poppins(
                              fontSize: 11, color: Colors.amber.shade900),
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 750.ms),

                const SizedBox(height: 28),

                // ── Sign up link ───────────────────────────────────────────
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.push(context, PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 400),
                      pageBuilder: (_, __, ___) => const SignupScreen(),
                      transitionsBuilder: (_, anim, __, child) =>
                          SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(1, 0), end: Offset.zero,
                            ).animate(CurvedAnimation(
                                parent: anim, curve: Curves.easeOut)),
                            child: child,
                          ),
                    )),
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: GoogleFonts.poppins(color: AppTheme.textLight),
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: GoogleFonts.poppins(
                              color: AppTheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ).animate().fadeIn(delay: 800.ms),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Shared widgets ────────────────────────────────────────────────────────────
class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);
  @override
  Widget build(BuildContext context) => Text(text,
    style: GoogleFonts.poppins(
        fontWeight: FontWeight.w600, fontSize: 13, color: AppTheme.textDark));
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String hint;
  final IconData icon;
  final bool obscure;
  final TextInputType? keyboardType;
  final Widget? suffix;
  final VoidCallback? onNext;
  final VoidCallback? onSubmit;

  const _InputField({
    required this.controller,
    this.focusNode,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.keyboardType,
    this.suffix,
    this.onNext,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscure,
      keyboardType: keyboardType,
      textInputAction: onSubmit != null
          ? TextInputAction.done
          : TextInputAction.next,
      onSubmitted: (_) {
        if (onSubmit != null) onSubmit!();
        else if (onNext != null) onNext!();
      },
      style: GoogleFonts.poppins(fontSize: 15),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(color: AppTheme.textLight),
        prefixIcon: Icon(icon, color: AppTheme.textLight, size: 20),
        suffixIcon: suffix,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppTheme.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 16),
      ),
    );
  }
}
