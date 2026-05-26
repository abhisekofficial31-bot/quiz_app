import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/themed_widgets.dart';
import 'home_screen.dart';
import 'categories_screen.dart';
import 'leaderboard_screen.dart';
import 'profile_screen.dart';
import 'tournament_screen.dart';

class MainNav extends StatefulWidget {
  const MainNav({super.key});
  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int _idx = 0;

  final List<Widget> _screens = const [
    HomeScreen(), CategoriesScreen(), TournamentScreen(),
    LeaderboardScreen(), ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: KeyedSubtree(key: ValueKey(_idx), child: _screens[_idx]),
      ),
      bottomNavigationBar: ThBottomNav(
        currentIndex: _idx,
        onTap: (i) => setState(() => _idx = i),
      ),
    );
  }
}
