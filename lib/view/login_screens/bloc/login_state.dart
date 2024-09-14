part of 'login_bloc.dart';

abstract class LoginState {
  const LoginState();

  // @override
  // List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginGetUsernameState extends LoginState {
  final String username;

  LoginGetUsernameState({required this.username});
}

class LoginGetLocalInfoState extends LoginState {
  final String username;
  final String password;
  final bool accountRemember;

  LoginGetLocalInfoState(
      {required this.username,
      required this.password,
      required this.accountRemember});
}

class LoginLoadingState extends LoginState {}

class LoginBySSOLoadingState extends LoginState {}

class LoginBySSOSuccessState extends LoginState {}

class LoginBySSOErrorState extends LoginState {
  final String message;

  LoginBySSOErrorState(this.message);
}

class LoginFieldRequiredState extends LoginState {}

class LoginSuccessState extends LoginState {
  // LoginResponse loginResponse;
  LoginSuccessState();
}

class LoginFailedState extends LoginState {
  final String? message;

  LoginFailedState({this.message});
}

class LoginRememberState extends LoginState {
  bool remember;
  LoginRememberState(this.remember);
}

class LoginShowPasswordState extends LoginState {
  bool showPassword;
  LoginShowPasswordState({required this.showPassword});
}

class LoginRequestDeletionSuccessState extends LoginState {}

class LoginRequestDeletionFailedState extends LoginState {}
