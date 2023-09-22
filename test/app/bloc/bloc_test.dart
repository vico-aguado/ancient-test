import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prueba_ancient/app/bloc/app_bloc.dart';
import 'package:prueba_ancient/app/core/preferences.dart';
import 'package:prueba_ancient/app/core/repositories/user_repository.dart';
import 'package:prueba_ancient/app/domain/entities/user_model.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockPreferences extends Mock implements Preferences {}

void main() {
  late UserRepository userRepository;
  late Preferences preferences;
  late AppBloc appBloc;

  setUp(() {
    userRepository = MockUserRepository();
    preferences = MockPreferences();
    appBloc = AppBloc(userRepository, preferences);
  });

  tearDown(() {
    appBloc.close();
  });

  test('initial state is HomeInitialState', () {
    expect(appBloc.state, const AppInitial(AppModel()));
  });

  test('Model', () {
    const AppModel model = AppModel();
    expect(model, model.copyWith());
  });

  test('test CheckUserAppEvent', () {
    AppEvent event = CheckUserAppEvent();
    expect(
      event,
      equals(
        CheckUserAppEvent(),
      ),
    );
    expect(event.props, equals([]));
  });

  group('AppBloc', () {
    final userModel = UserModel(email: '');
    const appModel = AppModel(isDark: false, isLogged: false);

    test('initial state is correct', () {
      expect(appBloc.state, const AppInitial(appModel));
    });

    blocTest<AppBloc, AppState>(
      'emits UserCheckedAppState when CheckUserAppEvent is added',
      build: () {
        when(() => userRepository.getMe()).thenAnswer((_) async => userModel);
        return appBloc;
      },
      act: (bloc) => bloc.add(CheckUserAppEvent()),
      expect: () => const [],
    );
  });
}
