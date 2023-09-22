import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prueba_ancient/app/config/colors.dart';

void main() {
  group('AppColors', () {
    test('primary should be Color(0xFF4E54F8)', () {
      expect(AppColors.primary, const Color(0xFF4E54F8));
    });

    test('secondary should be Color(0xFF04293C)', () {
      expect(AppColors.secondary, const Color(0xFF04293C));
    });

    test('tertiary should be Color(0xFF7683F8)', () {
      expect(AppColors.tertiary, const Color(0xFF7683F8));
    });

    test('white should be Color(0xFFFFFFFF)', () {
      expect(AppColors.white, const Color(0xFFFFFFFF));
    });

    test('background should be Color(0xFFBFE2F8)', () {
      expect(AppColors.background, const Color(0xFFBFE2F8));
    });

    test('hint should be Color(0x7F04293C)', () {
      expect(AppColors.hint, const Color(0x7F04293C));
    });

    test('error should be Color(0xFFFF0000)', () {
      expect(AppColors.error, const Color(0xFFFF0000));
    });

    test('rating should be Color(0xFFFFAE00)', () {
      expect(AppColors.rating, const Color(0xFFFFAE00));
    });
  });
}
