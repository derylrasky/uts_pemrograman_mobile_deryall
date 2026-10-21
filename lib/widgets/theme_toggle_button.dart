import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;

    return IconButton(
      tooltip: isDark ? 'Aktifkan mode terang' : 'Aktifkan mode gelap',
      onPressed: () {
        context.read<ThemeProvider>().toggleTheme();
      },
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.surface,
        minimumSize: const Size(48, 48),
      ),
      icon: Icon(isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
    );
  }
}
