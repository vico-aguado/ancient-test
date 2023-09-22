import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../core/preferences.dart';
import '../core/repositories/user_repository.dart';
import '../domain/entities/user_model.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final UserRepository repository;
  final Preferences preferences;

  AppBloc(this.repository, this.preferences)
      : super(AppInitial(AppModel(isDark: preferences.getTheme() ?? false))) {
    on<CheckUserAppEvent>(_checkUser);
    on<LogoutAppEvent>(_logout);
    on<ChangeThemeAppEvent>(_changeTheme);
  }

  // Private method that checks if a user is logged in and emits a UserCheckedAppState
  void _checkUser(CheckUserAppEvent event, Emitter<AppState> emit) async {
    final user = await repository.getMe();
    await Future.delayed(const Duration(seconds: 2));
    emit(UserCheckedAppState(AppModel(isLogged: user != null, user: user)));
  }

  // Private method that logs out the user and emits a LogoutAppState
  void _logout(LogoutAppEvent event, Emitter<AppState> emit) async {
    await repository.logout();
    await preferences.clear();
    emit(const LogoutAppState(AppModel(isDark: false)));
  }

  // Private method that changes the app theme and emits a ThemeChangedAppState
  void _changeTheme(ChangeThemeAppEvent event, Emitter<AppState> emit) async {
    await preferences.saveTheme(event.isDark);
    emit(ThemeChangedAppState(state.model.copyWith(isDark: event.isDark)));
  }
}
