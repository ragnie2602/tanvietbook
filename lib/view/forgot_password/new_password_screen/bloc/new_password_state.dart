part of 'new_password_bloc.dart';

abstract class NewPasswordState {}

class NewPasswordInitial extends NewPasswordState {}

class NewPasswordStateSuccess extends NewPasswordState {}

class NewPasswordStateFail extends NewPasswordState {}
