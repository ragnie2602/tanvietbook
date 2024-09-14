abstract class ForgotPasswordEvent {}

class ForgotPasswordEventGetMethod extends ForgotPasswordEvent {
  String username;
  ForgotPasswordEventGetMethod({required this.username});
}
