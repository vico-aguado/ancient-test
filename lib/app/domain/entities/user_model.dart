class UserModel {
  final String email;

  UserModel({required this.email});

  UserModel copyWith({
    String? email,
  }) {
    return UserModel(
      email: email ?? this.email,
    );
  }
}
