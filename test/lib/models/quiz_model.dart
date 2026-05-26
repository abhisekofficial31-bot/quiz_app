class Question {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const Question({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}

class QuizCategory {
  final String id;
  final String name;
  final String emoji;
  final String description;
  final List<Level> levels;

  const QuizCategory({
    required this.id,
    required this.name,
    required this.emoji,
    required this.description,
    required this.levels,
  });
}

class Level {
  final int levelNumber;
  final String title;
  final String difficulty;
  final List<Question> questions;
  final int timePerQuestion; // seconds

  const Level({
    required this.levelNumber,
    required this.title,
    required this.difficulty,
    required this.questions,
    required this.timePerQuestion,
  });
}

class LeaderboardEntry {
  final String name;
  final int score;
  final String avatar;
  final int rank;

  const LeaderboardEntry({
    required this.name,
    required this.score,
    required this.avatar,
    required this.rank,
  });
}
