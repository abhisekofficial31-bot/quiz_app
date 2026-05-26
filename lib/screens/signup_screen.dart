import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../data/auth_provider.dart';
import '../data/user_provider.dart';
import '../theme/app_theme.dart';
import 'login_screen.dart';
import 'main_nav.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameCtrl    = TextEditingController();
  final _emailCtrl   = TextEditingController();
  final _passCtrl    = TextEditingController();
  final _confirmCtrl = TextEditingController();
  final _nameFocus   = FocusNode();
  final _emailFocus  = FocusNode();
  final _passFocus   = FocusNode();
  final _confFocus   = FocusNode();

  bool _obscure      = true;
  bool _loading      = false;
  int  _step         = 0; // 0 = details, 1 = avatar
  String _selectedAvatar = '🧑';

  @override
  void dispose() {
    _nameCtrl.dispose(); _emailCtrl.dispose();
    _passCtrl.dispose(); _confirmCtrl.dispose();
    _nameFocus.dispose(); _emailFocus.dispose();
    _passFocus.dispose(); _confFocus.dispose();
    super.dispose();
  }

  // ── Validate step 1 ───────────────────────────────────────────────────────
  String? _validateStep1() {
    if (_nameCtrl.text.trim().isEmpty)
      return 'Please enter your name';
    if (_nameCtrl.text.trim().length < 2)
      return 'Name must be at least 2 characters';
    if (_emailCtrl.text.trim().isEmpty)
      return 'Please enter your email';
    if (!_emailCtrl.text.contains('@') || !_emailCtrl.text.contains('.'))
      return 'Please enter a valid email';
    if (_passCtrl.text.isEmpty)
      return 'Please enter a password';
    if (_passCtrl.text.length < 6)
      return 'Password must be at least 6 characters';
    if (_confirmCtrl.text.isEmpty)
      return 'Please confirm your password';
    if (_passCtrl.text != _confirmCtrl.text)
      return 'Passwords do not match';
    return null;
  }

  // ── Sign up ───────────────────────────────────────────────────────────────
  Future<void> _signUp() async {
    FocusScope.of(context).unfocus();
    setState(() => _loading = true);

    final auth = context.read<AuthProvider>();
    auth.clearError();

    final ok = await auth.signUp(
      name:     _nameCtrl.text.trim(),
      email:    _emailCtrl.text.trim().toLowerCase(),
      password: _passCtrl.text,
      avatar:   _selectedAvatar,
    );

    if (!mounted) return;
    setState(() => _loading = false);

    if (ok) {
      HapticFeedback.mediumImpact();
      // Set UserProvider with name + avatar (0 diamonds, fresh start)
      final user = context.read<UserProvider>();
      await user.setupProfile(
          name: _nameCtrl.text.trim(), avatar: _selectedAvatar);

      _showSnack('Account created! Welcome 🎉');

      await Future.delayed(const Duration(milliseconds: 600));
      if (!mounted) return;

      Navigator.pushReplacement(context, PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (_, __, ___) => const MainNav(),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
      ));
    } else {
      _showSnack(auth.error ?? 'Sign up failed', isError: true);
    }
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
                const SizedBox(height: 20),

                // Back button
                GestureDetector(
                  onTap: () {
                    if (_step == 1) setState(() => _step = 0);
                    else Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(
                          color: Colors.black.withOpacity(0.06), blurRadius: 8)],
                    ),
                    child: const Icon(
                        Icons.arrow_back_ios_new_rounded, size: 18),
                  ),
                ),

                const SizedBox(height: 24),

                // Title
                Text(
                  _step == 0 ? 'Create Account' : 'Pick Your Avatar',
                  style: GoogleFonts.poppins(
                    fontSize: 28, fontWeight: FontWeight.w800,
                    color: AppTheme.textDark),
                ).animate(key: ValueKey('title$_step'))
                 .fadeIn(duration: 300.ms),

                Text(
                  _step == 0
                      ? 'Start your learning journey today!'
                      : 'Choose an avatar that represents you',
                  style: GoogleFonts.poppins(
                      fontSize: 14, color: AppTheme.textLight),
                ).animate(key: ValueKey('sub$_step')).fadeIn(duration: 300.ms),

                const SizedBox(height: 24),

                // Step indicator
                _StepIndicator(current: _step),
                const SizedBox(height: 28),

                // Content
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  transitionBuilder: (child, anim) => SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.15, 0), end: Offset.zero,
                    ).animate(CurvedAnimation(
                        parent: anim, curve: Curves.easeOut)),
                    child: FadeTransition(opacity: anim, child: child),
                  ),
                  child: _step == 0
                      ? _buildDetailsForm()
                      : _buildAvatarPicker(),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Step 1: Details ───────────────────────────────────────────────────────
  Widget _buildDetailsForm() {
    return Column(
      key: const ValueKey('details'),
      children: [
        // Name
        _FieldLabel('Full Name'),
        const SizedBox(height: 8),
        _Field(
          ctrl: _nameCtrl, focus: _nameFocus,
          hint: 'John Doe', icon: Icons.person_outline_rounded,
          action: TextInputAction.next,
          onNext: () => FocusScope.of(context).requestFocus(_emailFocus),
        ),
        const SizedBox(height: 14),

        // Email
        _FieldLabel('Email'),
        const SizedBox(height: 8),
        _Field(
          ctrl: _emailCtrl, focus: _emailFocus,
          hint: 'your@email.com', icon: Icons.email_outlined,
          type: TextInputType.emailAddress,
          action: TextInputAction.next,
          onNext: () => FocusScope.of(context).requestFocus(_passFocus),
        ),
        const SizedBox(height: 14),

        // Password
        _FieldLabel('Password'),
        const SizedBox(height: 8),
        _Field(
          ctrl: _passCtrl, focus: _passFocus,
          hint: 'Min 6 characters', icon: Icons.lock_outline_rounded,
          obscure: _obscure,
          action: TextInputAction.next,
          onNext: () => FocusScope.of(context).requestFocus(_confFocus),
          suffix: IconButton(
            icon: Icon(
              _obscure ? Icons.visibility_off_outlined
                       : Icons.visibility_outlined,
              color: AppTheme.textLight, size: 20,
            ),
            onPressed: () => setState(() => _obscure = !_obscure),
          ),
        ),
        const SizedBox(height: 14),

        // Confirm password
        _FieldLabel('Confirm Password'),
        const SizedBox(height: 8),
        _Field(
          ctrl: _confirmCtrl, focus: _confFocus,
          hint: 'Repeat password', icon: Icons.lock_outline_rounded,
          obscure: _obscure,
          action: TextInputAction.done,
        ),

        const SizedBox(height: 28),

        // Password strength indicator
        if (_passCtrl.text.isNotEmpty)
          _PasswordStrength(password: _passCtrl.text),

        const SizedBox(height: 20),

        SizedBox(
          width: double.infinity, height: 56,
          child: ElevatedButton(
            onPressed: () {
              final err = _validateStep1();
              if (err != null) { _showSnack(err, isError: true); return; }
              setState(() => _step = 1);
            },
            child: Text('Next: Choose Avatar →',
              style: GoogleFonts.poppins(
                fontSize: 16, fontWeight: FontWeight.w700,
                color: Colors.white)),
          ),
        ),

        const SizedBox(height: 18),

        Center(
          child: GestureDetector(
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            ),
            child: RichText(
              text: TextSpan(
                text: 'Already have an account? ',
                style: GoogleFonts.poppins(color: AppTheme.textLight),
                children: [TextSpan(
                  text: 'Sign In',
                  style: GoogleFonts.poppins(
                    color: AppTheme.primary, fontWeight: FontWeight.w700),
                )],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Step 2: Avatar picker ─────────────────────────────────────────────────
  Widget _buildAvatarPicker() {
    return Column(
      key: const ValueKey('avatar'),
      children: [
        // Preview
        Center(
          child: Container(
            width: 100, height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.primary.withOpacity(0.1),
              border: Border.all(color: AppTheme.primary, width: 3),
            ),
            child: Center(child: Text(_selectedAvatar,
                style: const TextStyle(fontSize: 52))),
          ).animate().scale(begin: const Offset(0.8, 0.8),
              duration: 400.ms, curve: Curves.elasticOut),
        ),

        const SizedBox(height: 8),
        Text('Tap to select', style: GoogleFonts.poppins(
            fontSize: 12, color: AppTheme.textLight)),

        const SizedBox(height: 20),

        // Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, childAspectRatio: 1,
            crossAxisSpacing: 12, mainAxisSpacing: 12,
          ),
          itemCount: AuthProvider.avatars.length,
          itemBuilder: (_, i) {
            final av = AuthProvider.avatars[i];
            final isSelected = av == _selectedAvatar;
            return GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                setState(() => _selectedAvatar = av);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.primary.withOpacity(0.12)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.primary : Colors.grey.shade200,
                    width: isSelected ? 2.5 : 1.5,
                  ),
                  boxShadow: isSelected
                      ? [BoxShadow(
                          color: AppTheme.primary.withOpacity(0.2),
                          blurRadius: 8)]
                      : [],
                ),
                child: Center(child: Text(av,
                    style: const TextStyle(fontSize: 32))),
              ),
            );
          },
        ),

        const SizedBox(height: 24),

        // Benefits box
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.success.withOpacity(0.06),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.success.withOpacity(0.2)),
          ),
          child: Column(
            children: [
              _Benefit('🎯', 'Start with 0 diamonds — earn them by playing!'),
              const SizedBox(height: 8),
              _Benefit('🔥', 'Build your streak by playing daily'),
              const SizedBox(height: 8),
              _Benefit('🏅', 'Unlock achievements and level up'),
            ],
          ),
        ),

        const SizedBox(height: 20),

        SizedBox(
          width: double.infinity, height: 56,
          child: ElevatedButton(
            onPressed: _loading ? null : _signUp,
            child: _loading
                ? const SizedBox(width: 22, height: 22,
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2.5))
                : Text('Create Account 🎉',
                    style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w700,
                      color: Colors.white)),
          ),
        ),
      ],
    );
  }
}

// ── Sub-widgets ───────────────────────────────────────────────────────────────

class _StepIndicator extends StatelessWidget {
  final int current;
  const _StepIndicator({required this.current});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Dot(n: 1, active: true, done: current > 0),
        Expanded(child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          height: 3,
          decoration: BoxDecoration(
            color: current > 0 ? AppTheme.primary : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(2),
          ),
        )),
        _Dot(n: 2, active: current >= 1, done: false),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  final int n;
  final bool active, done;
  const _Dot({required this.n, required this.active, required this.done});

  @override
  Widget build(BuildContext context) => AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    width: 34, height: 34,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: active ? AppTheme.primary : Colors.grey.shade200,
    ),
    child: Center(child: done
        ? const Icon(Icons.check_rounded, size: 18, color: Colors.white)
        : Text('$n', style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            color: active ? Colors.white : AppTheme.textLight,
            fontSize: 14))),
  );
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);
  @override
  Widget build(BuildContext context) => Text(text,
    style: GoogleFonts.poppins(
        fontWeight: FontWeight.w600, fontSize: 13, color: AppTheme.textDark));
}

class _Field extends StatelessWidget {
  final TextEditingController ctrl;
  final FocusNode? focus;
  final String hint;
  final IconData icon;
  final bool obscure;
  final TextInputType? type;
  final TextInputAction? action;
  final VoidCallback? onNext;
  final Widget? suffix;

  const _Field({
    required this.ctrl, this.focus, required this.hint, required this.icon,
    this.obscure = false, this.type, this.action, this.onNext, this.suffix,
  });

  @override
  Widget build(BuildContext context) => TextField(
    controller: ctrl, focusNode: focus,
    obscureText: obscure, keyboardType: type,
    textInputAction: action,
    onSubmitted: (_) { if (onNext != null) onNext!(); },
    style: GoogleFonts.poppins(fontSize: 15),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.poppins(color: AppTheme.textLight),
      prefixIcon: Icon(icon, color: AppTheme.textLight, size: 20),
      suffixIcon: suffix,
      filled: true, fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade200)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade200)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppTheme.primary, width: 2)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
  );
}

class _PasswordStrength extends StatelessWidget {
  final String password;
  const _PasswordStrength({required this.password});

  int get _strength {
    if (password.length < 6) return 1;
    int score = 0;
    if (password.length >= 8) score++;
    if (password.contains(RegExp(r'[A-Z]'))) score++;
    if (password.contains(RegExp(r'[0-9]'))) score++;
    if (password.contains(RegExp(r'[!@#\$%^&*]'))) score++;
    return score + 1;
  }

  @override
  Widget build(BuildContext context) {
    final labels = ['', 'Weak', 'Fair', 'Good', 'Strong', 'Very Strong'];
    final colors = [Colors.grey, AppTheme.error, Colors.orange,
                    Colors.amber, AppTheme.success, Colors.teal];
    final s = _strength.clamp(1, 5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(5, (i) => Expanded(
            child: Container(
              height: 4,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: i < s ? colors[s] : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          )),
        ),
        const SizedBox(height: 4),
        Text('Password strength: ${labels[s]}',
          style: GoogleFonts.poppins(fontSize: 11, color: colors[s])),
        const SizedBox(height: 12),
      ],
    );
  }
}

class _Benefit extends StatelessWidget {
  final String emoji, text;
  const _Benefit(this.emoji, this.text);

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Text(emoji, style: const TextStyle(fontSize: 16)),
      const SizedBox(width: 10),
      Expanded(child: Text(text,
        style: GoogleFonts.poppins(fontSize: 12, color: AppTheme.textDark))),
    ],
  );
}
