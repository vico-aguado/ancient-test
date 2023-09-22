import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prueba_ancient/app/bloc/app_bloc.dart';
import 'package:prueba_ancient/app/core/preferences.dart';
import 'package:prueba_ancient/app/core/repositories/user_repository.dart';
import 'package:prueba_ancient/app/data/source/remote/user_source.dart';
import 'package:prueba_ancient/app/presentation/screens/login/bloc/login_bloc.dart';

class MockFirebase extends Mock implements FirebaseAuth {}

class MockPreferences extends Mock implements Preferences {}

void main() {
  group('LoginBloc', () {
    late LoginBloc loginBloc;
    late UserRepository userRepository;
    late AppBloc appBloc;
    late Preferences preferences;
    late UserSource userSource;
    late FirebaseAuth firebaseAuth;

    setUp(() {
      firebaseAuth = MockFirebase();
      preferences = MockPreferences();
      userSource = UserSource(firebaseAuth);
      userRepository = UserRepositoryImpl(userSource: userSource);
      appBloc = AppBloc(userRepository, preferences);
      loginBloc = LoginBloc(userRepository, appBloc);
    });

    tearDown(() {
      loginBloc.close();
    });

    test('initial state is LoginInitialState', () {
      expect(loginBloc.state, isA<LoginInitialState>());
    });

    test('LoginModel', () {
      LoginModel model = LoginModel(
        emailController: TextEditingController(),
        passController: TextEditingController(),
      );
      expect(model, model.copyWith());
    });

    test('test SendLoginEvent', () {
      LoginEvent event = const SendLoginEvent();
      expect(
        event,
        equals(
          const SendLoginEvent(),
        ),
      );
      expect(event.props, equals([]));
    });

    group('ShowPassLoginEvent', () {
      blocTest<LoginBloc, LoginState>(
        'emits ShowPassLoginState with updated showPass value',
        setUp: () {},
        build: () => loginBloc,
        act: (bloc) {
          bloc.add(const ShowPassLoginEvent());
        },
        expect: () => [
          isA<ShowPassLoginState>(),
        ],
      );
    });
  });
}
