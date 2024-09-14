import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/forgot_password_method.dart';
import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

import '../../../data/repository/remote/repository.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final UserRepository userRepository;

  ForgotPasswordBloc({required this.userRepository})
      : super(ForgotPasswordStateInit()) {
    on<ForgotPasswordEventGetMethod>(
      _getMail,
    );
  }

  FutureOr<void> _getMail(ForgotPasswordEventGetMethod event,
      Emitter<ForgotPasswordState> emit) async {
    final Response response =
        await userRepository.getForgotPasswordMethod(username: event.username);
    if (response.statusCode == 200) {
      var listMethod = forgotPasswordMethodFromJson(response.data);
      if (listMethod.isNotEmpty) {
        emit(ForgotPasswordStateSuccess(forgotPasswordMethod: listMethod));
      } else {
        emit(ForgotPasswordStateFail());
      }
    } else {
      emit(ForgotPasswordStateFail());
    }
  }
}
