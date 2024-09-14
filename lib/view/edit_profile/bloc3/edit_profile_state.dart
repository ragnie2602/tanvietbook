part of 'edit_profile_bloc.dart';

abstract class EditProfileState {
  const EditProfileState();
}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoadingState extends EditProfileState {}

class EditProfileUpdatePersonalInfoSuccessState extends EditProfileState {}

class EditProfileUpdatePersonalInfoFailedState extends EditProfileState {}

class EditProfileUpdateHighlightInfoSuccessState extends EditProfileState {}

class EditProfileUpdateHighlightInfoFailedState extends EditProfileState {}

class EditProfileUpdateUserAvatarUrlSuccessState extends EditProfileState {
  final String avatarUrl;

  @override
  List<Object> get props => [avatarUrl];

  const EditProfileUpdateUserAvatarUrlSuccessState({required this.avatarUrl});
}

class EditProfileGetContactTypeSuccessState extends EditProfileState {
  final List<ContactDefaultTypeResponse> contactDefaultTypeResponse;

  const EditProfileGetContactTypeSuccessState(
      {required this.contactDefaultTypeResponse});
}

class EditProfileGetContactTypeFailedState extends EditProfileState {
  const EditProfileGetContactTypeFailedState();
}

class EditProfileGetContactTypeDetailLoadingState extends EditProfileState {}

class EditProfileGetAllBankTypeSuccessState extends EditProfileState {
  final List<ContactDefaultTypeResponse> contactDefaultTypeResponse;
  final bool isBankType;

  const EditProfileGetAllBankTypeSuccessState(
      {this.isBankType = false, required this.contactDefaultTypeResponse});

  @override
  List<Object> get props => [contactDefaultTypeResponse];
}

class EditProfileUpdateContactInfoSuccessState extends EditProfileState {}

class EditProfileUpdateContactInfoFailedState extends EditProfileState {}

class EditProfileUpdateOrganizationInfoSuccessState extends EditProfileState {}

class EditProfileUpdateOrganizationInfoFailedState extends EditProfileState {}

class EditProfileUpdateAdditionalPathInfoSuccessState
    extends EditProfileState {}

class EditProfileUpdateAdditionalPathInfoFailedState extends EditProfileState {}

class EditProfileUpdateBaseInfoSuccessState extends EditProfileState {}

class EditProfileUpdateBaseInfoErrorState extends EditProfileState {}
