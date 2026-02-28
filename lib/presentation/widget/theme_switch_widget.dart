import 'package:discrete_math/core/theme/cubit/theme_cubit.dart';
import 'package:discrete_math/core/theme/state/state_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeSwitchWidget extends StatelessWidget {
  const ThemeSwitchWidget({
    required this.title,
    required this.subtitle,
    super.key,
  });
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext contextW) {
    return BlocBuilder<ThemeCubit, AppThemeMode>(
      builder: (context, state) {
        // final isDark = state == AppThemeMode.dark;

        final theme = Theme.of(contextW);
        final isDark = theme.brightness == Brightness.dark;
        return Card(
          elevation: 0,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Switch.adaptive(
                  value: isDark,
                  activeColor: Colors.blue,
                  inactiveThumbColor: Colors.grey.shade300,
                  inactiveTrackColor: Colors.grey.shade400,
                  onChanged: (_) {
                    if (isDark) {
                      context.read<ThemeCubit>().setTheme(AppThemeMode.light);
                      return;
                    }
                    context.read<ThemeCubit>().setTheme(AppThemeMode.dark);
                  },
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: theme.textTheme.titleMedium),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
