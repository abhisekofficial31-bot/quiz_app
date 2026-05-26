import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../data/user_provider.dart';
import '../models/quiz_model.dart';
import '../theme/app_theme.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final QuizCategory category;
  final Level level;
  final Color color;

  const QuizScreen({
    super.key,
    required this.category,
    required this.level,
    required this.color,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  int _score = 0;
  int _selectedAnswer = -1;
  bool _answered = false;
  late int _timeLeft;
  Timer? _timer;
  List<int> _userAnswers = [];

  late AnimationController _questionAnimCtrl;
  late AnimationController _optionAnimCtrl;

  @override
  void initState() {
    super.initState();
    _timeLeft = widget.level.timePerQuestion;
    _questionAnimCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _optionAnimCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _userAnswers = List.filled(widget.level.questions.length, -1);
    _startTimer();
    _questionAnimCtrl.forward();
  }

  void _startTimer() {
    _timer?.cancel();
    _timeLeft = widget.level.timePerQuestion;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      setState(() => _timeLeft--);
      if (_timeLeft <= 0) {
        t.cancel();
        _onTimeUp();
      }
    });
  }

  void _onTimeUp() {
    if (!_answered) {
      HapticFeedback.heavyImpact();
      setState(() {
        _answered = true;
        _selectedAnswer = -1;
      });
      Future.delayed(const Duration(milliseconds: 1200), _nextQuestion);
    }
  }

  void _selectAnswer(int index) {
    if (_answered) return;
    _timer?.cancel();
    HapticFeedback.lightImpact();

    final correct = widget.level.questions[_currentIndex].correctIndex;
    setState(() {
      _selectedAnswer = index;
      _answered = true;
      _userAnswers[_currentIndex] = index;
      if (index == correct) {
        _score++;
        HapticFeedback.mediumImpact();
      } else {
        HapticFeedback.heavyImpact();
      }
    });
    Future.delayed(const Duration(milliseconds: 1400), _nextQuestion);
  }

  void _nextQuestion() {
    if (!mounted) return;
    if (_currentIndex >= widget.level.questions.length - 1) {
      _goToResult();
      return;
    }
    _questionAnimCtrl.reverse().then((_) {
      if (!mounted) return;
      setState(() {
        _currentIndex++;
        _selectedAnswer = -1;
        _answered = false;
      });
      _startTimer();
      _questionAnimCtrl.forward();
    });
  }

  void _goToResult() async {
    _timer?.cancel();
    final user = context.read<UserProvider>();
    await user.completeLevel(
      categoryId: widget.category.id,
      level: widget.level.levelNumber,
      score: _score,
      totalQuestions: widget.level.questions.length,
      categoryName: widget.category.name,
      emoji: widget.category.emoji,
    );
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (_, __, ___) => ResultScreen(
          score: _score,
          total: widget.level.questions.length,
          level: widget.level,
          category: widget.category,
          color: widget.color,
          userAnswers: _userAnswers,
        ),
        transitionsBuilder: (_, anim, __, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
            child: child,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _questionAnimCtrl.dispose();
    _optionAnimCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final questions = widget.level.questions;
    final question = questions[_currentIndex];
    final progress = (_currentIndex + 1) / questions.length;
    final timeFraction = _timeLeft / widget.level.timePerQuestion;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top Bar ───────────────────────────────────────────────────
            _buildTopBar(progress),
            const SizedBox(height: 16),

            // ── Timer + Question Number ────────────────────────────────────
            _buildTimerRow(timeFraction),
            const SizedBox(height: 20),

            // ── Question Card ─────────────────────────────────────────────
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    FadeTransition(
                      opacity: _questionAnimCtrl,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.1, 0),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                            parent: _questionAnimCtrl,
                            curve: Curves.easeOut)),
                        child: _buildQuestionCard(question),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: question.options.length,
                        itemBuilder: (context, i) {
                          return _buildOption(question, i)
                              .animate()
                              .fadeIn(
                                  delay: Duration(milliseconds: 80 * i + 200),
                                  duration: 300.ms)
                              .slideX(begin: 0.2, end: 0);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(double progress) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => _showQuitDialog(),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 8,
                  )
                ],
              ),
              child: const Icon(Icons.close_rounded, size: 20),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.category.name} • Level ${widget.level.levelNumber}',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppTheme.textLight,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: progress),
                  duration: const Duration(milliseconds: 400),
                  builder: (_, val, __) => LinearProgressIndicator(
                    value: val,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation(widget.color),
                    borderRadius: BorderRadius.circular(10),
                    minHeight: 8,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: widget.color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '⭐ $_score',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                color: widget.color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimerRow(double timeFraction) {
    final timerColor = timeFraction > 0.5
        ? AppTheme.success
        : timeFraction > 0.25
            ? Colors.orange
            : AppTheme.error;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularPercentIndicator(
          radius: 36,
          lineWidth: 5,
          percent: timeFraction.clamp(0, 1),
          center: Text(
            '$_timeLeft',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: timerColor,
            ),
          ),
          progressColor: timerColor,
          backgroundColor: timerColor.withOpacity(0.15),
          animation: false,
        ),
        const SizedBox(width: 16),
        Text(
          'Question ${_currentIndex + 1} of ${widget.level.questions.length}',
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppTheme.textDark,
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionCard(Question question) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [widget.color, widget.color.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: widget.color.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Text(
        question.question,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildOption(Question question, int optionIndex) {
    final isSelected = _selectedAnswer == optionIndex;
    final isCorrect = question.correctIndex == optionIndex;
    final showResult = _answered;

    Color bgColor = Colors.white;
    Color borderColor = Colors.grey.shade200;
    Color textColor = AppTheme.textDark;
    Widget? trailingIcon;

    if (showResult) {
      if (isCorrect) {
        bgColor = AppTheme.success.withOpacity(0.1);
        borderColor = AppTheme.success;
        textColor = AppTheme.success;
        trailingIcon = const Icon(Icons.check_circle_rounded,
            color: AppTheme.success, size: 22);
      } else if (isSelected && !isCorrect) {
        bgColor = AppTheme.error.withOpacity(0.1);
        borderColor = AppTheme.error;
        textColor = AppTheme.error;
        trailingIcon = const Icon(Icons.cancel_rounded,
            color: AppTheme.error, size: 22);
      }
    } else if (isSelected) {
      bgColor = widget.color.withOpacity(0.1);
      borderColor = widget.color;
      textColor = widget.color;
    }

    return GestureDetector(
      onTap: () => _selectAnswer(optionIndex),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: borderColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  ['A', 'B', 'C', 'D'][optionIndex],
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: textColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                question.options[optionIndex],
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ),
            if (trailingIcon != null) trailingIcon,
          ],
        ),
      ),
    );
  }

  void _showQuitDialog() {
    _timer?.cancel();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Quit Quiz?',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
        content: Text('Your progress will be lost.',
            style: GoogleFonts.poppins()),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _startTimer();
            },
            child: Text('Continue', style: GoogleFonts.poppins(color: widget.color)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.error),
            child: Text('Quit', style: GoogleFonts.poppins()),
          ),
        ],
      ),
    );
  }
}
