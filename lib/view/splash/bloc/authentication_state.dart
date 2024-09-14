part of 'authentication_bloc.dart';

abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationInitSuccessState extends AuthenticationState {}

class AuthenticationInitErrorState extends AuthenticationState {}
