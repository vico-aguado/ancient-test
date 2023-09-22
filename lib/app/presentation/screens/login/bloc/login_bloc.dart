import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../bloc/app_bloc.dart';
import '../../../../core/repositories/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(
    this.userRepository,
    this.userBloc,
  ) : super(LoginInitialState(LoginModel(
          emailController: TextEditingController(),
          passController: TextEditingController(),
        ))) {
    on<LoginEvent>(_send);
    on<ShowPassLoginEvent>(_showPass);
  }

  final UserRepository userRepository;
  final AppBloc userBloc;

  void _send(LoginEvent event, Emitter<LoginState> emit) async {
    if (event is SendLoginEvent) {
      emit(LoadingLoginState(state.model)); // Emit loading state
      try {
        // Attempt to log in with user credentials
        await userRepository.login(
          state.model.emailController.text,
          state.model.passController.text,
        );
        emit(SuccessLoginState(state.model)); // Emit success state
        userBloc.add(CheckUserAppEvent()); // Check if user is logged in
      } catch (e) {
        if (e is FirebaseAuthException) {
          emit(ErrorLoginState(state.model, e.code,
              DateTime.now())); // Emit error state with Firebase error code
          return;
        }

        emit(ErrorLoginState(state.model, e.toString(),
            DateTime.now())); // Emit error state with generic error message
      }
    }
  }

  void _showPass(ShowPassLoginEvent event, Emitter<LoginState> emit) {
    emit(ShowPassLoginState(state.model.copyWith(
        showPass: !state
            .model.showPass))); // Toggle show password flag and emit state
  }
}
