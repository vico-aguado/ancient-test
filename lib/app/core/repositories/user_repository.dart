import '../../data/source/remote/user_source.dart';
import '../../domain/entities/user_model.dart';

abstract class UserRepository {
  Future<UserModel?> registerUser(
    String email,
    String password,
  );
  Future<UserModel?> login(
    String email,
    String password,
  );
  Future<UserModel?> getMe();

  Future<void> logout();
}

class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl({
    required this.userSource,
  });

  final UserSource userSource;

  @override
  Future<UserModel?> getMe() async {
    try {
      final response = await userSource.getMe();

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel?> login(
    String email,
    String password,
  ) async {
    try {
      final response = await userSource.login(
        email,
        password,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel?> registerUser(
    String email,
    String password,
  ) async {
    try {
      final response = await userSource.registerUser(
        email,
        password,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await userSource.logout();
    } catch (e) {
      rethrow;
    }
  }
}
