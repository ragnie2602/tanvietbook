import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/repository/remote/app_repository.dart';
import '../../../model/api/base_response.dart';

part 'qr_code_event.dart';
part 'qr_code_state.dart';

class QrCodeBloc extends Bloc<QrCodeEvent, QrCodeState> {
  final AppRepository appRepository;

  QrCodeBloc({required this.appRepository}) : super(QrCodeInitial()) {
    on<QrCodeGetQrEvent>(_onGetQrCode);
  }

  FutureOr<void> _onGetQrCode(
      QrCodeGetQrEvent event, Emitter<QrCodeState> emit) async {
    final response = await appRepository.getQrCode(username: event.username);
    if (response.status == ResponseStatus.success) {}
  }
}
