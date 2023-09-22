import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prueba_ancient/app/core/preferences.dart';
import 'package:prueba_ancient/app/core/repositories/user_repository.dart';
import 'package:prueba_ancient/app/data/source/remote/user_source.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prueba_ancient/app/presentation/screens/register/bloc/register_bloc.dart';

class MockFirebase extends Mock implements FirebaseAuth {}

class MockPreferences extends Mock implements Preferences {}

void main() {
  group('RegisterBloc', () {
    late UserRepository userRepository;
    late UserSource userSource;
    late FirebaseAuth firebaseAuth;
    late RegisterBloc registerBloc;

    setUp(() {
      firebaseAuth = MockFirebase();
      userSource = UserSource(firebaseAuth);
      userRepository = UserRepositoryImpl(userSource: userSource);
      registerBloc = RegisterBloc(userRepository);
    });

    tearDown(() {
      registerBloc.close();
    });

    test('initial state is RegisterInitialState', () {
      expect(
          registerBloc.state, RegisterInitialState(registerBloc.state.model));
    });

    test('LoginModel', () {
      RegisteModel model = RegisteModel(
        emailController: TextEditingController(),
        passController: TextEditingController(),
      );
      expect(model, model.copyWith());
    });

    test('test ShowPassRegisterEvent', () {
      RegisterEvent event = const ShowPassRegisterEvent();
      expect(
        event,
        equals(
          const ShowPassRegisterEvent(),
        ),
      );
      expect(event.props, equals([]));
    });

    blocTest<RegisterBloc, RegisterState>(
      'emits ShowPassRegisterState when ShowPassRegisterEvent is added',
      build: () => registerBloc,
      act: (bloc) => bloc.add(const ShowPassRegisterEvent()),
      expect: () => [
        isA<ShowPassRegisterState>(),
      ],
    );

    blocTest<RegisterBloc, RegisterState>(
      'emits RegisterErrorRegisterState when email is empty',
      build: () => registerBloc,
      act: (bloc) => bloc.add(const SendRegisterEvent(null)),
      expect: () => [
        isA<RegisterErrorRegisterState>(),
      ],
    );
  });
}
