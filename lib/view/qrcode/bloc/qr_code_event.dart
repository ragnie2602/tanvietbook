part of 'qr_code_bloc.dart';

@immutable
abstract class QrCodeEvent {}

class QrCodeGetQrEvent extends QrCodeEvent {
  final String username;

  QrCodeGetQrEvent({required this.username});
}
