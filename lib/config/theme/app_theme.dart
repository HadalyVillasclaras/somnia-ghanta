import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get themeData {
    const primaryBlue = Color(0xff132244);

    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: primaryBlue, // Custom primary color
      onPrimary:
          Color(0xFFFFFFFF), // Color for text/iconography on primary color
      secondary: primaryBlue, // Custom secondary color
      onSecondary:
          Color(0xFFFFFFFF), // Color for text/iconography on secondary color
      error: Color(0xFFB00020), // Custom error color
      onError: Color(0xFFFFFFFF), // Color for text/iconography on error color
      background: Color.fromARGB(255, 255, 255, 255), // Custom background color
      onBackground:
          primaryBlue, // Color for text/iconography on background color
      surface: Color(0xFFFFFFFF), // Custom surface color
      onSurface: primaryBlue, // Color for text/iconography on surface color
    );

    // Define text theme
    const textTheme = TextTheme(
      displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.w400),
      displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.w400),
      displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.w400),
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
      headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      // Further customization can be added as needed
    );

    // Define input decoration theme
    final inputDecorationTheme = InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Color.fromARGB(255, 221, 45, 45)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: colorScheme.primaryContainer),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(color: colorScheme.primary),
      ),
    );

    // BOTONES
    final elevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary, 
          foregroundColor: colorScheme.onPrimary, // Text and icon color
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2,
          textStyle: textTheme.titleSmall),
    );

    final filledButtonTheme = FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: colorScheme.primary, 
        foregroundColor: colorScheme.onPrimary, // Text and icon color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: textTheme.titleSmall,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: GoogleFonts.montserratTextTheme(textTheme),
      inputDecorationTheme: inputDecorationTheme,
      elevatedButtonTheme: elevatedButtonTheme,
      filledButtonTheme: filledButtonTheme
      // More component themes can be added as needed
    );
  }
}
