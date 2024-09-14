import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../../config/config.dart';
import 'change_password_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'change_password_event.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final http.Client httpClient;
  ChangePasswordBloc({required this.httpClient})
      : super(ChangePasswordStateInit(isShow: true)) {
    on<ChangePasswordEventInit>(
      init,
    );
    on<ChangePasswordEventChange>(
      changePassword,
    );
    on<ChangePasswordEventCheckException>(
      checkException,
    );
    on<ChangePasswordEventShow>(
      show,
    );
  }

  FutureOr<void> changePassword(ChangePasswordEventChange event,
      Emitter<ChangePasswordState> emit) async {
    if (state is ChangePasswordStateReadyForChange) {
      var prefs = await SharedPreferences.getInstance();

      var idToken = prefs.getString('idToken');

      var body = jsonEncode({
        "currentPassword": event.currentPassword,
        "newPassword": event.newPassword
      });

      try {
        var response = await httpClient.post(
            Uri.parse('${Environment.domain}/gateway/User/changePassword'),
            body: body,
            headers: {
              "Accept": "application/json",
              "content-type": "application/json",
              "Authorization": 'Bearer $idToken'
            });
        if (response.statusCode == 200) {
          prefs.setString('password', event.newPassword);
          emit(ChangePasswordStateSuccess(isShow: state.isShow));
        } else {
          emit(ChangePasswordStateFail(isShow: state.isShow));
        }
      } catch (e) {
        emit(ChangePasswordStateFail(isShow: state.isShow));
      }
    } else {
      emit(ChangePasswordStateFail(isShow: state.isShow));
    }
  }

  FutureOr<void> init(
      ChangePasswordEventInit event, Emitter<ChangePasswordState> emit) {}

  FutureOr<void> checkException(ChangePasswordEventCheckException event,
      Emitter<ChangePasswordState> emit) async {
    var prefs = await SharedPreferences.getInstance();
    var password = prefs.getString('password');
    if (password == event.currentPassword) {
      emit(ChangePasswordStateCorrectPassword(isShow: state.isShow));
      if (event.newPassword == event.confirmPassword &&
          event.newPassword.isNotEmpty &&
          event.newPassword != event.currentPassword) {
        emit(ChangePasswordStateReadyForChange(isShow: state.isShow));
      } else {
        emit(ChangePasswordStateDuplicatePassword(isShow: state.isShow));
      }
    } else {
      emit(ChangePasswordStateWrongPassword(isShow: state.isShow));
    }
  }

  FutureOr<void> show(
      ChangePasswordEventShow event, Emitter<ChangePasswordState> emit) {
    if (state is ChangePasswordStateReadyForChange) {
      emit(ChangePasswordStateReadyForChange(isShow: event.isShow));
    } else if (state is ChangePasswordStateInit) {
      emit(ChangePasswordStateInit(isShow: event.isShow));
    } else if (state is ChangePasswordStateCorrectPassword) {
      emit(ChangePasswordStateCorrectPassword(isShow: event.isShow));
    } else if (state is ChangePasswordStateWrongPassword) {
      emit(ChangePasswordStateWrongPassword(isShow: event.isShow));
    }
  }
}
