import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../data/quiz_data.dart';
import '../data/user_provider.dart';
import '../theme/app_theme.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();
    final all = [
      {'name': user.name, 'score': user.totalScore, 'avatar': '🧑', 'isMe': true},
      ...QuizData.leaderboard.map((e) => {
            'name': e.name,
            'score': e.score,
            'avatar': e.avatar,
            'isMe': false,
          }),
    ]..sort((a, b) => (b['score'] as int).compareTo(a['score'] as int));

    final top3 = all.take(3).toList();
    final rest = all.skip(3).toList();

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: [
                  Text(
                    'Leaderboard 🔥',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3E0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Text('💎', style: TextStyle(fontSize: 18)),
                        const SizedBox(width: 6),
                        Text(
                          '${user.diamonds}',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: AppTheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Top 3 Podium
            _buildPodium(top3),

            // Rest of list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                physics: const BouncingScrollPhysics(),
                itemCount: rest.length,
                itemBuilder: (context, index) {
                  final entry = rest[index];
                  final rank = index + 4;
                  final isMe = entry['isMe'] as bool;
                  return _LeaderRow(
                    rank: rank,
                    name: entry['name'] as String,
                    score: entry['score'] as int,
                    avatar: entry['avatar'] as String,
                    isMe: isMe,
                    index: index,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPodium(List<Map<String, dynamic>> top3) {
    if (top3.isEmpty) return const SizedBox.shrink();

    final medals = ['🥇', '🥈', '🥉'];
    final heights = [100.0, 80.0, 70.0];
    final order = top3.length >= 3 ? [1, 0, 2] : [0];

    return Builder(builder: (context) {
        return Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.secondary, AppTheme.secondary.withOpacity(0.85)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: order.map((i) {
            if (i >= top3.length) return const SizedBox.shrink();
            final entry = top3[i];
            final isMe = entry['isMe'] as bool;
            return _PodiumItem(
              rank: i + 1,
              name: entry['name'] as String,
              score: entry['score'] as int,
              avatar: entry['avatar'] as String,
              medal: medals[i],
              height: heights[i],
              isMe: isMe,
            ).animate().fadeIn(delay: Duration(milliseconds: 200 * i), duration: 400.ms)
                .slideY(begin: 0.3, end: 0);
          }).toList(),
        ),
      ).animate().fadeIn(duration: 500.ms);
    });
  }
}

class _PodiumItem extends StatelessWidget {
  final int rank;
  final String name;
  final int score;
  final String avatar;
  final String medal;
  final double height;
  final bool isMe;

  const _PodiumItem({
    required this.rank,
    required this.name,
    required this.score,
    required this.avatar,
    required this.medal,
    required this.height,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isMe ? AppTheme.primary : Colors.white24,
                shape: BoxShape.circle,
                border: Border.all(
                  color: rank == 1 ? AppTheme.accent : Colors.white30,
                  width: rank == 1 ? 3 : 1.5,
                ),
              ),
              child: Center(
                child: Text(avatar, style: const TextStyle(fontSize: 28)),
              ),
            ),
            if (isMe)
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, size: 12, color: Colors.white),
              ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          name.split(' ').first,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          '$score pts',
          style: GoogleFonts.poppins(fontSize: 11, color: Colors.white60),
        ),
        const SizedBox(height: 8),
        Text(medal, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 4),
        Container(
          width: 70,
          height: height,
          decoration: BoxDecoration(
            color: rank == 1
                ? AppTheme.accent.withOpacity(0.3)
                : Colors.white.withOpacity(0.1),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: Center(
            child: Text(
              '#$rank',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w800,
                fontSize: 18,
                color: rank == 1 ? AppTheme.accent : Colors.white60,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LeaderRow extends StatelessWidget {
  final int rank;
  final String name;
  final int score;
  final String avatar;
  final bool isMe;
  final int index;

  const _LeaderRow({
    required this.rank,
    required this.name,
    required this.score,
    required this.avatar,
    required this.isMe,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isMe ? AppTheme.primary.withOpacity(0.08) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isMe ? AppTheme.primary.withOpacity(0.3) : Colors.transparent,
          width: isMe ? 2 : 0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                '#$rank',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: AppTheme.textLight,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(avatar, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              isMe ? '$name (You)' : name,
              style: GoogleFonts.poppins(
                fontWeight: isMe ? FontWeight.w700 : FontWeight.w500,
                fontSize: 14,
                color: isMe ? AppTheme.primary : AppTheme.textDark,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isMe ? AppTheme.primary : AppTheme.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$score pts',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: isMe ? Colors.white : AppTheme.textDark,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(
          delay: Duration(milliseconds: 80 * index),
          duration: 350.ms,
        )
        .slideX(begin: 0.1, end: 0);
  }
}
