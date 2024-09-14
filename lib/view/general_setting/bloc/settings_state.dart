import '../../../model/member/collaborator/collaborator_response.dart';
import '../../../model/member/user_settings_response/user_settings_response.dart';

abstract class SettingsState {}

class SettingsInit extends SettingsState {}

// class SettingsStateSuccess extends SettingsState {
//   CheckCollaboratorResponse checkCollaboratorResponse;
//   SettingsStateSuccess({required this.checkCollaboratorResponse});
// }

class SettingsStateFail extends SettingsState {}

class SettingLogoutSuccessState extends SettingsState {}

class SettingGetUserSettingsSuccessState extends SettingsState {
  final UserSettingsResponse userSettingsResponse;

  SettingGetUserSettingsSuccessState(this.userSettingsResponse);
}

class SettingGetUserSettingsFailState extends SettingsState {}

class SettingGetCollaboratorInfoSuccessState extends SettingsState {
  CollaboratorResponse? collaboratorInfo;

  SettingGetCollaboratorInfoSuccessState({this.collaboratorInfo});
}

class SettingGetCollaboratorInfoFailState extends SettingsState {}
