import 'package:flutter/material.dart';

class AppColors {
  // Colores Pokédex
  static const Color pokedexRed = Color(0xFFDC143C);
  static const Color pokedexDarkRed = Color(0xFFB71C1C);
  static const Color pokedexBlack = Color(0xFF000000);
  static const Color pokedexYellow = Color(0xFFFFD700);
  static const Color pokedexCream = Color(0xFFFFF8DC);
  static const Color pokedexDarkGray = Color(0xFF2C2C2C);
  static const Color pokedexScreen = Color(0xFF87CEEB);

  static Color borderPrimaryButton = pokedexRed;
  static Color borderDisabledButton = const Color(0xFFAAAAAA);

  static const ColorScheme lightTheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFFDC143C),
    onPrimary: Colors.white,
    secondary: Color(0xFFFFD700),
    onSecondary: Colors.black87,
    error: Colors.redAccent,
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Color(0xFF000000),
    surfaceContainerHighest: Color(0xFFE0E0E0),
  );

  static const ColorScheme darkTheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFDC143C),
    onPrimary: Colors.white,
    secondary: Color(0xFFFFD700),
    onSecondary: Colors.black87,
    error: Colors.redAccent,
    onError: Colors.white,
    surface: Color(0xFF1A1A1A),
    onSurface: Colors.white,
    surfaceContainerHighest: Color(0xFF2C2C2C),
  );
}
