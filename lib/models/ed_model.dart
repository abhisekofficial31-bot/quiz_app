// ─────────────────────────────────────────────────────────────────────────────
// EdTech Models — Class → Subject → Chapter → SubTopic → Questions
// ─────────────────────────────────────────────────────────────────────────────

class SchoolClass {
  final int classNumber;       // 1, 2, 3 … 12
  final String label;          // "Class 1"
  final String emoji;
  final List<SchoolSubject> subjects;

  const SchoolClass({
    required this.classNumber,
    required this.label,
    required this.emoji,
    required this.subjects,
  });
}

class SchoolSubject {
  final String id;
  final String name;
  final String emoji;
  final Color color;           // display color (stored as int)
  final String description;
  final List<SchoolChapter> chapters;

  const SchoolSubject({
    required this.id,
    required this.name,
    required this.emoji,
    required this.color,
    required this.description,
    required this.chapters,
  });
}

class Color {
  final int value;
  const Color(this.value);
}

class SchoolChapter {
  final int chapterNumber;
  final String title;          // Real NCERT chapter title
  final String emoji;
  final String summary;        // One-line what this chapter is about
  final List<SubTopic> subTopics;

  const SchoolChapter({
    required this.chapterNumber,
    required this.title,
    required this.emoji,
    required this.summary,
    required this.subTopics,
  });
}

class SubTopic {
  final int topicNumber;       // Level number within the chapter
  final String title;          // Sub-topic name
  final String emoji;
  final List<EdQuestion> questions;

  const SubTopic({
    required this.topicNumber,
    required this.title,
    required this.emoji,
    required this.questions,
  });
}

class EdQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;
  final String? funFact;       // optional fun fact for kids

  const EdQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
    this.funFact,
  });
}
