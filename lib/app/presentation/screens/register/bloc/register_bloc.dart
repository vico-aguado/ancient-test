import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:prueba_ancient/app/domain/entities/user_model.dart';
import 'package:prueba_ancient/app/utils/string.dart';

import '../../../../core/repositories/user_repository.dart';
import '../../../../utils/localization.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(
    this.userRepository,
  ) : super(RegisterInitialState(RegisteModel(
          passController: TextEditingController(),
          emailController: TextEditingController(),
        ))) {
    on<SendRegisterEvent>(_send);
    on<ShowPassRegisterEvent>(_showPass);
  }

  final UserRepository userRepository;

  void _showPass(
    ShowPassRegisterEvent event,
    Emitter<RegisterState> emit,
  ) {
    emit(ShowPassRegisterState(state.model.copyWith(
      showPass: !state.model.showPass,
    )));
  }

  void _send(
    SendRegisterEvent event,
    Emitter<RegisterState> emit,
  ) async {
    // Validate email field
    if (state.model.emailController.text.isEmpty) {
      emit(RegisterErrorRegisterState(state.model,
          LocalText.of(event.context?.l10n?.emailHintField), DateTime.now()));
      return;
    } else {
      final bool isValid = state.model.emailController.text.isEmail();
      if (!isValid) {
        emit(RegisterErrorRegisterState(
            state.model,
            LocalText.of(event.context?.l10n?.emailInvalidField),
            DateTime.now()));
        return;
      }
    }

    // Validate password field
    if (state.model.passController.text.isEmpty) {
      emit(RegisterErrorRegisterState(
          state.model,
          LocalText.of(event.context?.l10n?.passwordHintField),
          DateTime.now()));
      return;
    } else {
      final bool isValid = state.model.passController.text.length >= 5;
      if (!isValid) {
        emit(RegisterErrorRegisterState(
            state.model,
            LocalText.of(event.context?.l10n?.passwordInvalidField),
            DateTime.now()));
        return;
      }
    }

    // Change state to loading
    emit(ChangeLoadingStatusRegisterState(
        state.model, '${LocalText.of(event.context?.l10n?.loading)}...'));

    try {
      // Call repository to register user
      final user = await userRepository.registerUser(
        state.model.emailController.text,
        state.model.passController.text,
      );
      emit(RegisterSuccessRegisterState(
          state.model, UserModel(email: user?.email ?? '')));
    } catch (e) {
      emit(RegisterErrorRegisterState(
          state.model, e.toString(), DateTime.now()));
    }
  }
}
