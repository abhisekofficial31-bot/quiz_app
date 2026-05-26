import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/quiz_model.dart';
import '../theme/app_theme.dart';

class ResultScreen extends StatefulWidget {
  final int score;
  final int total;
  final Level level;
  final QuizCategory category;
  final Color color;
  final List<int> userAnswers;

  const ResultScreen({
    super.key,
    required this.score,
    required this.total,
    required this.level,
    required this.category,
    required this.color,
    required this.userAnswers,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late ConfettiController _confetti;
  bool _showReview = false;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 4));
    final pct = widget.score / widget.total;
    if (pct >= 0.6) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _confetti.play();
      });
    }
  }

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  String get _resultEmoji {
    final pct = widget.score / widget.total;
    if (pct == 1) return '🏆';
    if (pct >= 0.8) return '🌟';
    if (pct >= 0.6) return '😊';
    if (pct >= 0.4) return '😐';
    return '😢';
  }

  String get _resultTitle {
    final pct = widget.score / widget.total;
    if (pct == 1) return 'Perfect Score!';
    if (pct >= 0.8) return 'Excellent!';
    if (pct >= 0.6) return 'Good Job!';
    if (pct >= 0.4) return 'Not Bad!';
    return 'Keep Practicing!';
  }

  int get _stars {
    final pct = widget.score / widget.total;
    if (pct >= 0.9) return 3;
    if (pct >= 0.6) return 2;
    if (pct >= 0.3) return 1;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(
        children: [
          // Confetti
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confetti,
              blastDirectionality: BlastDirectionality.explosive,
              particleDrag: 0.05,
              emissionFrequency: 0.06,
              numberOfParticles: 20,
              gravity: 0.2,
              colors: [
                AppTheme.primary,
                AppTheme.accent,
                AppTheme.purple,
                AppTheme.teal,
              ],
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: _showReview
                  ? _buildReview()
                  : _buildResult(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResult() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // ── Result Card ───────────────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [widget.color, widget.color.withOpacity(0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: widget.color.withOpacity(0.35),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  _resultEmoji,
                  style: const TextStyle(fontSize: 72),
                ).animate().scale(
                      begin: const Offset(0, 0),
                      duration: 600.ms,
                      curve: Curves.elasticOut,
                    ),
                const SizedBox(height: 16),
                Text(
                  _resultTitle,
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ).animate().fadeIn(delay: 300.ms),
                const SizedBox(height: 8),
                Text(
                  '${widget.category.name} • Level ${widget.level.levelNumber}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ).animate().fadeIn(delay: 400.ms),
                const SizedBox(height: 24),
                // Stars
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        i < _stars ? Icons.star_rounded : Icons.star_outline_rounded,
                        size: 40,
                        color: i < _stars ? AppTheme.accent : Colors.white30,
                      ),
                    ).animate().scale(
                          delay: Duration(milliseconds: 500 + 100 * i),
                          duration: 400.ms,
                          curve: Curves.elasticOut,
                        );
                  }),
                ),
                const SizedBox(height: 24),
                // Score
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.score}',
                      style: GoogleFonts.poppins(
                        fontSize: 64,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ).animate().fadeIn(delay: 600.ms),
                    Text(
                      ' / ${widget.total}',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.w400,
                        color: Colors.white60,
                      ),
                    ).animate().fadeIn(delay: 700.ms),
                  ],
                ),
                Text(
                  'Correct Answers',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ── Stats Row ─────────────────────────────────────────────────────
          Row(
            children: [
              _InfoTile(
                label: 'Accuracy',
                value: '${((widget.score / widget.total) * 100).toStringAsFixed(0)}%',
                emoji: '🎯',
                color: widget.color,
              ),
              const SizedBox(width: 12),
              _InfoTile(
                label: 'Diamonds',
                value: '+${widget.score >= widget.total ? 10 : widget.score >= widget.total * 0.7 ? 5 : 2}💎',
                emoji: '💎',
                color: AppTheme.teal,
              ),
            ],
          ).animate().fadeIn(delay: 800.ms, duration: 400.ms),

          const SizedBox(height: 24),

          // ── Buttons ───────────────────────────────────────────────────────
          ElevatedButton(
            onPressed: () => setState(() => _showReview = true),
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.color,
              minimumSize: const Size(double.infinity, 54),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
            ),
            child: Text(
              'Review Answers',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ).animate().fadeIn(delay: 900.ms, duration: 400.ms),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context); // back to levels
            },
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 54),
              side: BorderSide(color: widget.color, width: 2),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
            ),
            child: Text(
              'Back to Levels',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: widget.color,
              ),
            ),
          ).animate().fadeIn(delay: 1000.ms, duration: 400.ms),

          const SizedBox(height: 12),
          TextButton(
            onPressed: () {
              int count = 0;
              Navigator.popUntil(context, (_) => count++ >= 3);
            },
            child: Text(
              'Go to Home',
              style: GoogleFonts.poppins(
                color: AppTheme.textLight,
                fontWeight: FontWeight.w500,
              ),
            ),
          ).animate().fadeIn(delay: 1100.ms),
        ],
      ),
    );
  }

  Widget _buildReview() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => setState(() => _showReview = false),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.06), blurRadius: 8)
                    ],
                  ),
                  child: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Review Answers',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...List.generate(widget.level.questions.length, (i) {
            final q = widget.level.questions[i];
            final userAns = widget.userAnswers[i];
            final correct = q.correctIndex;
            final isRight = userAns == correct;

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isRight
                      ? AppTheme.success.withOpacity(0.5)
                      : AppTheme.error.withOpacity(0.5),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: isRight
                              ? AppTheme.success.withOpacity(0.1)
                              : AppTheme.error.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Q${i + 1}',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            color: isRight ? AppTheme.success : AppTheme.error,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        isRight
                            ? Icons.check_circle_rounded
                            : Icons.cancel_rounded,
                        color: isRight ? AppTheme.success : AppTheme.error,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    q.question,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (!isRight && userAns >= 0) ...[
                    _AnswerRow(
                      label: 'Your answer',
                      text: q.options[userAns],
                      color: AppTheme.error,
                    ),
                    const SizedBox(height: 4),
                  ],
                  _AnswerRow(
                    label: 'Correct answer',
                    text: q.options[correct],
                    color: AppTheme.success,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppTheme.background,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('💡', style: TextStyle(fontSize: 16)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            q.explanation,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: AppTheme.textLight,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(
                  delay: Duration(milliseconds: 80 * i),
                  duration: 350.ms,
                );
          }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;
  final String emoji;
  final Color color;

  const _InfoTile({
    required this.label,
    required this.value,
    required this.emoji,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 4),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: color,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: AppTheme.textLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnswerRow extends StatelessWidget {
  final String label;
  final String text;
  final Color color;

  const _AnswerRow({
    required this.label,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: AppTheme.textLight,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
