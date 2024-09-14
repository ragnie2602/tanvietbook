import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/local/local_data_access.dart';
import '../../../data/repository/remote/agency_repository.dart';
import '../../../data/repository/remote/repository.dart';
import '../../../di/di.dart';
import '../../../model/api/base_response.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final OpenIDRepository _openIDRepository = getIt.get<OpenIDRepository>();
  final AgencyRepository _agencyRepository = getIt.get();
  final LocalDataAccess _localDataAccess = getIt.get<LocalDataAccess>();

  SettingsBloc() : super(SettingsInit()) {
    on<SettingsInitEvent>(
      _initSettings,
    );
    on<SettingsLogOutEvent>(
      _onLogOutEvent,
    );
    on<SettingsGetUserSettingsEvent>(
      _onGetUserSettings,
    );

    on<SettingsGetCollaboratorInfoEvent>(
      _onGetCollaboratorInfo,
    );
  }

  FutureOr<void> _initSettings(
      SettingsEvent event, Emitter<SettingsState> emit) async {
    // final response = await userRepository.checkCollaborator();
    // if (response != null) {
    //   emit(SettingsStateSuccess(checkCollaboratorResponse: response));
    // } else {
    //   emit(SettingsStateFail());
    // }
  }

  FutureOr<void> _onLogOutEvent(
      SettingsLogOutEvent event, Emitter<SettingsState> emit) async {
    // final response = await _openIDRepository.endSession();
    // if (response.status == ResponseStatus.success) {
    String username = _localDataAccess.getUserName().toString();
    bool accountRemember = _localDataAccess.getAccountRemember();
    _localDataAccess.clearData();
    _localDataAccess.setUsername(username);
    _localDataAccess.setAccountRemember(accountRemember);
    _localDataAccess.setIsRegisterFCMToken(false);
    emit(SettingLogoutSuccessState());
    // }
  }

  FutureOr<void> _onGetUserSettings(
      SettingsGetUserSettingsEvent event, Emitter<SettingsState> emit) async {
    final response = await _openIDRepository.getCurrentMemberSettingInfo();
    if (response.status == ResponseStatus.success) {
      emit(SettingGetUserSettingsSuccessState(response.data!));
    } else {
      emit(SettingGetUserSettingsFailState());
    }
  }

  FutureOr<void> _onGetCollaboratorInfo(SettingsGetCollaboratorInfoEvent event,
      Emitter<SettingsState> emit) async {
    final response = await _agencyRepository.getCollaboratorDetail();
    if (response.status == ResponseStatus.success) {
      emit(SettingGetCollaboratorInfoSuccessState(
          collaboratorInfo: response.data));
    } else {
      emit(SettingGetCollaboratorInfoFailState());
    }
  }
}
