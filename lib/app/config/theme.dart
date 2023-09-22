import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTheme {
  final bool isDarkmode;

  AppTheme({required this.isDarkmode});

  ThemeData getTheme() {
    final textColor = isDarkmode ? AppColors.white : AppColors.secondary;
    var baseTheme = ThemeData(
        useMaterial3: true,
        //brightness: isDarkmode ? Brightness.dark : Brightness.light,
        fontFamily: 'Outfit',
        listTileTheme: const ListTileThemeData(
          iconColor: AppColors.primary,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          background: isDarkmode ? AppColors.secondary : AppColors.background,
          brightness: isDarkmode ? Brightness.dark : Brightness.light,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(
              const Size(double.infinity, 45),
            ),
            backgroundColor: MaterialStateProperty.all(AppColors.primary),
            foregroundColor: MaterialStateProperty.all(AppColors.white),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            textStyle: MaterialStateProperty.all(
              const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
          headlineMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
          headlineSmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: textColor,
          ),
          bodyMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
          bodySmall: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w300,
            color: textColor,
          ),
          labelMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: textColor,
          ),
          labelSmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            color: textColor,
          ),
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
          titleMedium: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ));

    return baseTheme.copyWith(
      textTheme: GoogleFonts.poppinsTextTheme(baseTheme.textTheme),
    );
  }
}
