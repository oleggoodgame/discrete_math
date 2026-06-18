import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,

  scaffoldBackgroundColor: const Color(0xFF0F1115),
  canvasColor: const Color(0xFF161A22),

  colorScheme: const ColorScheme.dark(
    primary: Colors.indigoAccent,
    secondary: Colors.indigo,
    surface: Color(0xFF161A22),
    background: Color(0xFF0F1115),
    onPrimary: Colors.white,
    onSurface: Colors.white70,
  ),

  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.white70,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      color: Colors.white60,
    ),
    bodyLarge: TextStyle(fontSize: 22, color: Colors.white),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.white70),
  ),

  tabBarTheme: TabBarThemeData(
    dividerColor: Colors.white10,
    labelStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: Colors.grey[400],
    ),
    indicatorColor: Colors.indigoAccent,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.indigoAccent,
      foregroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 1,
      ),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.white70,
      side: BorderSide(color: Colors.grey.shade700),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),

  // cardTheme: CardTheme(
  //   color: const Color(0xFF1B1F2A),
  //   elevation: 0,
  //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  // ),

  dividerColor: Colors.white12,
);
