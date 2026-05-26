import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ThemedScreen — wraps every screen with full theme background + pattern
// ─────────────────────────────────────────────────────────────────────────────
class ThemedScreen extends StatelessWidget {
  final Widget child;
  final bool useDarkBg;   // true = use secondary (dark) bg like splash/header
  final bool showPattern; // show hero symbol pattern overlay

  const ThemedScreen({
    super.key,
    required this.child,
    this.useDarkBg = false,
    this.showPattern = true,
  });

  @override
  Widget build(BuildContext context) {
    final bg = useDarkBg ? AppTheme.secondary : AppTheme.background;

    return Container(
      color: bg,
      child: Stack(
        children: [
          // Pattern layer — hero emoji tiled
          if (showPattern) _PatternLayer(dark: useDarkBg),
          // Actual content
          child,
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Pattern layer — soft tiled hero emoji / symbols
// ─────────────────────────────────────────────────────────────────────────────
class _PatternLayer extends StatelessWidget {
  final bool dark;
  const _PatternLayer({ required this.dark});

  @override
  Widget build(BuildContext context) {
    final opacity = dark ? 0.07 : 0.045;
    final emoji   = '🎯';

    return Positioned.fill(
      child: IgnorePointer(
        child: Opacity(
          opacity: opacity,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(200, (i) => Text(
              emoji,
              style: const TextStyle(fontSize: 20),
            )),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ThText — theme-aware text (replaces GoogleFonts.poppins everywhere)
// ─────────────────────────────────────────────────────────────────────────────
class ThText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final double? height;
  final double? letterSpacing;
  final TextOverflow? overflow;

  const ThText(
    this.text, {
    super.key,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.maxLines,
    this.height,
    this.letterSpacing,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle style;

    switch ('Poppins') {
      case 'Bangers':
        style = GoogleFonts.bangers(
          fontSize: fontSize, fontWeight: fontWeight,
          color: color ?? AppTheme.textDark, height: height,
          letterSpacing: letterSpacing ?? 1.0,
        );
        break;
      case 'Rajdhani':
        style = GoogleFonts.rajdhani(
          fontSize: fontSize, fontWeight: fontWeight,
          color: color ?? AppTheme.textDark, height: height,
        );
        break;
      case 'Oswald':
        style = GoogleFonts.oswald(
          fontSize: fontSize, fontWeight: fontWeight,
          color: color ?? AppTheme.textDark, height: height,
        );
        break;
      case 'BlackOpsOne':
        style = GoogleFonts.blackOpsOne(
          fontSize: fontSize,
          color: color ?? AppTheme.textDark, height: height,
        );
        break;
      case 'Exo':
        style = GoogleFonts.exo(
          fontSize: fontSize, fontWeight: fontWeight,
          color: color ?? AppTheme.textDark, height: height,
        );
        break;
      case 'Cinzel':
        style = GoogleFonts.cinzel(
          fontSize: fontSize, fontWeight: fontWeight,
          color: color ?? AppTheme.textDark, height: height,
        );
        break;
      case 'Kanit':
        style = GoogleFonts.kanit(
          fontSize: fontSize, fontWeight: fontWeight,
          color: color ?? AppTheme.textDark, height: height,
        );
        break;
      default:
        style = GoogleFonts.poppins(
          fontSize: fontSize, fontWeight: fontWeight,
          color: color ?? AppTheme.textDark, height: height,
          letterSpacing: letterSpacing,
        );
    }

    return Text(
      text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ThCard — theme-aware card with gradient option
// ─────────────────────────────────────────────────────────────────────────────
class ThCard extends StatelessWidget {
  final Widget child;
  final bool useGradient;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Color? overrideColor;

  const ThCard({
    super.key,
    required this.child,
    this.useGradient = false,
    this.padding,
    this.borderRadius,
    this.boxShadow,
    this.overrideColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: useGradient ? null : (overrideColor ?? AppTheme.cardBg),
        gradient: useGradient
            ? LinearGradient(
                colors: [AppTheme.primary, AppTheme.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        boxShadow: boxShadow ??
            [
              BoxShadow(
                color: false
                    ? Colors.black.withOpacity(0.3)
                    : Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
        border: Border.all(
          color: false
              ? Colors.white.withOpacity(0.08)
              : Colors.transparent,
        ),
      ),
      child: child,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ThButton — theme-aware primary button
// ─────────────────────────────────────────────────────────────────────────────
class ThButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isLoading;
  final bool outlined;
  final double? width;
  final double height;
  final Widget? icon;

  const ThButton({
    super.key,
    required this.label,
    this.onTap,
    this.isLoading = false,
    this.outlined = false,
    this.width,
    this.height = 52,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(
          gradient: outlined
              ? null
              : LinearGradient(
                  colors: [AppTheme.primary, AppTheme.primary.withOpacity(0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          color: outlined ? Colors.transparent : null,
          borderRadius: BorderRadius.circular(16),
          border: outlined
              ? Border.all(color: AppTheme.primary, width: 2)
              : null,
          boxShadow: outlined
              ? null
              : [
                  BoxShadow(
                    color: AppTheme.primary.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ],
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  width: 22, height: 22,
                  child: CircularProgressIndicator(
                    color: outlined ? AppTheme.primary : Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[icon!, const SizedBox(width: 8)],
                    ThText(
                      label,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: outlined ? AppTheme.primary : Colors.white,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ThBottomNav — fully themed bottom navigation bar
// ─────────────────────────────────────────────────────────────────────────────
class ThBottomNav extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const ThBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: false ? AppTheme.secondary : Colors.white,
        boxShadow: [
          BoxShadow(
            color: false
                ? Colors.black.withOpacity(0.4)
                : Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
        border: false
            ? Border(top: BorderSide(color: AppTheme.primary.withOpacity(0.3)))
            : null,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(icon: Icons.home_rounded,     label: 'Home',       index: 0, current: currentIndex, onTap: onTap),
              _NavItem(icon: Icons.category_rounded, label: 'Categories', index: 1, current: currentIndex, onTap: onTap),
              _TournamentNavBtn(index: 2, current: currentIndex, onTap: onTap),
              _NavItem(icon: Icons.leaderboard_rounded, label: 'Ranking', index: 3, current: currentIndex, onTap: onTap),
              _NavItem(icon: Icons.person_rounded,   label: 'Profile',    index: 4, current: currentIndex, onTap: onTap),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index, current;
  final void Function(int) onTap;

  const _NavItem({required this.icon, required this.label,
      required this.index, required this.current,
      required this.onTap, });

  @override
  Widget build(BuildContext context) {
    final isActive = index == current;
    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          gradient: isActive
              ? LinearGradient(
                  colors: [AppTheme.primary, AppTheme.primary.withOpacity(0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                color: isActive
                    ? Colors.white
                    : (false ? Colors.white38 : AppTheme.textLight),
                size: 22),
            if (isActive) ...[
              const SizedBox(width: 6),
              Text(label,
                  style: GoogleFonts.poppins(
                    fontSize: 12, fontWeight: FontWeight.w600,
                    color: Colors.white,
                  )),
            ],
          ],
        ),
      ),
    );
  }
}

class _TournamentNavBtn extends StatelessWidget {
  final int index, current;
  final void Function(int) onTap;

  const _TournamentNavBtn({required this.index, required this.current,
      required this.onTap, });

  @override
  Widget build(BuildContext context) {
    final isActive = index == current;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: 50, height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isActive
                    ? [AppTheme.primary, AppTheme.secondary]
                    : [AppTheme.secondary, AppTheme.secondary.withOpacity(0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primary.withOpacity(0.4),
                  blurRadius: 10, offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(child: Text('🎯',
                style: const TextStyle(fontSize: 22))),
          ),
          const SizedBox(height: 2),
          Text('Battle',
              style: GoogleFonts.poppins(
                fontSize: 10, fontWeight: FontWeight.w600,
                color: isActive ? AppTheme.primary
                    : (false ? Colors.white38 : AppTheme.textLight),
              )),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ThHeroHeader — used on splash, profile top, onboarding
// ─────────────────────────────────────────────────────────────────────────────
class ThHeroHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;

  const ThHeroHeader({super.key, required this.title, this.subtitle, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.secondary, AppTheme.primary.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: Stack(
        children: [
          // Background hero emoji large
          Positioned(
            right: -10, top: -10,
            child: Text('🎯',
                style: TextStyle(
                    fontSize: 100,
                    color: Colors.white.withOpacity(0.07))),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: ThText(title,
                        fontSize: 22, fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                  if (trailing != null) trailing!,
                ],
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                ThText(subtitle!,
                    fontSize: 13, color: Colors.white60),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ThBanner — for home screen carousel banners
// ─────────────────────────────────────────────────────────────────────────────
class ThBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final int gradientIndex;
  final VoidCallback? onTap;

  const ThBanner({
    super.key,
    required this.title,
    required this.subtitle,
    required this.gradientIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final gradients = [
      [AppTheme.primary, AppTheme.secondary],
      [AppTheme.extra1, AppTheme.secondary],
      [AppTheme.extra2, AppTheme.primary],
    ];
    final g = gradients[gradientIndex % gradients.length];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: g,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: g[0].withOpacity(0.35),
              blurRadius: 18, offset: const Offset(0, 7),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Decorative circle
            Positioned(right: -20, top: -20,
              child: Container(width: 110, height: 110,
                decoration: BoxDecoration(shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.08)))),
            // Hero emoji bg
            Positioned(right: 16, bottom: 8,
              child: Text('🎯',
                  style: const TextStyle(fontSize: 64))),
            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ThText(title,
                      fontSize: 18, fontWeight: FontWeight.w800,
                      color: Colors.white),
                  const SizedBox(height: 4),
                  ThText(subtitle,
                      fontSize: 12, color: Colors.white70),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                    child: ThText('Play Now',
                        fontSize: 12, fontWeight: FontWeight.w700,
                        color: g[0]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ThStatCard — themed stat chip
// ─────────────────────────────────────────────────────────────────────────────
class ThStatCard extends StatelessWidget {
  final String label, value, emoji;
  final int colorIndex;

  const ThStatCard({
    super.key,
    required this.label,
    required this.value,
    required this.emoji,
    this.colorIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppTheme.categoryColor(colorIndex);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(false ? 0.2 : 0.1),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: color.withOpacity(false ? 0.4 : 0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 4),
            ThText(value,
                fontSize: 16, fontWeight: FontWeight.w800,
                color: AppTheme.textDark),
            ThText(label,
                fontSize: 10, color: AppTheme.textLight),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ThInputField — themed text field
// ─────────────────────────────────────────────────────────────────────────────
class ThInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final bool obscure;
  final TextInputType? keyboardType;
  final Widget? suffix;
  final FocusNode? focusNode;
  final TextInputAction? action;
  final VoidCallback? onNext;
  final VoidCallback? onSubmit;

  const ThInputField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.keyboardType,
    this.suffix,
    this.focusNode,
    this.action,
    this.onNext,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ThText(label,
            fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textDark),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          focusNode: focusNode,
          obscureText: obscure,
          keyboardType: keyboardType,
          textInputAction: action,
          onSubmitted: (_) {
            if (onSubmit != null) onSubmit!();
            else if (onNext != null) onNext!();
          },
          style: GoogleFonts.poppins(
              fontSize: 15,
              color: AppTheme.textDark),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(color: AppTheme.textLight),
            prefixIcon: Icon(icon, color: AppTheme.textLight, size: 20),
            suffixIcon: suffix,
            filled: true,
            fillColor: false
                ? AppTheme.secondary.withOpacity(0.6)
                : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                  color: false
                      ? AppTheme.primary.withOpacity(0.3)
                      : Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                  color: false
                      ? AppTheme.primary.withOpacity(0.2)
                      : Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: AppTheme.primary, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ThDiamondBadge — diamond counter badge
// ─────────────────────────────────────────────────────────────────────────────
class ThDiamondBadge extends StatelessWidget {
  final int count;
  final VoidCallback? onTap;
  final bool hasClaim;

  const ThDiamondBadge({
    super.key,
    required this.count,
    this.onTap,
    this.hasClaim = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: false
              ? AppTheme.primary.withOpacity(0.2)
              : AppTheme.accent.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          border: hasClaim
              ? Border.all(color: AppTheme.primary, width: 1.5)
              : Border.all(
                  color: false
                      ? AppTheme.primary.withOpacity(0.3)
                      : AppTheme.accent.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('💎', style: TextStyle(fontSize: 16)),
            const SizedBox(width: 6),
            ThText('$count',
                fontSize: 15, fontWeight: FontWeight.w800,
                color: AppTheme.primary),
            if (hasClaim) ...[
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: AppTheme.primary, shape: BoxShape.circle),
                child: const Icon(Icons.add,
                    color: Colors.white, size: 10),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ThScaffold — drop-in Scaffold replacement that applies full theme
// ─────────────────────────────────────────────────────────────────────────────
class ThScaffold extends StatelessWidget {
  final Widget body;
  final bool useDarkBg;
  final bool showPattern;
  final Widget? bottomNav;
  final bool resizeToAvoidBottomInset;

  const ThScaffold({
    super.key,
    required this.body,
    this.useDarkBg = false,
    this.showPattern = true,
    this.bottomNav,
    this.resizeToAvoidBottomInset = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: useDarkBg ? AppTheme.secondary : AppTheme.background,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: ThemedScreen(
        useDarkBg: useDarkBg,
        showPattern: showPattern,
        child: body,
      ),
      bottomNavigationBar: bottomNav,
    );
  }
}
