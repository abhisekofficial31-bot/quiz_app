import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../data/quiz_data.dart';
import '../data/user_provider.dart';
import '../widgets/daily_reward_popup.dart';
import '../widgets/themed_widgets.dart';
import '../widgets/xp_bar.dart';
import 'levels_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _bannerCtrl = PageController();
  int _currentBanner = 0;
  Timer? _timer;
  bool _showDailyReward = false;

  static const _banners = [
    ('Challenge Your Mind!',   'Play quizzes and earn diamonds 💎', 0),
    ('New Levels Await!',      'Master all levels in every category', 1),
    ('Top the Leaderboard!',   'Compete with players worldwide 🌍', 2),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (_bannerCtrl.hasClients) {
        _bannerCtrl.animateToPage(
          (_currentBanner + 1) % _banners.length,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      final user = context.read<UserProvider>();
      if (user.canClaimDailyReward && !user.isNewUser) {
        setState(() => _showDailyReward = true);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _bannerCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();

    return ThScaffold(
      showPattern: true,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(user),
                  const SizedBox(height: 14),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: XpBar(
                      xpLevel: user.xpLevel,
                      xpInLevel: user.xpInCurrentLevel,
                      progress: user.xpProgress,
                    ),
                  ).animate().fadeIn(delay: 100.ms),
                  const SizedBox(height: 14),
                  if (user.currentStreak > 0) _streakCard(user),
                  _bannerCarousel(),
                  const SizedBox(height: 20),
                  _stats(user),
                  const SizedBox(height: 20),
                  _sectionTitle('Popular Categories 🔥'),
                  const SizedBox(height: 12),
                  _categories(),
                  const SizedBox(height: 20),
                  if (user.recentPlayed.isNotEmpty) ...[
                    _sectionTitle('Recently Played'),
                    const SizedBox(height: 12),
                    _recent(user),
                  ],
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          if (_showDailyReward)
            DailyRewardPopup(
                onClaim: () => setState(() => _showDailyReward = false)),
        ],
      ),
    );
  }

  Widget _header(UserProvider user) {
    final h = DateTime.now().hour;
    final greeting = h < 12 ? 'Good Morning,' : h < 17 ? 'Good Afternoon,' : 'Good Evening,';
    final gEmoji   = h < 12 ? '☀️' : h < 17 ? '👋' : '🌙';
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ThText('$greeting ${user.name.isEmpty ? "there" : user.name.split(" ").first} $gEmoji',
                    fontSize: 20, fontWeight: FontWeight.w700, color: AppTheme.textDark),
                ThText(user.quizzesPlayed == 0
                    ? 'Start your first quiz today!'
                    : 'Ready to quiz today?',
                    fontSize: 13, color: AppTheme.textLight),
              ],
            ),
          ),
          ThDiamondBadge(
            count: user.diamonds,
            hasClaim: user.canClaimDailyReward,
            onTap: user.canClaimDailyReward
                ? () => setState(() => _showDailyReward = true)
                : null,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2, end: 0);
  }

  Widget _streakCard(UserProvider user) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.primary.withOpacity(0.15), AppTheme.extra1.withOpacity(0.15)]),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.primary.withOpacity(0.25)),
        ),
        child: Row(
          children: [
            const Text('🔥', style: TextStyle(fontSize: 26)),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ThText('${user.currentStreak} Day Streak!',
                      fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.textDark),
                  ThText(user.streakTitle, fontSize: 11, color: AppTheme.textLight),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                  color: AppTheme.primary, borderRadius: BorderRadius.circular(10)),
              child: ThText('Best: ${user.bestStreak}🔥',
                  fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 150.ms).slideX(begin: -0.2, end: 0);
  }

  Widget _bannerCarousel() {
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: PageView.builder(
            controller: _bannerCtrl,
            onPageChanged: (i) => setState(() => _currentBanner = i),
            itemCount: _banners.length,
            itemBuilder: (_, i) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ThBanner(
                title: _banners[i].$1,
                subtitle: _banners[i].$2,
                gradientIndex: _banners[i].$3,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        AnimatedSmoothIndicator(
          activeIndex: _currentBanner,
          count: _banners.length,
          effect: WormEffect(
            dotHeight: 8, dotWidth: 8,
            activeDotColor: AppTheme.primary,
            dotColor: AppTheme.primary.withOpacity(0.2),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 200.ms);
  }

  Widget _stats(UserProvider user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ThStatCard(label: 'Score',   value: '${user.totalScore}',    emoji: '⭐', colorIndex: 0),
          const SizedBox(width: 10),
          ThStatCard(label: 'Quizzes', value: '${user.quizzesPlayed}', emoji: '🎯', colorIndex: 1),
          const SizedBox(width: 10),
          ThStatCard(label: 'Diamonds',value: '${user.diamonds}',      emoji: '💎', colorIndex: 2),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ThText(title, fontSize: 17, fontWeight: FontWeight.w700, color: AppTheme.textDark),
    );
  }

  Widget _categories() {
    return SizedBox(
      height: 148,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: QuizData.categories.length,
        itemBuilder: (context, i) {
          final cat   = QuizData.categories[i];
          final color = AppTheme.categoryColor(i);
          return Padding(
            padding: const EdgeInsets.only(right: 14),
            child: GestureDetector(
              onTap: () => Navigator.push(context, PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 400),
                pageBuilder: (_, __, ___) => LevelsScreen(category: cat, color: color),
                transitionsBuilder: (_, anim, __, child) => SlideTransition(
                  position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                      .animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
                  child: child),
              )),
              child: Container(
                width: 128,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withOpacity(0.7)],
                    begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: color.withOpacity(0.3),
                      blurRadius: 10, offset: const Offset(0, 5))],
                ),
                child: Stack(
                  children: [
                    Positioned(right: -10, bottom: -10,
                      child: Text(cat.emoji, style: const TextStyle(fontSize: 56))),
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(cat.emoji, style: const TextStyle(fontSize: 26)),
                          const Spacer(),
                          ThText(cat.name, fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white),
                          ThText('10 Levels', fontSize: 10, color: Colors.white70),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ).animate()
            .fadeIn(delay: Duration(milliseconds: 80 * i), duration: 400.ms)
            .slideX(begin: 0.3, end: 0);
        },
      ),
    );
  }

  Widget _recent(UserProvider user) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: user.recentPlayed.length,
      itemBuilder: (ctx, i) {
        final item  = user.recentPlayed[i];
        final ci    = QuizData.categories.indexWhere((c) => c.id == item['categoryId']);
        final color = ci >= 0 ? AppTheme.categoryColor(ci) : AppTheme.primary;
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppTheme.cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: false
                ? Colors.white.withOpacity(0.08) : Colors.transparent),
            boxShadow: [BoxShadow(
                color: Colors.black.withOpacity(false ? 0.2 : 0.05),
                blurRadius: 8)],
          ),
          child: Row(
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12)),
                child: Center(child: Text(item['emoji'] as String,
                    style: const TextStyle(fontSize: 22))),
              ),
              const SizedBox(width: 12),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ThText(item['categoryName'] as String,
                      fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textDark),
                  ThText('Level ${item['level']} · Score: ${item['score']}/10',
                      fontSize: 11, color: AppTheme.textLight),
                ],
              )),
              GestureDetector(
                onTap: () {
                  if (ci >= 0) Navigator.push(ctx, MaterialPageRoute(
                    builder: (_) => LevelsScreen(
                        category: QuizData.categories[ci], color: color)));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                      color: color, borderRadius: BorderRadius.circular(10)),
                  child: ThText('Play again', fontSize: 11,
                      fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ],
          ),
        ).animate().fadeIn(delay: Duration(milliseconds: 80 * i));
      },
    );
  }
}
