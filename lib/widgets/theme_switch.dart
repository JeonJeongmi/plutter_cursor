import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/theme_service.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
      builder: (context, themeService, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              themeService.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: Theme.of(context).iconTheme.color,
            ),
            const SizedBox(width: 8),
            Switch(
              value: themeService.isDarkMode,
              onChanged: (value) {
                themeService.toggleTheme();
              },
              activeColor: const Color(0xFF0095F6),
            ),
          ],
        );
      },
    );
  }
}
