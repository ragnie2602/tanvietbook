part of 'otp_bloc.dart';

abstract class OtpState {}

class OtpInitial extends OtpState {}

class OtpStateSendSuccess extends OtpState {}

class OtpStateSendFail extends OtpState {}

class OtpStateSendExpired extends OtpInitial {}

class OtpStateCheckedSuccess extends OtpState {
  String key;
  OtpStateCheckedSuccess({required this.key});
}
