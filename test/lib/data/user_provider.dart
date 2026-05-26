import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String _name = 'Quiz Master';
  int _totalScore = 0;
  int _diamonds = 20;
  Map<String, int> _unlockedLevels = {}; // categoryId -> max unlocked level (1-indexed)
  Map<String, Map<int, int>> _levelScores = {}; // categoryId -> {levelNum: score}
  List<Map<String, dynamic>> _recentPlayed = [];

  String get name => _name;
  int get totalScore => _totalScore;
  int get diamonds => _diamonds;
  Map<String, int> get unlockedLevels => _unlockedLevels;
  List<Map<String, dynamic>> get recentPlayed => _recentPlayed;

  int getUnlockedLevel(String categoryId) => _unlockedLevels[categoryId] ?? 1;
  int getLevelScore(String categoryId, int level) =>
      _levelScores[categoryId]?[level] ?? 0;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _name = prefs.getString('name') ?? 'Quiz Master';
    _totalScore = prefs.getInt('totalScore') ?? 0;
    _diamonds = prefs.getInt('diamonds') ?? 20;

    // Load unlocked levels
    final keys = prefs.getKeys();
    for (final key in keys) {
      if (key.startsWith('unlocked_')) {
        final catId = key.replaceFirst('unlocked_', '');
        _unlockedLevels[catId] = prefs.getInt(key) ?? 1;
      }
      if (key.startsWith('score_')) {
        final parts = key.replaceFirst('score_', '').split('_level_');
        if (parts.length == 2) {
          final catId = parts[0];
          final level = int.tryParse(parts[1]) ?? 1;
          _levelScores[catId] ??= {};
          _levelScores[catId]![level] = prefs.getInt(key) ?? 0;
        }
      }
    }

    // Load recent played
    final recentJson = prefs.getStringList('recentPlayed') ?? [];
    _recentPlayed = recentJson.map((e) {
      final parts = e.split('|');
      return {
        'categoryId': parts[0],
        'categoryName': parts[1],
        'emoji': parts[2],
        'level': int.tryParse(parts[3]) ?? 1,
        'score': int.tryParse(parts[4]) ?? 0,
      };
    }).toList();

    notifyListeners();
  }

  Future<void> setName(String name) async {
    _name = name;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    notifyListeners();
  }

  Future<void> completeLevel({
    required String categoryId,
    required int level,
    required int score,
    required int totalQuestions,
    required String categoryName,
    required String emoji,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    // Update score
    final prevScore = _levelScores[categoryId]?[level] ?? 0;
    if (score > prevScore) {
      _levelScores[categoryId] ??= {};
      _levelScores[categoryId]![level] = score;
      await prefs.setInt('score_${categoryId}_level_$level', score);

      _totalScore += (score - prevScore);
      await prefs.setInt('totalScore', _totalScore);

      // Award diamonds for good score
      if (score == totalQuestions) {
        _diamonds += 10;
      } else if (score >= totalQuestions * 0.7) {
        _diamonds += 5;
      } else {
        _diamonds += 2;
      }
      await prefs.setInt('diamonds', _diamonds);
    }

    // Unlock next level
    final currentUnlocked = _unlockedLevels[categoryId] ?? 1;
    if (level >= currentUnlocked && level < 10) {
      _unlockedLevels[categoryId] = level + 1;
      await prefs.setInt('unlocked_$categoryId', level + 1);
    }

    // Add to recent played
    final entry = {
      'categoryId': categoryId,
      'categoryName': categoryName,
      'emoji': emoji,
      'level': level,
      'score': score,
    };
    _recentPlayed.removeWhere(
        (e) => e['categoryId'] == categoryId && e['level'] == level);
    _recentPlayed.insert(0, entry);
    if (_recentPlayed.length > 5) _recentPlayed = _recentPlayed.sublist(0, 5);

    final recentJson = _recentPlayed.map((e) =>
        '${e['categoryId']}|${e['categoryName']}|${e['emoji']}|${e['level']}|${e['score']}').toList();
    await prefs.setStringList('recentPlayed', recentJson);

    notifyListeners();
  }
}
