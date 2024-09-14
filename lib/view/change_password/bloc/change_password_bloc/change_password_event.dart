abstract class ChangePasswordEvent {}

class ChangePasswordEventInit extends ChangePasswordEvent {}

class ChangePasswordEventChange extends ChangePasswordEvent {
  String currentPassword;
  String newPassword;
  ChangePasswordEventChange(
      {required this.currentPassword, required this.newPassword});
}

class ChangePasswordEventCheckException extends ChangePasswordEvent {
  String currentPassword;
  String newPassword;
  String confirmPassword;
  ChangePasswordEventCheckException(
      {required this.currentPassword,
      required this.newPassword,
      required this.confirmPassword});
}

class ChangePasswordEventCheckExceptionCurrentPassword
    extends ChangePasswordEvent {
  String currentPassword;
  ChangePasswordEventCheckExceptionCurrentPassword(
      {required this.currentPassword});
}

class ChangePasswordEventCheckExceptionNewPassword extends ChangePasswordEvent {
  String newPassword;
  ChangePasswordEventCheckExceptionNewPassword({required this.newPassword});
}

class ChangePasswordEventCheckExceptionConfirmPassword
    extends ChangePasswordEvent {
  String confirmPassword;
  ChangePasswordEventCheckExceptionConfirmPassword(
      {required this.confirmPassword});
}

class ChangePasswordEventShow extends ChangePasswordEvent {
  bool isShow;
  ChangePasswordEventShow({required this.isShow});
}
