part of 'qr_code_bloc.dart';

@immutable
abstract class QrCodeState {}

class QrCodeInitial extends QrCodeState {}

class QrCodeGetQrCodeSuccessState extends QrCodeState {}
