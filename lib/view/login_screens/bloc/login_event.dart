part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginInitEvent extends LoginEvent {}

class LoginRefreshEvent extends LoginEvent {}

class LoginRememberEvent extends LoginEvent {
  final bool rememberMe;

  const LoginRememberEvent(this.rememberMe);
}

class LoginShowPasswordEvent extends LoginEvent {
  final bool showPassword;

  const LoginShowPasswordEvent({required this.showPassword});
}

class LoginRequestEvent extends LoginEvent {
  final String? username;
  final String? password;

  final bool rememberMe;

  const LoginRequestEvent(
      {this.username = '', this.password = '', this.rememberMe = false});
}

class LoginBySSORequestEvent extends LoginEvent {}

class LoginRequestAccoutDeletionEvent extends LoginEvent {}
