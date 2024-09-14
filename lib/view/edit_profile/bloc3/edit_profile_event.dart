part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object?> get props => [];
}

class EditProfileInitialEvent extends EditProfileEvent {}

class EditProfileShowLoadingEvent extends EditProfileEvent {}

class EditProfileHideLoadingEvent extends EditProfileEvent {}

class EditProfileGetContactTypeEvent extends EditProfileEvent {
  final bool isType;
  final String? type;

  const EditProfileGetContactTypeEvent({required this.isType, this.type});
}

class EditProfileAddContactInfoEvent extends EditProfileEvent {
  final ContactInfoResponse contactInfoResponse;

  const EditProfileAddContactInfoEvent({required this.contactInfoResponse});
}

class EditProfileAddAdditionalPathInfoEvent extends EditProfileEvent {
  final AdditionalPathInfoResponse additionalPathInfoResponse;

  const EditProfileAddAdditionalPathInfoEvent(
      {required this.additionalPathInfoResponse});
}

class EditProfileDeleteAdditionalPathInfoEvent extends EditProfileEvent {
  final String additionalPathId;
  final String additionalPathBaseId;

  const EditProfileDeleteAdditionalPathInfoEvent(
      {required this.additionalPathId, required this.additionalPathBaseId});
}

class EditProfileUpdateAdditionalPathInfoEvent extends EditProfileEvent {
  final AdditionalPathInfoResponse additionalPathInfoResponse;

  const EditProfileUpdateAdditionalPathInfoEvent(
      {required this.additionalPathInfoResponse});
}

class EditProfileDeleteContactInfoEvent extends EditProfileEvent {
  final String contactId;
  final String contactBaseId;

  const EditProfileDeleteContactInfoEvent(
      {required this.contactId, required this.contactBaseId});
}

class EditProfileUpdatePersonalInfoEvent extends EditProfileEvent {
  final MemberInfo? memberInfo;

  const EditProfileUpdatePersonalInfoEvent({this.memberInfo});

  @override
  List<Object?> get props => [memberInfo];
}

class EditProfileUpdateHighlightInfoEvent extends EditProfileEvent {
  final String? highlightInfo;
  final bool? isHidden;

  const EditProfileUpdateHighlightInfoEvent(
      {this.highlightInfo, this.isHidden});

  @override
  List<Object?> get props => [highlightInfo, isHidden];
}

class EditProfileUpdateOrganizationInfoEvent extends EditProfileEvent {
  final OrganizationInfoResponse organizationInfo;

  const EditProfileUpdateOrganizationInfoEvent(
      {required this.organizationInfo});

  @override
  List<Object?> get props => [organizationInfo];
}

class EditProfileUpdateBaseInfoEvent extends EditProfileEvent {
  final BaseInfoResponse baseInfo;

  const EditProfileUpdateBaseInfoEvent({required this.baseInfo});
}
