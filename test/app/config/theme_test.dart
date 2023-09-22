import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prueba_ancient/app/config/config.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('AppTheme', () {
    test('should return a light theme when isDarkmode is false', () {
      final theme = AppTheme(isDarkmode: false).getTheme();

      expect(theme.brightness, Brightness.light);
      expect(theme.colorScheme.background, AppColors.background);
      expect(theme.textTheme.headlineLarge!.color, AppColors.secondary);
    });

    test('should return a dark theme when isDarkmode is true', () {
      final theme = AppTheme(isDarkmode: true).getTheme();

      expect(theme.brightness, Brightness.dark);
      expect(theme.colorScheme.background, AppColors.secondary);
      expect(theme.textTheme.headlineLarge!.color, AppColors.white);
    });

    test('should have a filled button theme with correct properties', () {
      final theme = AppTheme(isDarkmode: false).getTheme();
      final buttonTheme = theme.filledButtonTheme;

      expect(
          buttonTheme.style?.backgroundColor?.resolve({}), AppColors.primary);
      expect(buttonTheme.style?.foregroundColor?.resolve({}), AppColors.white);
      expect(buttonTheme.style?.shape?.resolve({}),
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)));
      expect(buttonTheme.style?.textStyle?.resolve({})?.fontSize, 20);
      expect(buttonTheme.style?.textStyle?.resolve({})?.fontWeight,
          FontWeight.w700);
    });

    test('should have a text theme with correct properties', () {
      final theme = AppTheme(isDarkmode: false).getTheme();
      final textTheme = theme.textTheme;

      expect(textTheme.headlineLarge?.fontSize, 35);
      expect(textTheme.headlineLarge?.fontWeight, FontWeight.w600);
      expect(textTheme.headlineLarge?.color, AppColors.secondary);

      expect(textTheme.headlineMedium?.fontSize, 18);
      expect(textTheme.headlineMedium?.fontWeight, FontWeight.w600);
      expect(textTheme.headlineMedium?.color, AppColors.secondary);

      expect(textTheme.headlineSmall?.fontSize, 14);
      expect(textTheme.headlineSmall?.fontWeight, FontWeight.w400);
      expect(textTheme.headlineSmall?.color, AppColors.secondary);

      expect(textTheme.bodyMedium?.fontSize, 18);
      expect(textTheme.bodyMedium?.fontWeight, FontWeight.w600);
      expect(textTheme.bodyMedium?.color, AppColors.secondary);

      expect(textTheme.bodySmall?.fontSize, 10);
      expect(textTheme.bodySmall?.fontWeight, FontWeight.w300);
      expect(textTheme.bodySmall?.color, AppColors.secondary);

      expect(textTheme.labelMedium?.fontSize, 16);
      expect(textTheme.labelMedium?.fontWeight, FontWeight.w400);
      expect(textTheme.labelMedium?.color, AppColors.secondary);

      expect(textTheme.labelSmall?.fontSize, 12);
      expect(textTheme.labelSmall?.fontWeight, FontWeight.w300);
      expect(textTheme.labelSmall?.color, AppColors.secondary);

      expect(textTheme.titleLarge?.fontSize, 24);
      expect(textTheme.titleLarge?.fontWeight, FontWeight.w600);
      expect(textTheme.titleLarge?.color, AppColors.secondary);

      expect(textTheme.titleMedium?.fontSize, 21);
      expect(textTheme.titleMedium?.fontWeight, FontWeight.w600);
      expect(textTheme.titleMedium?.color, AppColors.secondary);
    });
  });
}
