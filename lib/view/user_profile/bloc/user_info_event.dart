part of 'user_info_bloc.dart';

@immutable
abstract class UserInfoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInfoInitialEvent extends UserInfoEvent {
  final ViewType viewType;
  final String? memberUserName;

  UserInfoInitialEvent({required this.viewType, this.memberUserName});
}

class UserInfoGetInfoSSOEvent extends UserInfoEvent {
  final String? username;

  UserInfoGetInfoSSOEvent({this.username});
}

class UserInfoUpdateUserAvatarUrlSuccessEvent extends UserInfoEvent {
  final String avatarUrl;

  UserInfoUpdateUserAvatarUrlSuccessEvent({required this.avatarUrl});
}

class UserInfoGetPersonalInfoEvent extends UserInfoEvent {
  final ViewType viewType;
  final bool? isPopLoadingDialog;
  final String? memberUserName;

  UserInfoGetPersonalInfoEvent(
      {required this.viewType, this.memberUserName, this.isPopLoadingDialog});
}

class UserInfoRebuildHighlightInfoEvent extends UserInfoEvent {}

class UserInfoGetContactInfoEvent extends UserInfoEvent {
  final ViewType viewType;
  final String? memberUserName;

  UserInfoGetContactInfoEvent({required this.viewType, this.memberUserName});
}

class UserInfoGetOrganizationInfoEvent extends UserInfoEvent {
  final ViewType viewType;
  final String? organizationBaseId;

  UserInfoGetOrganizationInfoEvent(
      {required this.viewType, this.organizationBaseId});
}

class UserInfoGetAdditionalPathInfoEvent extends UserInfoEvent {
  final ViewType viewType;
  final String? memberUserName;

  UserInfoGetAdditionalPathInfoEvent(
      {required this.viewType, this.memberUserName});
}

class UserInfoConfigurationDisplayEvent extends UserInfoEvent {
  final List<String> listDisplayItem;

  UserInfoConfigurationDisplayEvent({required this.listDisplayItem});
}

class UserInfoConfigurationAdditionalPathEvent extends UserInfoEvent {
  final List<String> listAdditionalPath;

  UserInfoConfigurationAdditionalPathEvent({required this.listAdditionalPath});
}

class UserInfoConfigurationContactEvent extends UserInfoEvent {
  final List<String> listContact;

  UserInfoConfigurationContactEvent({required this.listContact});
}
