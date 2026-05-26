import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../data/user_provider.dart';
import '../models/quiz_model.dart';
import '../theme/app_theme.dart';
import 'main_nav.dart';
import '../widgets/reward_popup.dart';

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
  bool _showReview = false;
  bool _showRewardPopup = true;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();
    final reward = user.pendingReward;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: _showReview ? _buildReview() : _buildResult(),
            ),
          ),
          // Reward popup
          if (_showRewardPopup && reward != null)
            RewardPopup(
              reward: reward,
              onContinue: () {
                context.read<UserProvider>().clearPendingReward();
                setState(() => _showRewardPopup = false);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildResult() {
    final pct = widget.score / widget.total;
    final emoji = widget.score == widget.total ? '🏆'
        : pct >= 0.8 ? '🌟' : pct >= 0.6 ? '😊' : pct >= 0.4 ? '😐' : '💪';
    final title = widget.score == widget.total ? 'Perfect Score!'
        : pct >= 0.8 ? 'Excellent!' : pct >= 0.6 ? 'Good Job!'
        : pct >= 0.4 ? 'Not Bad!' : 'Keep Practicing!';

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Score card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [widget.color, widget.color.withOpacity(0.7)],
                begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(26),
              boxShadow: [BoxShadow(
                color: widget.color.withOpacity(0.3),
                blurRadius: 22, offset: const Offset(0, 8))],
            ),
            child: Column(
              children: [
                Text(emoji, style: const TextStyle(fontSize: 68)),
                const SizedBox(height: 12),
                Text(title, style: GoogleFonts.poppins(
                  fontSize: 26, fontWeight: FontWeight.w800, color: Colors.white)),
                const SizedBox(height: 6),
                Text(
                  '${widget.category.name} · Level ${widget.level.levelNumber}',
                  style: GoogleFonts.poppins(fontSize: 13, color: Colors.white70)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${widget.score}',
                      style: GoogleFonts.poppins(fontSize: 60,
                        fontWeight: FontWeight.w900, color: Colors.white)),
                    Text(' / ${widget.total}',
                      style: GoogleFonts.poppins(fontSize: 30, color: Colors.white60)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (i) {
                    final filled = i < (pct >= 0.9 ? 3 : pct >= 0.6 ? 2 : pct >= 0.3 ? 1 : 0);
                    return Icon(
                      filled ? Icons.star_rounded : Icons.star_outline_rounded,
                      color: filled ? AppTheme.accent : Colors.white30,
                      size: 38,
                    );
                  }),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Tip for low score
          if (pct < 0.6)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppTheme.extra1.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppTheme.extra1.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  const Text('💡', style: TextStyle(fontSize: 22)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Review the answers below to learn and try again for a better score!',
                      style: GoogleFonts.poppins(
                          fontSize: 12, color: AppTheme.textDark),
                    ),
                  ),
                ],
              ),
            ),
          // Buttons
          ElevatedButton(
            onPressed: () => setState(() => _showReview = true),
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.color,
              minimumSize: const Size(double.infinity, 52),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
            child: Text('Review Answers',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w700,
                  fontSize: 15, color: Colors.white)),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 52),
              side: BorderSide(color: widget.color, width: 2),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
            child: Text('Back to Levels',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w700,
                  fontSize: 15, color: widget.color)),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const MainNav(),
                  transitionsBuilder: (_, anim, __, child) =>
                      FadeTransition(opacity: anim, child: child),
                  transitionDuration: const Duration(milliseconds: 400),
                ),
                (_) => false,
              );
            },
            child: Text('🏠 Go to Home',
              style: GoogleFonts.poppins(
                  color: AppTheme.textLight, fontWeight: FontWeight.w600)),
          ),
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
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8)],
                  ),
                  child: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                ),
              ),
              const SizedBox(width: 12),
              Text('Review Answers',
                style: GoogleFonts.poppins(fontSize: 20,
                    fontWeight: FontWeight.w700, color: AppTheme.textDark)),
            ],
          ),
          const SizedBox(height: 20),
          ...List.generate(widget.level.questions.length, (i) {
            final q = widget.level.questions[i];
            final ua = widget.userAnswers[i];
            final isRight = ua == q.correctIndex;
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: isRight ? AppTheme.success.withOpacity(0.4)
                      : AppTheme.error.withOpacity(0.4), width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: (isRight ? AppTheme.success : AppTheme.error)
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6)),
                        child: Text('Q${i + 1}',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w700,
                            color: isRight ? AppTheme.success : AppTheme.error)),
                      ),
                      const Spacer(),
                      Icon(
                        isRight ? Icons.check_circle_rounded : Icons.cancel_rounded,
                        color: isRight ? AppTheme.success : AppTheme.error,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(q.question,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600,
                        fontSize: 13, color: AppTheme.textDark)),
                  const SizedBox(height: 8),
                  if (!isRight && ua >= 0)
                    _AnswerRow('Your answer', q.options[ua], AppTheme.error),
                  _AnswerRow('Correct answer', q.options[q.correctIndex], AppTheme.success),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppTheme.background,
                      borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('💡', style: TextStyle(fontSize: 14)),
                        const SizedBox(width: 8),
                        Expanded(child: Text(q.explanation,
                          style: GoogleFonts.poppins(fontSize: 11,
                              color: AppTheme.textLight))),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _AnswerRow extends StatelessWidget {
  final String label, text;
  final Color color;
  const _AnswerRow(this.label, this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text('$label: ', style: GoogleFonts.poppins(
              fontSize: 11, color: AppTheme.textLight)),
          Expanded(child: Text(text, style: GoogleFonts.poppins(
              fontSize: 12, fontWeight: FontWeight.w600, color: color))),
        ],
      ),
    );
  }
}
