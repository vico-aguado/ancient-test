import 'package:flutter_test/flutter_test.dart';
import 'package:prueba_ancient/app/domain/entities/user_model.dart';

void main() {
  group('UserModel', () {
    test('should create a UserModel instance', () {
      final user = UserModel(email: 'test@example.com');

      expect(user.email, equals('test@example.com'));
    });

    test('should create a copy of UserModel instance', () {
      final user = UserModel(email: 'test@example.com');
      final copy = user.copyWith(email: 'new@example.com');

      expect(copy.email, equals('new@example.com'));
    });

    test('should create a copy of UserModel instance with same email', () {
      final user = UserModel(email: 'test@example.com');
      final copy = user.copyWith();

      expect(copy.email, equals(user.email));
    });
  });
}
