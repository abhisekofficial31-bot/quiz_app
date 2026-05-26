import '../models/quiz_model.dart';

class QuizData {
  // ── SAMPLE 10 QUESTIONS (repeated across levels for testing) ──────────────
  static const List<Question> _sampleQuestions = [
    Question(
      question: 'What is the capital of France?',
      options: ['Berlin', 'Madrid', 'Paris', 'Rome'],
      correctIndex: 2,
      explanation: 'Paris has been the capital of France since the 10th century.',
    ),
    Question(
      question: 'Which planet is known as the Red Planet?',
      options: ['Venus', 'Mars', 'Jupiter', 'Saturn'],
      correctIndex: 1,
      explanation: 'Mars appears red due to iron oxide (rust) on its surface.',
    ),
    Question(
      question: 'Who painted the Mona Lisa?',
      options: ['Van Gogh', 'Picasso', 'Michelangelo', 'Leonardo da Vinci'],
      correctIndex: 3,
      explanation: 'Leonardo da Vinci painted the Mona Lisa between 1503–1519.',
    ),
    Question(
      question: 'What is the largest ocean on Earth?',
      options: ['Atlantic', 'Indian', 'Pacific', 'Arctic'],
      correctIndex: 2,
      explanation: 'The Pacific Ocean covers more than 165 million square kilometres.',
    ),
    Question(
      question: 'How many continents are there on Earth?',
      options: ['5', '6', '7', '8'],
      correctIndex: 2,
      explanation: 'Earth has 7 continents: Africa, Antarctica, Asia, Australia, Europe, North America, and South America.',
    ),
    Question(
      question: 'What is the chemical symbol for water?',
      options: ['WA', 'H2O', 'HO2', 'W2O'],
      correctIndex: 1,
      explanation: 'Water is composed of two hydrogen atoms and one oxygen atom (H₂O).',
    ),
    Question(
      question: 'Which country is home to the kangaroo?',
      options: ['South Africa', 'India', 'Brazil', 'Australia'],
      correctIndex: 3,
      explanation: 'Kangaroos are native to Australia and are one of its national symbols.',
    ),
    Question(
      question: 'What is the speed of light?',
      options: ['300,000 km/s', '150,000 km/s', '450,000 km/s', '100,000 km/s'],
      correctIndex: 0,
      explanation: 'Light travels at approximately 299,792 kilometres per second in a vacuum.',
    ),
    Question(
      question: 'Who wrote "Romeo and Juliet"?',
      options: ['Charles Dickens', 'Mark Twain', 'William Shakespeare', 'Jane Austen'],
      correctIndex: 2,
      explanation: 'Romeo and Juliet was written by William Shakespeare around 1594–1596.',
    ),
    Question(
      question: 'What is the largest mammal in the world?',
      options: ['Elephant', 'Blue Whale', 'Giraffe', 'Polar Bear'],
      correctIndex: 1,
      explanation: 'The blue whale is the largest animal ever known to have existed, reaching up to 30 metres.',
    ),
  ];

  // ── CATEGORIES ────────────────────────────────────────────────────────────
  static final List<QuizCategory> categories = [
    QuizCategory(
      id: 'general',
      name: 'General Knowledge',
      emoji: '🌍',
      description: 'Test your knowledge across a wide range of topics.',
      levels: _buildLevels(),
    ),
    QuizCategory(
      id: 'science',
      name: 'Science',
      emoji: '🔬',
      description: 'Explore the wonders of science and technology.',
      levels: _buildLevels(),
    ),
    QuizCategory(
      id: 'history',
      name: 'History',
      emoji: '🏛️',
      description: 'Journey through the annals of human history.',
      levels: _buildLevels(),
    ),
    QuizCategory(
      id: 'sports',
      name: 'Sports',
      emoji: '⚽',
      description: 'How well do you know the world of sports?',
      levels: _buildLevels(),
    ),
    QuizCategory(
      id: 'tech',
      name: 'Technology',
      emoji: '💻',
      description: 'Dive into the digital world of technology.',
      levels: _buildLevels(),
    ),
    QuizCategory(
      id: 'geography',
      name: 'Geography',
      emoji: '🗺️',
      description: 'Explore countries, capitals and landscapes.',
      levels: _buildLevels(),
    ),
  ];

  static List<Level> _buildLevels() {
    final difficulties = [
      'Beginner', 'Beginner', 'Easy', 'Easy',
      'Medium', 'Medium', 'Hard', 'Hard',
      'Expert', 'Master',
    ];
    final titles = [
      'Getting Started', 'Warm Up', 'Rising Star', 'On Track',
      'Halfway There', 'Sharp Mind', 'Brain Teaser', 'Knowledge Seeker',
      'Expert Zone', 'Master Class',
    ];
    final times = [30, 30, 25, 25, 20, 20, 15, 15, 12, 10];

    return List.generate(10, (i) {
      return Level(
        levelNumber: i + 1,
        title: titles[i],
        difficulty: difficulties[i],
        questions: _sampleQuestions, // same 10 questions for test
        timePerQuestion: times[i],
      );
    });
  }

  // ── LEADERBOARD DATA ──────────────────────────────────────────────────────
  static const List<LeaderboardEntry> leaderboard = [
    LeaderboardEntry(name: 'Sophia Cho', score: 888, avatar: '👩', rank: 1),
    LeaderboardEntry(name: 'Emma Ema', score: 808, avatar: '🧑', rank: 2),
    LeaderboardEntry(name: 'Andrew W', score: 800, avatar: '👨', rank: 3),
    LeaderboardEntry(name: 'Raya Sadewa', score: 98, avatar: '👩‍🦱', rank: 4),
    LeaderboardEntry(name: 'Olivia Ava', score: 56, avatar: '👧', rank: 5),
    LeaderboardEntry(name: 'David Joshua', score: 62, avatar: '👦', rank: 6),
    LeaderboardEntry(name: 'Charlotte Harper', score: 81, avatar: '👩‍🦰', rank: 7),
    LeaderboardEntry(name: 'Mia Evelyn', score: 120, avatar: '🧑‍🦱', rank: 8),
  ];
}
