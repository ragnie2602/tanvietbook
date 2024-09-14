part of 'otp_bloc.dart';

abstract class OtpEvent {}

class OtpEventInit extends OtpEvent {}

class OtpEventSend extends OtpEvent {
  String username;
  String value;
  OtpEventSend({required this.value, required this.username});
}

class OtpEventCheck extends OtpEvent {
  String username;
  String key;
  OtpEventCheck({required this.username, required this.key});
}

class OtpEventExpired extends OtpEvent {}
