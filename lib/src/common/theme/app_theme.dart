import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_app_evertec/src/common/utilities/app_colors.dart';

/// Tema centralizado estilo Pokédex con pixel art.
class AppTheme {
  AppTheme._();

  static const Color pokedexRed = Color(0xFFDC143C);
  static const Color pokedexDarkRed = Color(0xFFB71C1C);
  static const Color pokedexBlack = Color(0xFF000000);
  static const Color pokedexYellow = Color(0xFFFFD700);
  static const Color pokedexCream = Color(0xFFFFF8DC);
  static const Color pokedexDarkGray = Color(0xFF2C2C2C);
  static const Color pokedexLightGray = Color(0xFFE0E0E0);
  static const Color pokedexScreen = Color(0xFF87CEEB);

  static TextStyle get pixelText => GoogleFonts.pressStart2p(
        fontSize: 10,
        letterSpacing: 0.5,
      );

  static TextStyle get pixelTextSmall => GoogleFonts.pressStart2p(
        fontSize: 8,
        letterSpacing: 0.3,
      );

  static TextStyle get pixelTextLarge => GoogleFonts.pressStart2p(
        fontSize: 12,
        letterSpacing: 0.8,
      );

  static BoxDecoration get pixelBorder => BoxDecoration(
        border: Border.all(
          color: pokedexBlack,
          width: 3,
        ),
        color: Colors.white,
      );

  static BoxDecoration get pixelBorderDark => BoxDecoration(
        border: Border.all(
          color: pokedexBlack,
          width: 3,
        ),
        color: pokedexDarkGray,
      );

  static BoxDecoration get pixelBorderRed => BoxDecoration(
        border: Border.all(
          color: pokedexBlack,
          width: 3,
        ),
        color: pokedexRed,
      );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: false,
      colorScheme: AppColors.lightTheme,
      scaffoldBackgroundColor: pokedexCream,
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: pokedexBlack, width: 3),
          borderRadius: BorderRadius.zero,
        ),
        color: Colors.white,
        margin: const EdgeInsets.all(8),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: pokedexRed,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.pressStart2p(
          fontSize: 10,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: pokedexRed,
        selectedItemColor: pokedexYellow,
        unselectedItemColor: Colors.white70,
        selectedLabelStyle: GoogleFonts.pressStart2p(fontSize: 8),
        unselectedLabelStyle: GoogleFonts.pressStart2p(fontSize: 8),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: pokedexBlack, width: 2),
          borderRadius: BorderRadius.zero,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: pokedexBlack, width: 2),
          borderRadius: BorderRadius.zero,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: pokedexRed, width: 3),
          borderRadius: BorderRadius.zero,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.zero,
        ),
        labelStyle: GoogleFonts.pressStart2p(fontSize: 8),
        hintStyle: GoogleFonts.pressStart2p(fontSize: 8, color: Colors.grey),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: pokedexRed,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: pokedexBlack, width: 2),
            borderRadius: BorderRadius.zero,
          ),
          textStyle: GoogleFonts.pressStart2p(fontSize: 10),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: pokedexRed,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: pokedexBlack, width: 2),
            borderRadius: BorderRadius.zero,
          ),
          textStyle: GoogleFonts.pressStart2p(fontSize: 10),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: pokedexRed,
          textStyle: GoogleFonts.pressStart2p(fontSize: 8),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.white,
        labelStyle: GoogleFonts.pressStart2p(fontSize: 8),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: pokedexBlack, width: 2),
          borderRadius: BorderRadius.zero,
        ),
      ),
      listTileTheme: ListTileThemeData(
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: pokedexBlack, width: 1),
          borderRadius: BorderRadius.zero,
        ),
        textColor: pokedexBlack,
        iconColor: pokedexRed,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return pokedexYellow;
          }
          return Colors.grey;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return pokedexRed;
          }
          return Colors.grey.shade300;
        }),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.pressStart2p(fontSize: 32, color: pokedexBlack),
        displayMedium: GoogleFonts.pressStart2p(fontSize: 24, color: pokedexBlack),
        displaySmall: GoogleFonts.pressStart2p(fontSize: 20, color: pokedexBlack),
        headlineLarge: GoogleFonts.pressStart2p(fontSize: 18, color: pokedexBlack),
        headlineMedium: GoogleFonts.pressStart2p(fontSize: 16, color: pokedexBlack),
        headlineSmall: GoogleFonts.pressStart2p(fontSize: 14, color: pokedexBlack),
        titleLarge: GoogleFonts.pressStart2p(fontSize: 12, color: pokedexBlack),
        titleMedium: GoogleFonts.pressStart2p(fontSize: 10, color: pokedexBlack),
        titleSmall: GoogleFonts.pressStart2p(fontSize: 8, color: pokedexBlack),
        bodyLarge: GoogleFonts.pressStart2p(fontSize: 10, color: pokedexBlack),
        bodyMedium: GoogleFonts.pressStart2p(fontSize: 8, color: pokedexBlack),
        bodySmall: GoogleFonts.pressStart2p(fontSize: 6, color: pokedexBlack),
        labelLarge: GoogleFonts.pressStart2p(fontSize: 10, color: pokedexBlack),
        labelMedium: GoogleFonts.pressStart2p(fontSize: 8, color: pokedexBlack),
        labelSmall: GoogleFonts.pressStart2p(fontSize: 6, color: pokedexBlack),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: false,
      colorScheme: AppColors.darkTheme,
      scaffoldBackgroundColor: pokedexDarkGray,
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white, width: 3),
          borderRadius: BorderRadius.zero,
        ),
        color: const Color(0xFF1A1A1A),
        margin: const EdgeInsets.all(8),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: pokedexDarkRed,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.pressStart2p(
          fontSize: 10,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: pokedexDarkRed,
        selectedItemColor: pokedexYellow,
        unselectedItemColor: Colors.white70,
        selectedLabelStyle: GoogleFonts.pressStart2p(fontSize: 8),
        unselectedLabelStyle: GoogleFonts.pressStart2p(fontSize: 8),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1A1A1A),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2),
          borderRadius: BorderRadius.zero,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white70, width: 2),
          borderRadius: BorderRadius.zero,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: pokedexRed, width: 3),
          borderRadius: BorderRadius.zero,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.zero,
        ),
        labelStyle: GoogleFonts.pressStart2p(fontSize: 8, color: Colors.white),
        hintStyle: GoogleFonts.pressStart2p(fontSize: 8, color: Colors.grey),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: pokedexRed,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.white, width: 2),
            borderRadius: BorderRadius.zero,
          ),
          textStyle: GoogleFonts.pressStart2p(fontSize: 10),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: pokedexRed,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.white, width: 2),
            borderRadius: BorderRadius.zero,
          ),
          textStyle: GoogleFonts.pressStart2p(fontSize: 10),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: pokedexYellow,
          textStyle: GoogleFonts.pressStart2p(fontSize: 8),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFF1A1A1A),
        labelStyle: GoogleFonts.pressStart2p(fontSize: 8, color: Colors.white),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white, width: 2),
          borderRadius: BorderRadius.zero,
        ),
      ),
      listTileTheme: ListTileThemeData(
        tileColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.zero,
        ),
        textColor: Colors.white,
        iconColor: pokedexYellow,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return pokedexYellow;
          }
          return Colors.grey;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return pokedexRed;
          }
          return Colors.grey.shade700;
        }),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.pressStart2p(fontSize: 32, color: Colors.white),
        displayMedium: GoogleFonts.pressStart2p(fontSize: 24, color: Colors.white),
        displaySmall: GoogleFonts.pressStart2p(fontSize: 20, color: Colors.white),
        headlineLarge: GoogleFonts.pressStart2p(fontSize: 18, color: Colors.white),
        headlineMedium: GoogleFonts.pressStart2p(fontSize: 16, color: Colors.white),
        headlineSmall: GoogleFonts.pressStart2p(fontSize: 14, color: Colors.white),
        titleLarge: GoogleFonts.pressStart2p(fontSize: 12, color: Colors.white),
        titleMedium: GoogleFonts.pressStart2p(fontSize: 10, color: Colors.white),
        titleSmall: GoogleFonts.pressStart2p(fontSize: 8, color: Colors.white),
        bodyLarge: GoogleFonts.pressStart2p(fontSize: 10, color: Colors.white),
        bodyMedium: GoogleFonts.pressStart2p(fontSize: 8, color: Colors.white),
        bodySmall: GoogleFonts.pressStart2p(fontSize: 6, color: Colors.white70),
        labelLarge: GoogleFonts.pressStart2p(fontSize: 10, color: Colors.white),
        labelMedium: GoogleFonts.pressStart2p(fontSize: 8, color: Colors.white),
        labelSmall: GoogleFonts.pressStart2p(fontSize: 6, color: Colors.white70),
      ),
    );
  }
}
