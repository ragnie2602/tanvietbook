part of 'new_password_bloc.dart';

abstract class NewPasswordEvent {}

class NewPasswordEventComplete extends NewPasswordEvent {
  String key;
  String username;
  String newPassword;
  NewPasswordEventComplete(
      {required this.key, required this.newPassword, required this.username});
}
