import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../data/user_provider.dart';
import '../theme/app_theme.dart';

class DailyRewardPopup extends StatefulWidget {
  final VoidCallback onClaim;
  const DailyRewardPopup({super.key, required this.onClaim});

  @override
  State<DailyRewardPopup> createState() => _DailyRewardPopupState();
}

class _DailyRewardPopupState extends State<DailyRewardPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseCtrl;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();
    final streak = user.currentStreak;
    final reward = user.dailyRewardAmount;

    // Day labels for 7-day preview
    final days = ['Day 1\n10💎', 'Day 2\n10💎', 'Day 3\n20💎',
                  'Day 4\n20💎', 'Day 5\n30💎', 'Day 6\n30💎', 'Day 7\n50💎'];

    return Stack(
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(color: Colors.black54),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.secondary,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppTheme.primary, AppTheme.extra1],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(28)),
                    ),
                    child: Column(
                      children: [
                        AnimatedBuilder(
                          animation: _pulseCtrl,
                          builder: (_, __) => Transform.scale(
                            scale: 1.0 + _pulseCtrl.value * 0.1,
                            child: const Text('🎁',
                                style: TextStyle(fontSize: 60)),
                          ),
                        ).animate().scale(
                              begin: const Offset(0, 0),
                              duration: 600.ms,
                              curve: Curves.elasticOut,
                            ),
                        const SizedBox(height: 10),
                        Text(
                          'Daily Reward!',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          streak > 0
                              ? '🔥 $streak Day Streak — Keep it up!'
                              : 'Start your streak today!',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // 7 day streak preview
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: days.asMap().entries.map((e) {
                            final dayNum = e.key + 1;
                            final isPast = dayNum < streak;
                            final isToday = dayNum == (streak == 0 ? 1 : streak % 7 == 0 ? 7 : streak % 7);
                            return Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 2),
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: isPast
                                      ? AppTheme.success.withOpacity(0.2)
                                      : isToday
                                          ? AppTheme.primary.withOpacity(0.2)
                                          : Colors.white.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: isToday
                                        ? AppTheme.primary
                                        : isPast
                                            ? AppTheme.success
                                            : Colors.white12,
                                    width: isToday ? 2 : 1,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      isPast ? '✅' : isToday ? '🎁' : '🔒',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      'D$dayNum',
                                      style: GoogleFonts.poppins(
                                        fontSize: 9,
                                        color: isToday
                                            ? AppTheme.primary
                                            : Colors.white54,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 20),

                        // Today's reward
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppTheme.accent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: AppTheme.accent.withOpacity(0.3)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('💎',
                                  style: TextStyle(fontSize: 32)),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Today's Reward",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.white60,
                                    ),
                                  ),
                                  Text(
                                    '+$reward Diamonds',
                                    style: GoogleFonts.poppins(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                      color: AppTheme.accent,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ).animate().fadeIn(delay: 400.ms),

                        const SizedBox(height: 16),

                        // Claim button
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: () async {
                              await context.read<UserProvider>().claimDailyReward();
                              widget.onClaim();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                            ),
                            child: Text(
                              'Claim +$reward 💎',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ).animate().fadeIn(delay: 500.ms),

                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: widget.onClaim,
                          child: Text(
                            'Remind me later',
                            style: GoogleFonts.poppins(
                                color: Colors.white38, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().scale(
                  begin: const Offset(0.85, 0.85),
                  duration: 400.ms,
                  curve: Curves.easeOut,
                ),
          ),
        ),
      ],
    );
  }
}
