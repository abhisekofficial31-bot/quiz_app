import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../data/auth_provider.dart';
import '../data/quiz_data.dart';
import '../data/user_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/xp_bar.dart';
import 'login_screen.dart';
import '../widgets/themed_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _buildHeader(context, user, auth),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: XpBar(
                  xpLevel: user.xpLevel,
                  xpInLevel: user.xpInCurrentLevel,
                  progress: user.xpProgress,
                ),
              ).animate().fadeIn(delay: 100.ms),
              const SizedBox(height: 20),
              _buildStatGrid(user),
              const SizedBox(height: 20),
              _buildAchievements(user),
              const SizedBox(height: 20),
              _buildCategoryProgress(context, user),
              const SizedBox(height: 20),
              _buildSettings(context, user, auth),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ── Header ─────────────────────────────────────────────────────────────────
  Widget _buildHeader(BuildContext context, UserProvider user, AuthProvider auth) {
    final isGuest = auth.user?.isGuest ?? false;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.secondary, AppTheme.secondary.withOpacity(0.85)],
          begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      child: Column(
        children: [
          // Guest banner
          if (isGuest)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.2),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.amber.withOpacity(0.4)),
              ),
              child: Row(
                children: [
                  const Text('⚠️', style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'You\'re playing as guest. Create an account to save your progress!',
                      style: GoogleFonts.poppins(
                          fontSize: 11, color: Colors.amber.shade200),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const LoginScreen())),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(8)),
                      child: Text('Sign Up',
                        style: GoogleFonts.poppins(
                          fontSize: 11, fontWeight: FontWeight.w700,
                          color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ),

          // Avatar
          GestureDetector(
            onTap: () => _showAvatarPicker(context, user),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 86, height: 86,
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3)),
                  child: Center(child: Text(user.avatar,
                      style: const TextStyle(fontSize: 42))),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: AppTheme.primary, shape: BoxShape.circle),
                  child: const Icon(Icons.edit, size: 13, color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Name + email
          Text(user.name.isEmpty ? 'Set your name' : user.name,
            style: GoogleFonts.poppins(fontSize: 20,
                fontWeight: FontWeight.w800, color: Colors.white)),
          if (auth.user?.email.isNotEmpty == true && !isGuest)
            Text(auth.user!.email,
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.white38)),
          Text('Level ${user.xpLevel} · ${user.xp} XP total',
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.white60)),

          const SizedBox(height: 14),

          // Streak + diamonds chips
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _HeaderChip('🔥 ${user.currentStreak} streak',
                  AppTheme.primary.withOpacity(0.4)),
              const SizedBox(width: 10),
              _HeaderChip('💎 ${user.diamonds}',
                  AppTheme.teal.withOpacity(0.4)),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  // ── Stat grid ──────────────────────────────────────────────────────────────
  Widget _buildStatGrid(UserProvider user) {
    final items = [
      ('⭐', 'Total Score',  '${user.totalScore}',    AppTheme.accent),
      ('🎯', 'Quizzes',      '${user.quizzesPlayed}', AppTheme.primary),
      ('💯', 'Perfect',      '${user.perfectScores}', AppTheme.success),
      ('🔥', 'Best Streak',  '${user.bestStreak}',    AppTheme.purple),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1.6,
          crossAxisSpacing: 12, mainAxisSpacing: 12),
        itemCount: items.length,
        itemBuilder: (_, i) {
          final it = items[i];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: (it.$4 as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(it.$1, style: const TextStyle(fontSize: 24)),
                const Spacer(),
                Text(it.$3, style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w800, fontSize: 20,
                  color: AppTheme.textDark)),
                Text(it.$2, style: GoogleFonts.poppins(
                    fontSize: 11, color: AppTheme.textLight)),
              ],
            ),
          ).animate().fadeIn(
                delay: Duration(milliseconds: 60 * i), duration: 350.ms);
        },
      ),
    );
  }

  // ── Achievements ───────────────────────────────────────────────────────────
  Widget _buildAchievements(UserProvider user) {
    final unlocked = user.achievements.where((a) => a.isUnlocked).toList();
    final locked   = user.achievements.where((a) => !a.isUnlocked).toList();
    final all = [...unlocked, ...locked];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Achievements 🏅',
                style: GoogleFonts.poppins(fontSize: 17,
                    fontWeight: FontWeight.w700, color: AppTheme.textDark)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10)),
                child: Text('${unlocked.length}/${all.length}',
                  style: GoogleFonts.poppins(fontSize: 12,
                    fontWeight: FontWeight.w700, color: AppTheme.primary)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 110,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: all.length,
              itemBuilder: (ctx, i) {
                final a = all[i];
                return GestureDetector(
                  onTap: () {
                    // Show tooltip
                    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
                      content: Text(
                        a.isUnlocked
                            ? '${a.emoji} ${a.title}: ${a.description}'
                            : '🔒 ${a.title}: ${a.description}',
                        style: GoogleFonts.poppins(),
                      ),
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ));
                  },
                  child: Container(
                    width: 90,
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: a.isUnlocked
                          ? AppTheme.accent.withOpacity(0.12)
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: a.isUnlocked
                            ? AppTheme.accent.withOpacity(0.4)
                            : Colors.grey.shade200,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(a.isUnlocked ? a.emoji : '🔒',
                          style: TextStyle(fontSize: 28,
                            color: a.isUnlocked ? null : Colors.grey)),
                        const SizedBox(height: 5),
                        Text(a.title, textAlign: TextAlign.center,
                          maxLines: 2,
                          style: GoogleFonts.poppins(fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: a.isUnlocked
                                ? AppTheme.textDark : Colors.grey.shade400)),
                        if (a.isUnlocked && a.diamondReward > 0)
                          Text('+${a.diamondReward}💎',
                            style: GoogleFonts.poppins(
                                fontSize: 8, color: AppTheme.teal)),
                      ],
                    ),
                  ),
                ).animate().fadeIn(
                      delay: Duration(milliseconds: 60 * i), duration: 350.ms);
              },
            ),
          ),
        ],
      ),
    );
  }

  // ── Category progress ──────────────────────────────────────────────────────
  Widget _buildCategoryProgress(BuildContext context, UserProvider user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Category Progress',
            style: GoogleFonts.poppins(fontSize: 17,
                fontWeight: FontWeight.w700, color: AppTheme.textDark)),
          const SizedBox(height: 12),
          ...QuizData.categories.asMap().entries.map((e) {
            final i = e.key;
            final cat = e.value;
            final color =
                AppTheme.categoryColor(i);
            final done =
                (user.getUnlockedLevel(cat.id) - 1).clamp(0, 10);
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [BoxShadow(
                    color: Colors.black.withOpacity(0.04), blurRadius: 8)],
              ),
              child: Row(
                children: [
                  Text(cat.emoji, style: const TextStyle(fontSize: 22)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Expanded(child: Text(cat.name,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 12, color: AppTheme.textDark))),
                          Text('$done/10',
                            style: GoogleFonts.poppins(fontSize: 11,
                              fontWeight: FontWeight.w700, color: color)),
                        ]),
                        const SizedBox(height: 5),
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: done / 10),
                          duration: const Duration(milliseconds: 700),
                          builder: (_, val, __) => LinearProgressIndicator(
                            value: val,
                            backgroundColor: color.withOpacity(0.12),
                            valueColor: AlwaysStoppedAnimation(color),
                            borderRadius: BorderRadius.circular(6),
                            minHeight: 6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(
                  delay: Duration(milliseconds: 60 * i), duration: 350.ms);
          }),
        ],
      ),
    );
  }

  // ── Settings ───────────────────────────────────────────────────────────────
  Widget _buildSettings(BuildContext context, UserProvider user, AuthProvider auth) {
    final isGuest = auth.user?.isGuest ?? false;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Settings',
            style: GoogleFonts.poppins(fontSize: 17,
                fontWeight: FontWeight.w700, color: AppTheme.textDark)),
          const SizedBox(height: 12),

          _SettingTile(Icons.person_outline_rounded, 'Change Name',
              () => _showNameDialog(context, user)),
          _SettingTile(Icons.emoji_emotions_outlined, 'Change Avatar',
              () => _showAvatarPicker(context, user)),
          _SettingTile(Icons.refresh_rounded, 'Reset Progress',
              () => _confirmReset(context, user), isDestructive: true),

          const SizedBox(height: 8),

          // Logout / Switch account
          GestureDetector(
            onTap: () => _confirmLogout(context, auth, user),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.error.withOpacity(0.06),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppTheme.error.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      isGuest ? Icons.login_rounded : Icons.logout_rounded,
                      color: AppTheme.error, size: 18),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isGuest ? 'Sign In / Create Account'
                                  : 'Log Out',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 14,
                            color: AppTheme.error)),
                        Text(
                          isGuest
                              ? 'Save your progress permanently'
                              : 'You can log back in anytime',
                          style: GoogleFonts.poppins(
                              fontSize: 11, color: AppTheme.textLight)),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_rounded,
                      size: 14, color: AppTheme.error),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Dialogs ────────────────────────────────────────────────────────────────
  void _showNameDialog(BuildContext context, UserProvider user) {
    final ctrl = TextEditingController(text: user.name);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Change Name',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Enter your name',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: GoogleFonts.poppins())),
          ElevatedButton(
            onPressed: () {
              if (ctrl.text.trim().isNotEmpty)
                user.updateName(ctrl.text.trim());
              Navigator.pop(context);
            },
            child: Text('Save', style: GoogleFonts.poppins()),
          ),
        ],
      ),
    );
  }

  void _showAvatarPicker(BuildContext context, UserProvider user) {
    final avatars = ['🧑','👩','👨','👧','👦','🧑‍🦱','👩‍🦰',
                     '👨‍🦳','🧑‍💻','👩‍🎓','👨‍🎓','🦸','🧙','🥷','🐱','🦊'];
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40, height: 4,
              decoration: BoxDecoration(color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 16),
            Text('Pick Avatar', style: GoogleFonts.poppins(
                fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12, runSpacing: 12,
              children: avatars.map((av) => GestureDetector(
                onTap: () {
                  user.updateAvatar(av);
                  Navigator.pop(context);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 56, height: 56,
                  decoration: BoxDecoration(
                    color: av == user.avatar
                        ? AppTheme.primary.withOpacity(0.15)
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: av == user.avatar
                          ? AppTheme.primary : Colors.transparent,
                      width: 2.5)),
                  child: Center(child: Text(av,
                      style: const TextStyle(fontSize: 28))),
                ),
              )).toList(),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _confirmReset(BuildContext context, UserProvider user) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Reset Progress?',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w700,
                color: AppTheme.error)),
        content: Text(
          'This will delete ALL your progress, XP, diamonds, and achievements. This cannot be undone!',
          style: GoogleFonts.poppins()),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: GoogleFonts.poppins())),
          ElevatedButton(
            onPressed: () { user.resetAll(); Navigator.pop(context); },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.error),
            child: Text('Reset Everything', style: GoogleFonts.poppins()),
          ),
        ],
      ),
    );
  }

  void _confirmLogout(BuildContext context, AuthProvider auth, UserProvider user) {
    final isGuest = auth.user?.isGuest ?? false;

    if (isGuest) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => const LoginScreen()));
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Log Out?', style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700)),
        content: Text('Your progress is saved. You can log back in anytime.',
            style: GoogleFonts.poppins()),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: GoogleFonts.poppins())),
          ElevatedButton(
            onPressed: () async {
              await auth.signOut();
              if (!context.mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (_) => false,
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.error),
            child: Text('Log Out', style: GoogleFonts.poppins()),
          ),
        ],
      ),
    );
  }
}

// ── Helper widgets ────────────────────────────────────────────────────────────
class _HeaderChip extends StatelessWidget {
  final String text;
  final Color color;
  const _HeaderChip(this.text, this.color);

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
        color: color, borderRadius: BorderRadius.circular(12)),
    child: Text(text, style: GoogleFonts.poppins(
        fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
  );
}

class _SettingTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  const _SettingTile(this.icon, this.label, this.onTap,
      {this.isDestructive = false});

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? AppTheme.error : AppTheme.primary;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(
              color: Colors.black.withOpacity(0.04), blurRadius: 8)],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(child: Text(label, style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500, fontSize: 14,
                color: isDestructive ? AppTheme.error : AppTheme.textDark))),
            Icon(Icons.arrow_forward_ios_rounded,
                size: 14, color: AppTheme.textLight),
          ],
        ),
      ),
    );
  }
}

