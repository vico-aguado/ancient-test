part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {
  final RegisteModel model;
  const RegisterState(this.model);

  @override
  List<Object> get props => [model];
}

final class RegisterInitialState extends RegisterState {
  const RegisterInitialState(super.model);
}

final class ShowPassRegisterState extends RegisterState {
  const ShowPassRegisterState(super.model);
}

final class RegisterErrorRegisterState extends RegisterState {
  const RegisterErrorRegisterState(super.model, this.message, this.date);

  final String message;
  final DateTime date;

  @override
  List<Object> get props => super.props..addAll([message, date]);
}

final class ChangeLoadingStatusRegisterState extends RegisterState {
  const ChangeLoadingStatusRegisterState(super.model, this.message);
  final String message;

  @override
  List<Object> get props => super.props..add(message);
}

final class RegisterSuccessRegisterState extends RegisterState {
  const RegisterSuccessRegisterState(super.model, this.user);

  final UserModel? user;
}

class RegisteModel extends Equatable {
  final TextEditingController passController;
  final TextEditingController emailController;
  final bool showPass;

  const RegisteModel({
    required this.passController,
    required this.emailController,
    this.showPass = false,
  });

  RegisteModel copyWith({
    TextEditingController? passController,
    TextEditingController? emailController,
    bool? showPass,
  }) {
    return RegisteModel(
      passController: passController ?? this.passController,
      emailController: emailController ?? this.emailController,
      showPass: showPass ?? this.showPass,
    );
  }

  @override
  List<Object?> get props => [
        passController,
        emailController,
        showPass,
      ];
}
