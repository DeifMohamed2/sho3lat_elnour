import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Color palette from reference design
  static const Color primaryBlue = Color(0xFF1976D2);
  static const Color primaryBlueDark = Color(0xFF1565C0);
  static const Color lightBlue = Color(0xFFBBDEFB);
  static const Color backgroundLight = Color(0xFFF7FAFF);
  static const Color textPrimary = Color(0xFF030213);
  static const Color textMuted = Color(0xFF717182);
  static const Color textGray = Color(0xFF9E9E9E);
  static const Color borderGray = Color(0xFFE0E0E0);
  static const Color inputBackground = Color(0xFFF3F3F5);
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray50 = Color(0xFFFAFAFA);
  static const Color gray100 = Color(0xFFF5F5F5);
  static const Color gray200 = Color(0xFFE0E0E0);
  static const Color gray300 = Color(0xFFBDBDBD);
  static const Color gray400 = Color(0xFF9E9E9E);
  static const Color gray500 = Color(0xFF757575);
  static const Color gray600 = Color(0xFF616161);
  static const Color gray700 = Color(0xFF424242);
  static const Color gray800 = Color(0xFF303030);

  // Tajawal font family
  static TextStyle tajawal({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
  }) {
    return GoogleFonts.tajawal(
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color,
      height: height,
    );
  }

  static ThemeData get lightTheme {
    final textTheme = GoogleFonts.tajawalTextTheme();
    
    return ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.tajawal().fontFamily,
      textTheme: textTheme.copyWith(
        displayLarge: textTheme.displayLarge?.copyWith(
          fontFamily: GoogleFonts.tajawal().fontFamily,
          color: textPrimary,
        ),
        displayMedium: textTheme.displayMedium?.copyWith(
          fontFamily: GoogleFonts.tajawal().fontFamily,
          color: textPrimary,
        ),
        displaySmall: textTheme.displaySmall?.copyWith(
          fontFamily: GoogleFonts.tajawal().fontFamily,
          color: textPrimary,
        ),
        headlineLarge: textTheme.headlineLarge?.copyWith(
          fontFamily: GoogleFonts.tajawal().fontFamily,
          color: textPrimary,
        ),
        headlineMedium: textTheme.headlineMedium?.copyWith(
          fontFamily: GoogleFonts.tajawal().fontFamily,
          color: textPrimary,
        ),
        headlineSmall: textTheme.headlineSmall?.copyWith(
          fontFamily: GoogleFonts.tajawal().fontFamily,
          color: textPrimary,
        ),
        titleLarge: textTheme.titleLarge?.copyWith(
          fontFamily: GoogleFonts.tajawal().fontFamily,
          color: textPrimary,
          fontWeight: FontWeight.w500,
        ),
        titleMedium: textTheme.titleMedium?.copyWith(
          fontFamily: GoogleFonts.tajawal().fontFamily,
          color: textPrimary,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: textTheme.titleSmall?.copyWith(
          fontFamily: GoogleFonts.tajawal().fontFamily,
          color: textPrimary,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: textTheme.bodyLarge?.copyWith(
          fontFamily: GoogleFonts.tajawal().fontFamily,
          color: textPrimary,
        ),
        bodyMedium: textTheme.bodyMedium?.copyWith(
          fontFamily: GoogleFonts.tajawal().fontFamily,
          color: textPrimary,
        ),
        bodySmall: textTheme.bodySmall?.copyWith(
          fontFamily: GoogleFonts.tajawal().fontFamily,
          color: textMuted,
        ),
        labelLarge: textTheme.labelLarge?.copyWith(
          fontFamily: GoogleFonts.tajawal().fontFamily,
          color: textPrimary,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: textTheme.labelMedium?.copyWith(
          fontFamily: GoogleFonts.tajawal().fontFamily,
          color: textPrimary,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: textTheme.labelSmall?.copyWith(
          fontFamily: GoogleFonts.tajawal().fontFamily,
          color: textMuted,
        ),
      ),
      colorScheme: ColorScheme.light(
        primary: primaryBlue,
        primaryContainer: primaryBlueDark,
        secondary: lightBlue,
        surface: white,
        error: const Color(0xFFD4183D),
        onPrimary: white,
        onSecondary: textPrimary,
        onSurface: textPrimary,
        onError: white,
      ),
      scaffoldBackgroundColor: backgroundLight,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: primaryBlue,
        foregroundColor: white,
        titleTextStyle: GoogleFonts.tajawal(
          color: white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: borderGray, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: borderGray, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFD4183D), width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFD4183D), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: GoogleFonts.tajawal(
          color: textGray,
          fontSize: 16,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: white,
          disabledBackgroundColor: gray300,
          disabledForegroundColor: white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.tajawal(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryBlue,
          textStyle: GoogleFonts.tajawal(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    final textTheme = GoogleFonts.tajawalTextTheme(ThemeData.dark().textTheme);
    
    return ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.tajawal().fontFamily,
      textTheme: textTheme,
      colorScheme: ColorScheme.dark(
        primary: primaryBlue,
        primaryContainer: primaryBlueDark,
        secondary: lightBlue,
        surface: const Color(0xFF1E1E1E),
        error: const Color(0xFFD4183D),
        onPrimary: white,
        onSecondary: textPrimary,
        onSurface: white,
        onError: white,
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF1E1E1E),
        foregroundColor: white,
        titleTextStyle: GoogleFonts.tajawal(
          color: white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}


