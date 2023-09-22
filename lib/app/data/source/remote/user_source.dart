import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/entities/user_model.dart';

class UserSource {
  UserSource(this.firebaseAuth);
  final FirebaseAuth firebaseAuth;

  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel(email: response.user?.email ?? '');
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> registerUser(String email, String password) async {
    try {
      final response = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel(email: response.user?.email ?? '');
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> getMe() async {
    try {
      final response = firebaseAuth.currentUser;
      return response != null ? UserModel(email: response.email ?? '') : null;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
