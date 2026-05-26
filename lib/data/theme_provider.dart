import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  AppThemeData _current = AppThemes.defaultTheme;

  AppThemeData get current => _current;
  String get id => _current.id;

  // Quick-access color getters — whole app uses these
  Color get primary    => _current.primary;
  Color get secondary  => _current.secondary;
  Color get accent     => _current.accent;
  Color get background => _current.background;
  Color get cardBg     => _current.cardBg;
  Color get textDark   => _current.textDark;
  Color get textLight  => _current.textLight;
  Color get success    => _current.success;
  Color get error      => _current.error;
  Color get extra1     => _current.extra1;
  Color get extra2     => _current.extra2;
  bool  get isDark     => _current.isDark;

  List<Color> get categoryColors => _current.categoryColors;
  List<String> get particles     => _current.particles;

  Color categoryColor(int index) =>
      _current.categoryColors[index % _current.categoryColors.length];

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final savedId = prefs.getString('theme_id') ?? 'default';
    final saved = AppThemes.fromId(savedId);
    // If the saved theme is locked, fall back to default
    _current = saved.isLocked ? AppThemes.defaultTheme : saved;
    notifyListeners();
  }

  Future<void> setTheme(String id) async {
    final theme = AppThemes.fromId(id);
    if (theme.isLocked) return; // guard: never apply a locked theme
    _current = theme;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_id', id);
    notifyListeners();
  }

  ThemeData get flutterTheme => _current.toFlutterTheme();
}
