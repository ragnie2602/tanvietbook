abstract class ChangePasswordState {
  bool isShow;
  ChangePasswordState({required this.isShow});
}

class ChangePasswordStateInit extends ChangePasswordState {
  ChangePasswordStateInit({required super.isShow});
}

class ChangePasswordStateReadyForChange extends ChangePasswordState {
  ChangePasswordStateReadyForChange({required super.isShow});
}

class ChangePasswordStateSuccess extends ChangePasswordState {
  ChangePasswordStateSuccess({required super.isShow});
}

class ChangePasswordStateFail extends ChangePasswordState {
  ChangePasswordStateFail({required super.isShow});
}

class ChangePasswordStateWrongPassword extends ChangePasswordState {
  ChangePasswordStateWrongPassword({required super.isShow});
}

class ChangePasswordStateWrongNewPassword extends ChangePasswordState {
  ChangePasswordStateWrongNewPassword({required super.isShow});
}

class ChangePasswordStateWrongConfirmPassword extends ChangePasswordState {
  ChangePasswordStateWrongConfirmPassword({required super.isShow});
}

class ChangePasswordStateCorrectPassword extends ChangePasswordState {
  ChangePasswordStateCorrectPassword({required super.isShow});
}

class ChangePasswordStateDuplicatePassword
    extends ChangePasswordStateCorrectPassword {
  ChangePasswordStateDuplicatePassword({required super.isShow});
}

class ChangePasswordStateCorrectNewPassword extends ChangePasswordState {
  ChangePasswordStateCorrectNewPassword({required super.isShow});
}

class ChangePasswordStateCorrectConfirmPassword extends ChangePasswordState {
  ChangePasswordStateCorrectConfirmPassword({required super.isShow});
}
