abstract class SettingsEvent {}

class SettingsInitEvent extends SettingsEvent {}

class SettingsLogOutEvent extends SettingsEvent {}

class SettingsGetUserSettingsEvent extends SettingsEvent {}

class SettingsGetCollaboratorInfoEvent extends SettingsEvent {
  final String? username;

  SettingsGetCollaboratorInfoEvent({this.username});
}
