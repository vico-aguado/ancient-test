part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class SendRegisterEvent extends RegisterEvent {
  const SendRegisterEvent(this.context);
  final BuildContext? context;
}

class ShowPassRegisterEvent extends RegisterEvent {
  const ShowPassRegisterEvent();
}
