import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../data/quiz_data.dart';
import '../models/quiz_model.dart';
import '../widgets/themed_widgets.dart';
import 'levels_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ThScaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ThHeroHeader(
              title: 'All Categories',
              subtitle: 'Choose a topic and start quizzing!',
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.85,
                  crossAxisSpacing: 12, mainAxisSpacing: 12),
                itemCount: QuizData.categories.length,
                itemBuilder: (context, i) {
                  final cat   = QuizData.categories[i];
                  final color = AppTheme.categoryColor(i);
                  return _CategoryCard(
                    category: cat, color: color, index: i);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatefulWidget {
  final QuizCategory category;
  final Color color;
  final int index;
  const _CategoryCard({required this.category, required this.color, required this.index});

  @override
  State<_CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<_CategoryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 150));
    _scale = Tween<double>(begin: 1, end: 0.95)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scale,
      builder: (_, child) =>
          Transform.scale(scale: _scale.value, child: child),
      child: GestureDetector(
        onTapDown: (_) => _ctrl.forward(),
        onTapUp: (_) {
          _ctrl.reverse();
          Navigator.push(context, PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (_, __, ___) => LevelsScreen(
                category: widget.category, color: widget.color),
            transitionsBuilder: (_, anim, __, child) => SlideTransition(
              position: Tween<Offset>(
                      begin: const Offset(0, 1), end: Offset.zero)
                  .animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
              child: child),
          ));
        },
        onTapCancel: () => _ctrl.reverse(),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [widget.color, widget.color.withOpacity(0.75)],
              begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [BoxShadow(
                color: widget.color.withOpacity(0.35),
                blurRadius: 12, offset: const Offset(0, 5))],
          ),
          child: Stack(
            children: [
              Positioned(right: -15, bottom: -15,
                child: Text(widget.category.emoji,
                    style: const TextStyle(fontSize: 78))),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.category.emoji,
                        style: const TextStyle(fontSize: 34)),
                    const Spacer(),
                    ThText(widget.category.name,
                        fontSize: 15, fontWeight: FontWeight.w700,
                        color: Colors.white),
                    const SizedBox(height: 3),
                    ThText(widget.category.description,
                        fontSize: 10, color: Colors.white70,
                        maxLines: 2),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.22),
                        borderRadius: BorderRadius.circular(8)),
                      child: ThText('10 Levels',
                          fontSize: 10, fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(
          delay: Duration(milliseconds: 60 * widget.index), duration: 400.ms)
     .scale(begin: const Offset(0.85, 0.85), end: const Offset(1, 1));
  }
}
