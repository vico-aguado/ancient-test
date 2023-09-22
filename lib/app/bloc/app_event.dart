part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class CheckUserAppEvent extends AppEvent {}

class LogoutAppEvent extends AppEvent {}

class ChangeThemeAppEvent extends AppEvent {
  const ChangeThemeAppEvent(this.isDark);

  final bool isDark;
}
