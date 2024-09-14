part of 'user_info_bloc.dart';

@immutable
abstract class UserInfoState {
  List<Object?> get props => [];
}

class UserInfoInitial extends UserInfoState {}

class UserInfoLoadingState extends UserInfoState {}

class UserInfoSuccessState extends UserInfoState {
  final MemberInfo memberInfo;
  final bool? isShowBtn;
  final bool? isUpdateAll;
  final bool? isPopLoadingDialog;
  final ViewType? viewType;

  UserInfoSuccessState({
    required this.memberInfo,
    this.isShowBtn,
    this.isUpdateAll,
    this.isPopLoadingDialog,
    this.viewType,
  });

  @override
  List<Object?> get props => [memberInfo, isShowBtn];
}

class UserInfoFailedState extends UserInfoState {}

class UserInfoUpdateUserAvatarUrlSuccessState extends UserInfoState {
  final String avatarUrl;

  UserInfoUpdateUserAvatarUrlSuccessState({required this.avatarUrl});
}

class UserInfoGetContactSuccessState extends UserInfoState {
  final List<ContactInfoResponse> contactInfoResponse;

  UserInfoGetContactSuccessState({required this.contactInfoResponse});
}

class UserInfoGetContactFailedState extends UserInfoState {}

class UserInfoGetHighlightSuccessState extends UserInfoState {
  final String? highlightInfo;
  final bool? isHidden;

  UserInfoGetHighlightSuccessState({this.highlightInfo, this.isHidden});
}

class UserInfoGetHighlightFailedState extends UserInfoState {}

class UserInfoGetOrganizationSuccessState extends UserInfoState {
  final ViewType viewType;
  final OrganizationInfoResponse? organizationInfoResponse;

  UserInfoGetOrganizationSuccessState(
      {required this.organizationInfoResponse, required this.viewType});
}

class UserInfoGetOrganizationFailedState extends UserInfoState {
  // final int statusCode;
  final String? message;

  UserInfoGetOrganizationFailedState({this.message});
}

class UserInfoGetAdditionalPathSuccessState extends UserInfoState {
  final List<AdditionalPathInfoResponse> additionalPathInfoResponse;

  UserInfoGetAdditionalPathSuccessState(
      {required this.additionalPathInfoResponse});
}

class UserInfoGetAdditionalPathFailedState extends UserInfoState {}
