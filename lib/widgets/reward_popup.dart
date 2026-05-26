import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class RewardPopup extends StatefulWidget {
  final Map<String, dynamic> reward;
  final VoidCallback onContinue;

  const RewardPopup({
    super.key,
    required this.reward,
    required this.onContinue,
  });

  @override
  State<RewardPopup> createState() => _RewardPopupState();
}

class _RewardPopupState extends State<RewardPopup>
    with SingleTickerProviderStateMixin {
  late ConfettiController _confetti;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 5));
    final isPerfect = widget.reward['isPerfect'] as bool? ?? false;
    if (isPerfect) _confetti.play();
  }

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final score       = widget.reward['score'] as int? ?? 0;
    final total       = widget.reward['total'] as int? ?? 10;
    final diamonds    = widget.reward['diamonds'] as int? ?? 0;
    final xp          = widget.reward['xp'] as int? ?? 0;
    final isPerfect   = widget.reward['isPerfect'] as bool? ?? false;
    final isFirstTime = widget.reward['isFirstTime'] as bool? ?? false;
    final bonuses     = (widget.reward['bonuses'] as List?)?.cast<String>() ?? [];
    final newAch      = (widget.reward['newAchievements'] as List?)?.cast<String>() ?? [];
    final streak      = widget.reward['streakDay'] as int? ?? 0;

    final pct = score / total;
    final String emoji = isPerfect ? '🏆' : pct >= 0.7 ? '🌟' : pct >= 0.4 ? '😊' : '💪';
    final String title = isPerfect
        ? 'Perfect Score!'
        : pct >= 0.7
            ? 'Great Job!'
            : pct >= 0.4
                ? 'Good Try!'
                : 'Keep Going!';
    final Color color = isPerfect
        ? AppTheme.accent
        : pct >= 0.7
            ? AppTheme.success
            : pct >= 0.4
                ? AppTheme.primary
                : AppTheme.extra1;

    return Stack(
      children: [
        // Dimmed background
        GestureDetector(
          onTap: () {},
          child: Container(color: Colors.black54),
        ),

        // Confetti
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confetti,
            blastDirectionality: BlastDirectionality.explosive,
            numberOfParticles: 30,
            gravity: 0.3,
            colors: [AppTheme.primary, AppTheme.accent, AppTheme.extra1, AppTheme.extra2, Colors.white],
          ),
        ),

        // Popup card
        Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.3),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ── Colored header ─────────────────────────────────────
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [color, color.withOpacity(0.7)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(28)),
                      ),
                      child: Column(
                        children: [
                          Text(emoji, style: const TextStyle(fontSize: 64))
                              .animate()
                              .scale(
                                begin: const Offset(0, 0),
                                duration: 600.ms,
                                curve: Curves.elasticOut,
                              ),
                          const SizedBox(height: 12),
                          Text(
                            title,
                            style: GoogleFonts.poppins(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ).animate().fadeIn(delay: 200.ms),
                          const SizedBox(height: 8),
                          // Score display
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$score',
                                style: GoogleFonts.poppins(
                                  fontSize: 52,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ).animate().fadeIn(delay: 300.ms),
                              Text(
                                ' / $total',
                                style: GoogleFonts.poppins(
                                  fontSize: 28,
                                  color: Colors.white60,
                                ),
                              ).animate().fadeIn(delay: 400.ms),
                            ],
                          ),
                          // Stars
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(3, (i) {
                              final filled = i < (pct >= 0.9 ? 3 : pct >= 0.6 ? 2 : pct >= 0.3 ? 1 : 0);
                              return Icon(
                                filled ? Icons.star_rounded : Icons.star_outline_rounded,
                                color: filled ? Colors.white : Colors.white38,
                                size: 36,
                              ).animate().scale(
                                    delay: Duration(milliseconds: 400 + i * 100),
                                    duration: 400.ms,
                                    curve: Curves.elasticOut,
                                  );
                            }),
                          ),
                        ],
                      ),
                    ),

                    // ── Rewards section ────────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          // Diamonds + XP earned
                          Row(
                            children: [
                              Expanded(
                                child: _RewardChip(
                                  emoji: '💎',
                                  label: '+$diamonds',
                                  sublabel: 'Diamonds',
                                  color: AppTheme.extra2,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _RewardChip(
                                  emoji: '⭐',
                                  label: '+$xp',
                                  sublabel: 'XP',
                                  color: AppTheme.accent,
                                ),
                              ),
                              if (streak > 0) ...[
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _RewardChip(
                                    emoji: '🔥',
                                    label: '$streak',
                                    sublabel: 'Day Streak',
                                    color: AppTheme.primary,
                                  ),
                                ),
                              ],
                            ],
                          ).animate().fadeIn(delay: 500.ms, duration: 400.ms),

                          const SizedBox(height: 14),

                          // Bonus breakdown
                          if (bonuses.isNotEmpty) ...[
                            ...bonuses.asMap().entries.map((e) =>
                              _BonusRow(text: e.value)
                                  .animate()
                                  .fadeIn(delay: Duration(milliseconds: 600 + e.key * 80))
                                  .slideX(begin: 0.2, end: 0),
                            ),
                            const SizedBox(height: 8),
                          ],

                          // First time badge
                          if (isFirstTime)
                            Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppTheme.extra1.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: AppTheme.extra1.withOpacity(0.3)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('🎉',
                                      style: TextStyle(fontSize: 18)),
                                  const SizedBox(width: 8),
                                  Text(
                                    'First time bonus unlocked!',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: AppTheme.extra1,
                                    ),
                                  ),
                                ],
                              ),
                            ).animate().fadeIn(delay: 700.ms),

                          // New achievements
                          if (newAch.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppTheme.accent.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: AppTheme.accent.withOpacity(0.3)),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    '🏅 Achievement Unlocked!',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                      color: AppTheme.textDark,
                                    ),
                                  ),
                                  ...newAch.map((a) => Text(
                                        a,
                                        style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: AppTheme.textLight),
                                      )),
                                ],
                              ),
                            ).animate().fadeIn(delay: 750.ms).scale(
                                  begin: const Offset(0.9, 0.9),
                                  end: const Offset(1, 1),
                                ),
                            const SizedBox(height: 8),
                          ],

                          const SizedBox(height: 8),

                          // Continue button
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: widget.onContinue,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: color,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                              ),
                              child: Text(
                                'Continue',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ).animate().fadeIn(delay: 800.ms),
                        ],
                      ),
                    ),
                  ],
                ),
              ).animate().scale(
                    begin: const Offset(0.8, 0.8),
                    duration: 400.ms,
                    curve: Curves.easeOut,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}

class _RewardChip extends StatelessWidget {
  final String emoji;
  final String label;
  final String sublabel;
  final Color color;

  const _RewardChip({
    required this.emoji,
    required this.label,
    required this.sublabel,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w800,
              fontSize: 18,
              color: color,
            ),
          ),
          Text(
            sublabel,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: AppTheme.textLight,
            ),
          ),
        ],
      ),
    );
  }
}

class _BonusRow extends StatelessWidget {
  final String text;
  const _BonusRow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(Icons.check_circle_rounded,
              color: AppTheme.success, size: 16),
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppTheme.textDark,
            ),
          ),
        ],
      ),
    );
  }
}
