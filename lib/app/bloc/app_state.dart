part of 'app_bloc.dart';

sealed class AppState extends Equatable {
  final AppModel model;
  const AppState(this.model);

  @override
  List<Object> get props => [model];
}

final class AppInitial extends AppState {
  const AppInitial(super.model);
}

final class ThemeChangedAppState extends AppState {
  const ThemeChangedAppState(super.model);
}

final class UserCheckedAppState extends AppState {
  const UserCheckedAppState(super.model);
}

final class LogoutAppState extends AppState {
  const LogoutAppState(super.model);
}

class AppModel extends Equatable {
  final UserModel? user;
  final bool isLogged;
  final bool isDark;

  const AppModel({
    this.user,
    this.isLogged = false,
    this.isDark = false,
  });

  AppModel copyWith({
    UserModel? user,
    bool? isLogged,
    bool? isDark,
  }) {
    return AppModel(
      user: user ?? this.user,
      isLogged: isLogged ?? this.isLogged,
      isDark: isDark ?? this.isDark,
    );
  }

  @override
  List<Object?> get props => [
        user,
        isLogged,
        isDark,
      ];
}
