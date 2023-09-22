part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  final LoginModel model;
  const LoginState(this.model);

  @override
  List<Object> get props => [model];
}

final class LoginInitialState extends LoginState {
  const LoginInitialState(super.model);
}

final class LoadingLoginState extends LoginState {
  const LoadingLoginState(super.model);
}

final class SuccessLoginState extends LoginState {
  const SuccessLoginState(super.model);
}

final class ErrorLoginState extends LoginState {
  const ErrorLoginState(super.model, this.message, this.date);

  final String message;
  final DateTime date;

  @override
  List<Object> get props => super.props..addAll([message, date]);
}

final class ShowPassLoginState extends LoginState {
  const ShowPassLoginState(super.model);
}

class LoginModel extends Equatable {
  final TextEditingController emailController;
  final TextEditingController passController;
  final bool showPass;

  const LoginModel({
    required this.emailController,
    required this.passController,
    this.showPass = false,
  });

  LoginModel copyWith({
    TextEditingController? emailController,
    TextEditingController? passController,
    bool? showPass,
  }) {
    return LoginModel(
      emailController: emailController ?? this.emailController,
      passController: passController ?? this.passController,
      showPass: showPass ?? this.showPass,
    );
  }

  @override
  List<Object> get props => [
        emailController,
        passController,
        showPass,
      ];
}
