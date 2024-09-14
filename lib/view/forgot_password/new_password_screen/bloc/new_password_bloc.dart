import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repository/remote/repository.dart';

part 'new_password_event.dart';

part 'new_password_state.dart';

class NewPasswordBloc extends Bloc<NewPasswordEvent, NewPasswordState> {
  final UserRepository userRepository;

  NewPasswordBloc({required this.userRepository})
      : super(NewPasswordInitial()) {
    on<NewPasswordEventComplete>(_complete);
  }

  FutureOr<void> _complete(
      NewPasswordEventComplete event, Emitter<NewPasswordState> emit) async {
    final Response response = await userRepository.forgotPasswordComplete(
        newPassword: event.newPassword,
        username: event.username,
        key: event.key);
    if (response.statusCode == 200) {
      emit(NewPasswordStateSuccess());
    } else {
      emit(NewPasswordStateFail());
    }
  }
}
