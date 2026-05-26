import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Achievement model
// ─────────────────────────────────────────────────────────────────────────────
class Achievement {
  final String id;
  final String title;
  final String description;
  final String emoji;
  final int diamondReward;
  bool isUnlocked;
  DateTime? unlockedAt;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.emoji,
    required this.diamondReward,
    this.isUnlocked = false,
    this.unlockedAt,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// UserProvider — complete state with 0-start, XP, streak, achievements
// ─────────────────────────────────────────────────────────────────────────────
class UserProvider extends ChangeNotifier {
  // Core stats — ALL start at 0 for new users
  String _name = '';
  String _avatar = '🧑';
  int _diamonds = 0;
  int _xp = 0;
  int _totalScore = 0;
  int _quizzesPlayed = 0;
  int _perfectScores = 0;
  int _currentStreak = 0;
  int _bestStreak = 0;
  DateTime? _lastPlayedDate;
  DateTime? _lastDailyClaimDate;

  // Level / chapter progress
  Map<String, int> _unlockedLevels = {};
  Map<String, Map<int, int>> _levelScores = {};
  List<Map<String, dynamic>> _recentPlayed = [];

  // Pending reward — shown once after level complete
  Map<String, dynamic>? _pendingReward;

  // Achievements list
  late List<Achievement> _achievements;

  // ── Getters ──────────────────────────────────────────────────────────────
  String get name => _name;
  String get avatar => _avatar;
  int get diamonds => _diamonds;
  int get xp => _xp;
  int get totalScore => _totalScore;
  int get quizzesPlayed => _quizzesPlayed;
  int get perfectScores => _perfectScores;
  int get currentStreak => _currentStreak;
  int get bestStreak => _bestStreak;
  List<Map<String, dynamic>> get recentPlayed => _recentPlayed;
  List<Achievement> get achievements => _achievements;
  Map<String, dynamic>? get pendingReward => _pendingReward;

  bool get isNewUser => _name.isEmpty;
  bool get canClaimDailyReward => _canClaimToday();

  // XP level — every 100 XP = 1 level
  int get xpLevel => (_xp ~/ 100) + 1;
  int get xpInCurrentLevel => _xp % 100;
  double get xpProgress => xpInCurrentLevel / 100.0;

  // Streak title
  String get streakTitle {
    if (_currentStreak == 0) return 'Start your streak!';
    if (_currentStreak < 3) return 'Getting started 🌱';
    if (_currentStreak < 7) return 'On fire 🔥';
    if (_currentStreak < 14) return 'Unstoppable ⚡';
    return 'Legendary 👑';
  }

  int getUnlockedLevel(String categoryId) => _unlockedLevels[categoryId] ?? 1;
  int getLevelScore(String categoryId, int level) =>
      _levelScores[categoryId]?[level] ?? 0;

  // ── Daily reward amount based on streak ─────────────────────────────────
  int get dailyRewardAmount {
    if (_currentStreak >= 30) return 100;
    if (_currentStreak >= 14) return 50;
    if (_currentStreak >= 7) return 30;
    if (_currentStreak >= 3) return 20;
    return 10;
  }

  // ── Init achievements ────────────────────────────────────────────────────
  void _initAchievements() {
    _achievements = [
      Achievement(id: 'first_quiz',     title: 'First Step',      description: 'Complete your first quiz',              emoji: '🎯', diamondReward: 15),
      Achievement(id: 'perfect_score',  title: 'Perfectionist',   description: 'Get a perfect score on any quiz',       emoji: '💯', diamondReward: 25),
      Achievement(id: 'streak_3',       title: 'Hat Trick',       description: 'Play 3 days in a row',                 emoji: '🔥', diamondReward: 20),
      Achievement(id: 'streak_7',       title: 'Week Warrior',    description: 'Play 7 days in a row',                 emoji: '⚡', diamondReward: 50),
      Achievement(id: 'streak_30',      title: 'Legendary',       description: 'Play 30 days in a row',                emoji: '👑', diamondReward: 200),
      Achievement(id: 'quiz_5',         title: 'Warming Up',      description: 'Complete 5 quizzes',                   emoji: '🎮', diamondReward: 20),
      Achievement(id: 'quiz_25',        title: 'Quiz Enthusiast', description: 'Complete 25 quizzes',                  emoji: '📚', diamondReward: 50),
      Achievement(id: 'quiz_100',       title: 'Quiz Master',     description: 'Complete 100 quizzes',                 emoji: '🏆', diamondReward: 150),
      Achievement(id: 'perfect_3',      title: 'Triple Perfect',  description: 'Get 3 perfect scores',                 emoji: '🌟', diamondReward: 40),
      Achievement(id: 'xp_500',         title: 'XP Hunter',       description: 'Earn 500 XP',                          emoji: '⭐', diamondReward: 30),
      Achievement(id: 'diamond_100',    title: 'Diamond Collector', description: 'Collect 100 diamonds',             emoji: '💎', diamondReward: 0),
    ];
  }

  // ── Load from SharedPreferences ──────────────────────────────────────────
  Future<void> load() async {
    _initAchievements();
    final prefs = await SharedPreferences.getInstance();

    _name             = prefs.getString('v2_name') ?? '';
    _avatar           = prefs.getString('v2_avatar') ?? '🧑';
    _diamonds         = prefs.getInt('v2_diamonds') ?? 0;       // ← starts at 0
    _xp               = prefs.getInt('v2_xp') ?? 0;
    _totalScore       = prefs.getInt('v2_totalScore') ?? 0;
    _quizzesPlayed    = prefs.getInt('v2_quizzesPlayed') ?? 0;
    _perfectScores    = prefs.getInt('v2_perfectScores') ?? 0;
    _currentStreak    = prefs.getInt('v2_currentStreak') ?? 0;
    _bestStreak       = prefs.getInt('v2_bestStreak') ?? 0;

    final lastPlayedStr = prefs.getString('v2_lastPlayedDate');
    if (lastPlayedStr != null) {
      _lastPlayedDate = DateTime.tryParse(lastPlayedStr);
    }
    final lastClaimStr = prefs.getString('v2_lastDailyClaimDate');
    if (lastClaimStr != null) {
      _lastDailyClaimDate = DateTime.tryParse(lastClaimStr);
    }

    // Load unlocked levels
    for (final key in prefs.getKeys()) {
      if (key.startsWith('v2_unlocked_')) {
        final catId = key.replaceFirst('v2_unlocked_', '');
        _unlockedLevels[catId] = prefs.getInt(key) ?? 1;
      }
      if (key.startsWith('v2_score_')) {
        final parts = key.replaceFirst('v2_score_', '').split('_lvl_');
        if (parts.length == 2) {
          final catId = parts[0];
          final level = int.tryParse(parts[1]) ?? 1;
          _levelScores[catId] ??= {};
          _levelScores[catId]![level] = prefs.getInt(key) ?? 0;
        }
      }
    }

    // Load unlocked achievement ids
    final unlockedIds = prefs.getStringList('v2_achievements') ?? [];
    for (final a in _achievements) {
      if (unlockedIds.contains(a.id)) {
        a.isUnlocked = true;
      }
    }

    // Load recent played
    final recentJson = prefs.getStringList('v2_recentPlayed') ?? [];
    _recentPlayed = recentJson.map((e) {
      final parts = e.split('|');
      if (parts.length < 5) return <String, dynamic>{};
      return <String, dynamic>{
        'categoryId':   parts[0],
        'categoryName': parts[1],
        'emoji':        parts[2],
        'level':        int.tryParse(parts[3]) ?? 1,
        'score':        int.tryParse(parts[4]) ?? 0,
      };
    }).where((e) => e.isNotEmpty).toList();

    // Check & update streak on load
    _updateStreakOnLoad();

    notifyListeners();
  }

  // ── Streak logic ─────────────────────────────────────────────────────────
  void _updateStreakOnLoad() {
    if (_lastPlayedDate == null) return;
    final today = _today();
    final diff = today.difference(_lastPlayedDate!).inDays;
    if (diff > 1) {
      // Missed a day — reset streak
      _currentStreak = 0;
      _saveStreak();
    }
  }

  DateTime _today() {
    final n = DateTime.now();
    return DateTime(n.year, n.month, n.day);
  }

  bool _canClaimToday() {
    if (_lastDailyClaimDate == null) return true;
    return _today().isAfter(_lastDailyClaimDate!);
  }

  Future<void> claimDailyReward() async {
    if (!_canClaimToday()) return;
    final reward = dailyRewardAmount;
    _diamonds += reward;
    _lastDailyClaimDate = _today();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('v2_diamonds', _diamonds);
    await prefs.setString('v2_lastDailyClaimDate', _lastDailyClaimDate!.toIso8601String());
    notifyListeners();
  }

  // ── Setup profile (first time) ───────────────────────────────────────────
  Future<void> setupProfile({required String name, required String avatar}) async {
    _name   = name;
    _avatar = avatar;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('v2_name', name);
    await prefs.setString('v2_avatar', avatar);
    notifyListeners();
  }

  Future<void> updateName(String name) async {
    _name = name;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('v2_name', name);
    notifyListeners();
  }

  Future<void> updateAvatar(String avatar) async {
    _avatar = avatar;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('v2_avatar', avatar);
    notifyListeners();
  }

  // ── Complete a level — full reward calculation ───────────────────────────
  Future<void> completeLevel({
    required String categoryId,
    required int level,
    required int score,
    required int totalQuestions,
    required String categoryName,
    required String emoji,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final isPerfect = score == totalQuestions;
    final prevScore = _levelScores[categoryId]?[level] ?? 0;
    final isFirstTime = prevScore == 0;

    // ── Calculate rewards ────────────────────────────────────────────────
    int earnedDiamonds = 0;
    int earnedXp = 0;
    final List<String> bonuses = [];

    if (isPerfect) {
      earnedDiamonds += 15;
      earnedXp += 50;
      bonuses.add('Perfect Score! +15💎');
      _perfectScores++;
      await prefs.setInt('v2_perfectScores', _perfectScores);
    } else if (score >= (totalQuestions * 0.7).ceil()) {
      earnedDiamonds += 8;
      earnedXp += 30;
      bonuses.add('Great Score! +8💎');
    } else if (score >= (totalQuestions * 0.4).ceil()) {
      earnedDiamonds += 4;
      earnedXp += 15;
      bonuses.add('Good Try! +4💎');
    } else {
      earnedDiamonds += 2;
      earnedXp += 8;
      bonuses.add('Completed! +2💎');
    }

    // First time bonus
    if (isFirstTime) {
      earnedDiamonds += 5;
      earnedXp += 20;
      bonuses.add('First Time! +5💎');
    }

    // Update score only if better
    if (score > prevScore) {
      _levelScores[categoryId] ??= {};
      _levelScores[categoryId]![level] = score;
      await prefs.setInt('v2_score_${categoryId}_lvl_$level', score);
      _totalScore += (score - prevScore);
      await prefs.setInt('v2_totalScore', _totalScore);
    }

    // Apply rewards
    _diamonds += earnedDiamonds;
    _xp += earnedXp;
    _quizzesPlayed++;
    await prefs.setInt('v2_diamonds', _diamonds);
    await prefs.setInt('v2_xp', _xp);
    await prefs.setInt('v2_quizzesPlayed', _quizzesPlayed);

    // Unlock next level
    final currentUnlocked = _unlockedLevels[categoryId] ?? 1;
    if (level >= currentUnlocked && level < 10) {
      _unlockedLevels[categoryId] = level + 1;
      await prefs.setInt('v2_unlocked_$categoryId', level + 1);
    }

    // Update streak
    await _updateStreak(prefs);

    // Check achievements
    final newAchievements = await _checkAchievements(prefs);
    for (final a in newAchievements) {
      earnedDiamonds += a.diamondReward;
      if (a.diamondReward > 0) bonuses.add('${a.emoji} ${a.title} +${a.diamondReward}💎');
    }
    if (newAchievements.isNotEmpty) {
      _diamonds += newAchievements.fold(0, (sum, a) => sum + a.diamondReward);
      await prefs.setInt('v2_diamonds', _diamonds);
    }

    // Set pending reward for popup
    _pendingReward = {
      'score': score,
      'total': totalQuestions,
      'diamonds': earnedDiamonds,
      'xp': earnedXp,
      'isPerfect': isPerfect,
      'isFirstTime': isFirstTime,
      'bonuses': bonuses,
      'newAchievements': newAchievements.map((a) => a.title).toList(),
      'streakDay': _currentStreak,
    };

    // Recent played
    final entry = <String, dynamic>{
      'categoryId': categoryId, 'categoryName': categoryName,
      'emoji': emoji, 'level': level, 'score': score,
    };
    _recentPlayed.removeWhere(
        (e) => e['categoryId'] == categoryId && e['level'] == level);
    _recentPlayed.insert(0, entry);
    if (_recentPlayed.length > 5) _recentPlayed = _recentPlayed.sublist(0, 5);
    await prefs.setStringList('v2_recentPlayed',
        _recentPlayed.map((e) =>
            '${e['categoryId']}|${e['categoryName']}|${e['emoji']}|${e['level']}|${e['score']}').toList());

    notifyListeners();
  }

  // ── Streak update ────────────────────────────────────────────────────────
  Future<void> _updateStreak(SharedPreferences prefs) async {
    final today = _today();
    if (_lastPlayedDate == null) {
      _currentStreak = 1;
    } else {
      final diff = today.difference(_lastPlayedDate!).inDays;
      if (diff == 0) {
        // Already played today — no change
      } else if (diff == 1) {
        _currentStreak++;
      } else {
        _currentStreak = 1;
      }
    }
    if (_currentStreak > _bestStreak) _bestStreak = _currentStreak;
    _lastPlayedDate = today;
    await _saveStreak();
    await prefs.setString('v2_lastPlayedDate', today.toIso8601String());
    await prefs.setInt('v2_bestStreak', _bestStreak);
  }

  Future<void> _saveStreak() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('v2_currentStreak', _currentStreak);
  }

  // ── Check achievements ───────────────────────────────────────────────────
  Future<List<Achievement>> _checkAchievements(SharedPreferences prefs) async {
    final newlyUnlocked = <Achievement>[];
    final checks = {
      'first_quiz':    _quizzesPlayed >= 1,
      'perfect_score': _perfectScores >= 1,
      'streak_3':      _currentStreak >= 3,
      'streak_7':      _currentStreak >= 7,
      'streak_30':     _currentStreak >= 30,
      'quiz_5':        _quizzesPlayed >= 5,
      'quiz_25':       _quizzesPlayed >= 25,
      'quiz_100':      _quizzesPlayed >= 100,
      'perfect_3':     _perfectScores >= 3,
      'xp_500':        _xp >= 500,
      'diamond_100':   _diamonds >= 100,
    };

    for (final a in _achievements) {
      if (!a.isUnlocked && (checks[a.id] ?? false)) {
        a.isUnlocked = true;
        a.unlockedAt = DateTime.now();
        newlyUnlocked.add(a);
      }
    }

    if (newlyUnlocked.isNotEmpty) {
      final unlockedIds =
          _achievements.where((a) => a.isUnlocked).map((a) => a.id).toList();
      await prefs.setStringList('v2_achievements', unlockedIds);
    }

    return newlyUnlocked;
  }

  // ── Clear pending reward after showing ──────────────────────────────────
  void clearPendingReward() {
    _pendingReward = null;
    notifyListeners();
  }

  // ── Reset all (for testing) ──────────────────────────────────────────────
  Future<void> resetAll() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().where((k) => k.startsWith('v2_')).toList();
    for (final k in keys) await prefs.remove(k);
    _name = ''; _avatar = '🧑'; _diamonds = 0; _xp = 0;
    _totalScore = 0; _quizzesPlayed = 0; _perfectScores = 0;
    _currentStreak = 0; _bestStreak = 0;
    _lastPlayedDate = null; _lastDailyClaimDate = null;
    _unlockedLevels = {}; _levelScores = {}; _recentPlayed = [];
    _pendingReward = null;
    _initAchievements();
    notifyListeners();
  }
}
