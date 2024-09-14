import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/utils/view_utils.dart';

import '../../../data/repository/local/local_data_access.dart';
import '../../../data/repository/remote/repository.dart';
import '../../../di/di.dart';
import '../../../model/api/base_response.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository = getIt.get<UserRepository>();
  final OpenIDRepository openIDRepository = getIt.get<OpenIDRepository>();
  LocalDataAccess localDataAccess = getIt.get<LocalDataAccess>();

  LoginBloc() : super(LoginInitial()) {
    on<LoginInitEvent>(_onInitial);

    on<LoginRequestEvent>(_onLoginRequest);

    on<LoginBySSORequestEvent>(_onLoginBySSORequest);

    on<LoginRememberEvent>(_onLoginRememberEvent);

    on<LoginRefreshEvent>(_onRefresh);

    on<LoginShowPasswordEvent>((event, emit) {
      emit(LoginShowPasswordState(showPassword: event.showPassword));
    });

    on<LoginRequestAccoutDeletionEvent>(_onRequestAccountDeletion);
  }

  FutureOr<void> _onInitial(
      LoginInitEvent event, Emitter<LoginState> emit) async {
    final String username = localDataAccess.getUserName();
    final String password = localDataAccess.getPassword();
    final bool accountRemember = localDataAccess.getAccountRemember();

    emit(LoginGetLocalInfoState(
        username: accountRemember ? username : '',
        password: accountRemember ? password : '',
        accountRemember: accountRemember));
    emit(LoginRememberState(accountRemember));
    emit(LoginShowPasswordState(showPassword: false));
  }

  FutureOr<void> _onLoginRequest(
      LoginRequestEvent event, Emitter<LoginState> emit) async {
    if (event.username == "" || event.password == "") {
      emit(LoginFieldRequiredState());
    } else {
      emit(LoginLoadingState());
      final response = await openIDRepository.loginRequest(
          username: event.username.toString(),
          password: event.password.toString(),
          rememberMe: event.rememberMe);

      if (response.status == ResponseStatus.success && response.data != null) {
        emit(LoginSuccessState());
        localDataAccess.setAccessToken(response.data!.data?.accessToken ?? '');
        localDataAccess
            .setRefreshToken(response.data!.data?.refreshToken ?? '');
        localDataAccess.setUsername(event.username.toString());
        localDataAccess.setPassword(event.password.toString());
        localDataAccess.setAccountRemember(event.rememberMe);
        // localDataAccess.setXLicenseKey(response.data!.keyLicense);

        // await NotificationHelper.instance
        //     .initSignalrConnection(response.data!.data?.accessToken ?? '');
      } else if (response.status == ResponseStatus.error) {
        emit(LoginFailedState(message: response.message));
      }
    }
  }

  FutureOr<void> _onLoginBySSORequest(
      LoginBySSORequestEvent event, Emitter<LoginState> emit) async {
    emit(LoginBySSOLoadingState());
    final response = await openIDRepository.loginBySSORequest();
    if (response.status == ResponseStatus.success) {
      // await NotificationHelper.instance
      //     .initSignalrConnection(response.data?.accessToken ?? '');
      // emit(LoginBySSOSuccessState());
      emit(LoginSuccessState());
    } else {
      emit(LoginBySSOErrorState(response.message ?? ''));
    }
  }

  FutureOr<void> _onLoginRememberEvent(
      LoginRememberEvent event, Emitter<LoginState> emit) {
    localDataAccess.setAccountRemember(event.rememberMe);
    emit(LoginRememberState(event.rememberMe));
  }

  FutureOr<void> _onRefresh(
      LoginRefreshEvent event, Emitter<LoginState> emit) async {
    await openIDRepository.refreshToken();
  }

  FutureOr<void> _onRequestAccountDeletion(
      LoginRequestAccoutDeletionEvent event, Emitter<LoginState> emit) async {
    final response = await openIDRepository.requestDeactive(isDeactive: true);
    if (response.status == ResponseStatus.success) {
      // final response2 = await openIDRepository.endSession();
      // if (response2.status == ResponseStatus.success) {
      String username = localDataAccess.getUserName().toString();
      bool accountRemember = localDataAccess.getAccountRemember();
      localDataAccess.clearData();
      localDataAccess.setUsername(username);
      localDataAccess.setAccountRemember(accountRemember);
      // emit(SettingLogoutSuccessState());
      emit(LoginRequestDeletionSuccessState());
      toastSuccess('Yêu cầu xoá tài khoản thành công');
      // }
    } else {
      emit(LoginRequestDeletionFailedState());
      toastWarning('Yêu cầu xoá tài khoản thất bại');
    }
  }
}
