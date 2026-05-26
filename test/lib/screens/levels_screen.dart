import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../data/user_provider.dart';
import '../models/quiz_model.dart';
import '../theme/app_theme.dart';
import 'quiz_screen.dart';

class LevelsScreen extends StatelessWidget {
  final QuizCategory category;
  final Color color;

  const LevelsScreen({super.key, required this.category, required this.color});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();
    final unlockedLevel = user.getUnlockedLevel(category.id);

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Sliver App Bar ────────────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: color,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withOpacity(0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          category.emoji,
                          style: const TextStyle(fontSize: 48),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category.name,
                          style: GoogleFonts.poppins(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          category.description,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ── Level Progress ────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Progress: $unlockedLevel / 10 Levels',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textDark,
                          ),
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: unlockedLevel / 10,
                          backgroundColor: color.withOpacity(0.15),
                          valueColor: AlwaysStoppedAnimation(color),
                          borderRadius: BorderRadius.circular(10),
                          minHeight: 8,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Levels Grid ───────────────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final level = category.levels[index];
                  final isUnlocked = level.levelNumber <= unlockedLevel;
                  final isCompleted = level.levelNumber < unlockedLevel;
                  final score = user.getLevelScore(category.id, level.levelNumber);

                  return _LevelCard(
                    level: level,
                    isUnlocked: isUnlocked,
                    isCompleted: isCompleted,
                    score: score,
                    color: color,
                    index: index,
                    onTap: isUnlocked
                        ? () => Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 500),
                                pageBuilder: (_, __, ___) => QuizScreen(
                                  category: category,
                                  level: level,
                                  color: color,
                                ),
                                transitionsBuilder: (_, anim, __, child) {
                                  return FadeTransition(
                                      opacity: anim, child: child);
                                },
                              ),
                            )
                        : null,
                  );
                },
                childCount: category.levels.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  final Level level;
  final bool isUnlocked;
  final bool isCompleted;
  final int score;
  final Color color;
  final int index;
  final VoidCallback? onTap;

  const _LevelCard({
    required this.level,
    required this.isUnlocked,
    required this.isCompleted,
    required this.score,
    required this.color,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isUnlocked ? Colors.white : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isUnlocked ? color.withOpacity(0.4) : Colors.grey.shade200,
            width: 2,
          ),
          boxShadow: isUnlocked
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: isUnlocked
                              ? color.withOpacity(0.15)
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Level ${level.levelNumber}',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: isUnlocked ? color : Colors.grey,
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (!isUnlocked)
                        Icon(Icons.lock_rounded,
                            size: 18, color: Colors.grey.shade400)
                      else if (isCompleted)
                        Icon(Icons.check_circle_rounded,
                            size: 18, color: AppTheme.success),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    level.title,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isUnlocked
                          ? AppTheme.textDark
                          : Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    level.difficulty,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: isUnlocked ? AppTheme.textLight : Colors.grey.shade400,
                    ),
                  ),
                  if (isCompleted) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: List.generate(5, (i) {
                        final filled = i < ((score / 10) * 5).ceil();
                        return Icon(
                          filled ? Icons.star_rounded : Icons.star_outline_rounded,
                          size: 14,
                          color: filled ? AppTheme.accent : Colors.grey.shade300,
                        );
                      }),
                    ),
                  ],
                ],
              ),
            ),
            // Locked overlay
            if (!isUnlocked)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
          ],
        ),
      ),
    ).animate().fadeIn(
          delay: Duration(milliseconds: 60 * index),
          duration: 350.ms,
        )
        .slideY(begin: 0.2, end: 0);
  }
}
