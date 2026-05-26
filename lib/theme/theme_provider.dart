import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ─────────────────────────────────────────────────────────────────────────────
// HeroTheme — full definition for one superhero or category theme
// ─────────────────────────────────────────────────────────────────────────────
class HeroTheme {
  final String id;
  final String name;
  final String emoji;
  final String tagline;
  final String category; // 'marvel' | 'dc' | 'anime' | 'classic'

  // Core palette
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color background;
  final Color cardBg;
  final Color textDark;
  final Color textLight;

  // Gradient for headers / backgrounds
  final List<Color> gradientColors;

  // Pattern emoji for background decoration
  final String patternEmoji;

  // Font family name hint (used with Google Fonts)
  final String fontFamily;

  const HeroTheme({
    required this.id,
    required this.name,
    required this.emoji,
    required this.tagline,
    required this.category,
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.background,
    required this.cardBg,
    required this.textDark,
    required this.textLight,
    required this.gradientColors,
    required this.patternEmoji,
    required this.fontFamily,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// All available themes
// ─────────────────────────────────────────────────────────────────────────────
class AppThemes {
  static const HeroTheme spiderman = HeroTheme(
    id: 'spiderman',
    name: 'Spider-Man',
    emoji: '🕷️',
    tagline: 'With great power comes great quiz!',
    category: 'marvel',
    primary: Color(0xFFCC0000),
    secondary: Color(0xFF1A1A2E),
    accent: Color(0xFF0066CC),
    background: Color(0xFFFFF5F5),
    cardBg: Color(0xFFFFFFFF),
    textDark: Color(0xFF1A0000),
    textLight: Color(0xFF8A6A6A),
    gradientColors: [Color(0xFFCC0000), Color(0xFF880000)],
    patternEmoji: '🕸️',
    fontFamily: 'Bangers',
  );

  static const HeroTheme ironman = HeroTheme(
    id: 'ironman',
    name: 'Iron Man',
    emoji: '🦾',
    tagline: 'Genius. Billionaire. Quiz Master.',
    category: 'marvel',
    primary: Color(0xFFE8000D),
    secondary: Color(0xFF1C1C1C),
    accent: Color(0xFFFFD700),
    background: Color(0xFF0D0D0D),
    cardBg: Color(0xFF1A1A1A),
    textDark: Color(0xFFFFFFFF),
    textLight: Color(0xFFB0B0B0),
    gradientColors: [Color(0xFFE8000D), Color(0xFFFFD700)],
    patternEmoji: '⚙️',
    fontFamily: 'Orbitron',
  );

  static const HeroTheme batman = HeroTheme(
    id: 'batman',
    name: 'Batman',
    emoji: '🦇',
    tagline: 'I\'m the night. I\'m the quiz.',
    category: 'dc',
    primary: Color(0xFFFFD700),
    secondary: Color(0xFF1A1A1A),
    accent: Color(0xFFFFD700),
    background: Color(0xFF0A0A0A),
    cardBg: Color(0xFF1E1E1E),
    textDark: Color(0xFFFFFFFF),
    textLight: Color(0xFF888888),
    gradientColors: [Color(0xFF1A1A1A), Color(0xFF3A3A3A)],
    patternEmoji: '🦇',
    fontFamily: 'Bebas Neue',
  );

  static const HeroTheme superman = HeroTheme(
    id: 'superman',
    name: 'Superman',
    emoji: '🦸',
    tagline: 'Truth, Justice & Perfect Score!',
    category: 'dc',
    primary: Color(0xFF0033CC),
    secondary: Color(0xFFCC0000),
    accent: Color(0xFFFFD700),
    background: Color(0xFFF0F4FF),
    cardBg: Color(0xFFFFFFFF),
    textDark: Color(0xFF001166),
    textLight: Color(0xFF667799),
    gradientColors: [Color(0xFF0033CC), Color(0xFF0055FF)],
    patternEmoji: '⚡',
    fontFamily: 'Russo One',
  );

  static const HeroTheme captainamerica = HeroTheme(
    id: 'captainamerica',
    name: 'Captain America',
    emoji: '🛡️',
    tagline: 'I can do this all day!',
    category: 'marvel',
    primary: Color(0xFF003366),
    secondary: Color(0xFFCC0000),
    accent: Color(0xFFFFFFFF),
    background: Color(0xFFF0F5FF),
    cardBg: Color(0xFFFFFFFF),
    textDark: Color(0xFF001133),
    textLight: Color(0xFF667799),
    gradientColors: [Color(0xFF003366), Color(0xFFCC0000)],
    patternEmoji: '⭐',
    fontFamily: 'Russo One',
  );

  static const HeroTheme hulk = HeroTheme(
    id: 'hulk',
    name: 'Hulk',
    emoji: '💚',
    tagline: 'HULK SMASH wrong answers!',
    category: 'marvel',
    primary: Color(0xFF00AA00),
    secondary: Color(0xFF004400),
    accent: Color(0xFF88FF00),
    background: Color(0xFFF0FFF0),
    cardBg: Color(0xFFFFFFFF),
    textDark: Color(0xFF003300),
    textLight: Color(0xFF669966),
    gradientColors: [Color(0xFF00AA00), Color(0xFF008800)],
    patternEmoji: '💥',
    fontFamily: 'Bangers',
  );

  static const HeroTheme wonderwoman = HeroTheme(
    id: 'wonderwoman',
    name: 'Wonder Woman',
    emoji: '👑',
    tagline: 'Fight for knowledge. Win with wisdom.',
    category: 'dc',
    primary: Color(0xFFCC0000),
    secondary: Color(0xFF002277),
    accent: Color(0xFFFFD700),
    background: Color(0xFFFFF8F0),
    cardBg: Color(0xFFFFFFFF),
    textDark: Color(0xFF220022),
    textLight: Color(0xFF997788),
    gradientColors: [Color(0xFFCC0000), Color(0xFFFFD700)],
    patternEmoji: '⭐',
    fontFamily: 'Cinzel',
  );

  static const HeroTheme thor = HeroTheme(
    id: 'thor',
    name: 'Thor',
    emoji: '⚡',
    tagline: 'Whosoever holds this quiz, if worthy!',
    category: 'marvel',
    primary: Color(0xFF1A3A8A),
    secondary: Color(0xFF4A4A4A),
    accent: Color(0xFFFFCC00),
    background: Color(0xFFF5F8FF),
    cardBg: Color(0xFFFFFFFF),
    textDark: Color(0xFF0A1A4A),
    textLight: Color(0xFF778899),
    gradientColors: [Color(0xFF1A3A8A), Color(0xFF4466CC)],
    patternEmoji: '⚡',
    fontFamily: 'Norse',
  );

  static const HeroTheme classic = HeroTheme(
    id: 'classic',
    name: 'Classic',
    emoji: '🏆',
    tagline: 'The original Quiz Master experience.',
    category: 'classic',
    primary: Color(0xFFFF6B35),
    secondary: Color(0xFF1A1A2E),
    accent: Color(0xFFFFD700),
    background: Color(0xFFFAF8F5),
    cardBg: Color(0xFFFFFFFF),
    textDark: Color(0xFF1A1A2E),
    textLight: Color(0xFF8A8A9A),
    gradientColors: [Color(0xFFFF6B35), Color(0xFFFF9800)],
    patternEmoji: '⭐',
    fontFamily: 'Poppins',
  );

  static const HeroTheme neon = HeroTheme(
    id: 'neon',
    name: 'Neon City',
    emoji: '🌆',
    tagline: 'Cyberpunk your way to victory!',
    category: 'classic',
    primary: Color(0xFF00FFCC),
    secondary: Color(0xFF0A0A1A),
    accent: Color(0xFFFF00FF),
    background: Color(0xFF050510),
    cardBg: Color(0xFF0F0F25),
    textDark: Color(0xFFFFFFFF),
    textLight: Color(0xFF8888AA),
    gradientColors: [Color(0xFF00FFCC), Color(0xFFFF00FF)],
    patternEmoji: '💫',
    fontFamily: 'Orbitron',
  );

  static const List<HeroTheme> all = [
    classic,
    neon,
    spiderman,
    ironman,
    captainamerica,
    hulk,
    thor,
    batman,
    superman,
    wonderwoman,
  ];

  static HeroTheme byId(String id) {
    return all.firstWhere((t) => t.id == id, orElse: () => classic);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ThemeProvider — persists + notifies
// ─────────────────────────────────────────────────────────────────────────────
class ThemeProvider extends ChangeNotifier {
  static const _prefKey = 'selected_theme_id';

  HeroTheme _current = AppThemes.classic;
  HeroTheme get current => _current;

  ThemeProvider();

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString(_prefKey) ?? 'classic';
    _current = AppThemes.byId(id);
    notifyListeners();
  }

  Future<void> selectTheme(HeroTheme theme) async {
    _current = theme;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, theme.id);
  }

  // ── Derived MaterialThemeData ─────────────────────────────────────────────
  ThemeData get materialTheme {
    final t = _current;
    final isDark = t.background.computeLuminance() < 0.3;

    TextTheme baseText;
    try {
      switch (t.fontFamily) {
        case 'Bangers':
          baseText = GoogleFonts.bangersTextTheme();
          break;
        case 'Orbitron':
          baseText = GoogleFonts.orbitronTextTheme();
          break;
        case 'Bebas Neue':
          baseText = GoogleFonts.bebasNeueTextTheme();
          break;
        case 'Russo One':
          baseText = GoogleFonts.russoOneTextTheme();
          break;
        case 'Cinzel':
          baseText = GoogleFonts.cinzelTextTheme();
          break;
        default:
          baseText = GoogleFonts.poppinsTextTheme();
      }
    } catch (_) {
      baseText = GoogleFonts.poppinsTextTheme();
    }

    // Adjust text theme colors for dark backgrounds
    if (isDark) {
      baseText = baseText.apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      );
    }

    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: t.primary,
        brightness: isDark ? Brightness.dark : Brightness.light,
      ),
      textTheme: baseText,
      scaffoldBackgroundColor: t.background,
      cardColor: t.cardBg,
      appBarTheme: AppBarTheme(
        backgroundColor: t.background,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: t.textDark),
        titleTextStyle: TextStyle(
          fontFamily: t.fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: t.textDark,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: t.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        ),
      ),
    );
  }
}
