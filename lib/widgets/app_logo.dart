import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.iconSize = 48,
    this.lightOnDark = false,
  });

  final double iconSize;
  final bool lightOnDark;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final titleColor = lightOnDark ? Colors.white : colors.onSurface;
    final subtitleColor = lightOnDark ? Colors.white70 : colors.onSurfaceVariant;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          'assets/icons/film_reel.svg',
          width: iconSize,
          height: iconSize,
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'ReelQuiz',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: titleColor,
                fontWeight: FontWeight.bold,
                height: 1.1,
              ),
            ),
            Text(
              'Trivia App',
              style: theme.textTheme.labelMedium?.copyWith(
                color: subtitleColor,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
