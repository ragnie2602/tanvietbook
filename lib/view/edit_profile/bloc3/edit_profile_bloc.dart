import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/resources/resources.dart';
import '../../../di/di.dart';
import '../../../model/api/base_response.dart';
import '../../../model/member/additional_path_response.dart';
import '../../../model/member/base_info_response.dart';
import '../../../model/member/contact_default_type_response.dart';
import '../../../model/member/contact_member_info.dart';
import '../../../model/member/organization_info_response.dart';

import '../../../data/repository/remote/repository.dart';
import '../../../model/member/member_detail_info.dart';
import '../../../shared/utils/icon_assets.dart';
import '../../../shared/utils/view_utils.dart';

part 'edit_profile_event.dart';

part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final AppRepository appRepository = getIt.get<AppRepository>();

  /// these variables is used to notify the view should be rebuilt the ui or not
  bool hasChangedPersonalInfo = false;
  bool hasChangedContactInfo = false;
  bool hasChangedOrganizationInfo = false;
  bool hasChangedAdditionalPathInfo = false;

  EditProfileBloc() : super(EditProfileInitial()) {
    on<EditProfileInitialEvent>(_onInitial);
    on<EditProfileUpdatePersonalInfoEvent>(_onUpdatePersonalInfo);
    on<EditProfileUpdateHighlightInfoEvent>(_onUpdateHighlightInfo);

    on<EditProfileGetContactTypeEvent>(_onGetContactType);
    on<EditProfileAddContactInfoEvent>(_onAddContactInfo);
    on<EditProfileDeleteContactInfoEvent>(_onDeleteContactInfo);

    on<EditProfileAddAdditionalPathInfoEvent>(_onAddAdditionalPathInfo);
    on<EditProfileDeleteAdditionalPathInfoEvent>(_onDeleteAdditionalPathInfo);

    on<EditProfileUpdateOrganizationInfoEvent>(_onUpdateOrganizationInfo);

    on<EditProfileUpdateBaseInfoEvent>(_onUpdateBaseInfo);
  }

  FutureOr<void> _onInitial(
      EditProfileInitialEvent event, Emitter<EditProfileState> emit) async {}

  FutureOr<void> _onUpdatePersonalInfo(EditProfileUpdatePersonalInfoEvent event,
      Emitter<EditProfileState> emit) async {
    if ((event.memberInfo!.toJson()
          ..removeWhere((key, value) =>
              value == null || (value is! bool && value.isEmpty)))
        .isEmpty) return;
    emit(EditProfileLoadingState());
    final response =
        await appRepository.updateMemberInfo(memberInfo: event.memberInfo);

    if (response.status == ResponseStatus.success) {
      hasChangedPersonalInfo = true;
      // if user change avatar, emit state to update synchronously avatar in somewhere.
      if (event.memberInfo?.avatar != null) {
        emit(EditProfileUpdateUserAvatarUrlSuccessState(
            avatarUrl: event.memberInfo?.avatar ?? ''));
      }
      emit(EditProfileUpdatePersonalInfoSuccessState());
      toastSuccess('Lưu thành công');
    } else {
      emit(EditProfileUpdatePersonalInfoFailedState());
      toastWarning('Lưu thất bại\n\nMã lỗi: ${response.message}');
    }
  }

  FutureOr<void> _onUpdateHighlightInfo(
      EditProfileUpdateHighlightInfoEvent event,
      Emitter<EditProfileState> emit) async {
    final response = await appRepository.updateMemberInfo(
        memberInfo: MemberInfo(
            hightlight: event.highlightInfo, hightlightHidden: event.isHidden));

    if (response.status == ResponseStatus.success) {
      emit(EditProfileUpdateHighlightInfoSuccessState());
      toastSuccess(AlertText.updateSuccess);
    } else {
      emit(EditProfileUpdateHighlightInfoFailedState());
      toastWarning('${AlertText.updateSuccess}\n\nMã lỗi: ${response.message}');
    }
  }

  FutureOr<void> _onUpdateOrganizationInfo(
      EditProfileUpdateOrganizationInfoEvent event,
      Emitter<EditProfileState> emit) async {
    if ((event.organizationInfo.toJson()
          ..removeWhere(
              (key, value) => value == null || value is! bool && value.isEmpty))
        .isEmpty) return;
    emit(EditProfileLoadingState());
    final response = await appRepository.updateMemberOrganization(
      organizationInfo: event.organizationInfo,
    );

    if (response.status == ResponseStatus.success) {
      hasChangedOrganizationInfo = true;
      emit(EditProfileUpdateOrganizationInfoSuccessState());
      toastSuccess('Lưu thành công');
    } else {
      emit(EditProfileUpdateOrganizationInfoFailedState());
      toastWarning('Lưu thất bại\n\nMã lỗi: ${response.message}');
    }
  }

  FutureOr<void> _onGetContactType(EditProfileGetContactTypeEvent event,
      Emitter<EditProfileState> emit) async {
    // final response = await appRepository.getMemberContactDefaultList(
    //     isType: event.isType, type: event.type);
    // emit(EditProfileGetContactTypeDetailLoadingState());
    // if (response.status == ResponseStatus.success) {
    //   // if is get detail type
    //   if (event.isType) {
    //     emit(EditProfileGetContactTypeSuccessState(
    //         contactDefaultTypeResponse: response.data ?? []));
    //   } else {
    //     emit(EditProfileGetAllBankTypeSuccessState(
    //         contactDefaultTypeResponse: response.data ?? []));
    //   }
    // } else {
    //   emit(const EditProfileGetContactTypeFailedState());
    // }

    if (event.type == 'BankAccount') {
      emit(EditProfileGetAllBankTypeSuccessState(
          contactDefaultTypeResponse: _bankItems!, isBankType: true));
    } else {
      emit(EditProfileGetContactTypeSuccessState(
          contactDefaultTypeResponse: _contactItems!));
    }

    if (event.isType) {
      emit(EditProfileGetContactTypeSuccessState(
          contactDefaultTypeResponse: socialOptions
              .map((e) => ContactDefaultTypeResponse(
                    type: (e['value'] as Map)['type'],
                    label: e['label'].toString(),
                    value: e['label'].toString(),
                    iconUrl: (e['value'] as Map)['iconUrl'],
                  ))
              .toList()));
    } else {
      // emit(EditProfileGetAllBankTypeSuccessState(
      //     contactDefaultTypeResponse: response.data ?? []));
    }
  }

  FutureOr<void> _onAddContactInfo(EditProfileAddContactInfoEvent event,
      Emitter<EditProfileState> emit) async {
    emit(EditProfileLoadingState());
    final response = await appRepository.addMemberContactInfo(
        contactInfoResponse: event.contactInfoResponse);

    if (response.status == ResponseStatus.success) {
      hasChangedContactInfo = true;
      emit(EditProfileUpdateContactInfoSuccessState());
      toastSuccess('Cập nhật thông tin liên hệ thành công');
    } else {
      emit(EditProfileUpdateContactInfoFailedState());
      toastWarning(
          'Cập nhật thông tin liên hệ thất bại\n\nMã lỗi: ${response.message}');
    }
  }

  FutureOr<void> _onDeleteContactInfo(EditProfileDeleteContactInfoEvent event,
      Emitter<EditProfileState> emit) async {
    emit(EditProfileLoadingState());
    final response = await appRepository.deleteMemberContactInfo(
      contactId: event.contactId,
      contactBaseId: event.contactBaseId,
    );
    if (response.status == ResponseStatus.success) {
      hasChangedContactInfo = true;
      emit(EditProfileUpdateContactInfoSuccessState());
      toastSuccess('Cập nhật thông tin liên hệ thành công');
    } else {
      toastWarning(
          'Cập nhật thông tin liên hệ thất bại\n\nMã lỗi: ${response.message}');
    }
  }

  FutureOr<void> _onAddAdditionalPathInfo(
      EditProfileAddAdditionalPathInfoEvent event,
      Emitter<EditProfileState> emit) async {
    if ((event.additionalPathInfoResponse.toJson()
          ..removeWhere(
              (key, value) => value == null || value is! bool && value.isEmpty))
        .isEmpty) return;

    emit(EditProfileLoadingState());
    final response = await appRepository.addMemberAdditionalPathInfoViewOwn(
        additionalPathInfoResponse: event.additionalPathInfoResponse);

    if (response.status == ResponseStatus.success) {
      hasChangedAdditionalPathInfo = true;
      emit(EditProfileUpdateAdditionalPathInfoSuccessState());
      toastSuccess('Cập nhật đường dẫn thành công');
    } else {
      toastWarning(
          'Cập nhật thông tin đường dẫn thất bại\n\nMã lỗi: ${response.message}');
    }
  }

  FutureOr<void> _onDeleteAdditionalPathInfo(
      EditProfileDeleteAdditionalPathInfoEvent event,
      Emitter<EditProfileState> emit) async {
    emit(EditProfileLoadingState());
    final response = await appRepository.deleteMemberAdditionalPathInfoViewOwn(
      pathId: event.additionalPathId,
      basePathId: event.additionalPathBaseId,
    );
    if (response.status == ResponseStatus.success) {
      hasChangedAdditionalPathInfo = true;
      emit(EditProfileUpdateAdditionalPathInfoSuccessState());
      toastSuccess('Xoá thông tin đường dẫn thành công');
    } else {
      emit(EditProfileUpdateAdditionalPathInfoFailedState());
      toastWarning(
          'Xoá thông tin đường dẫn thất bại\n\nMã lỗi: ${response.message}');
    }
  }

  FutureOr<void> _onUpdateBaseInfo(EditProfileUpdateBaseInfoEvent event,
      Emitter<EditProfileState> emit) async {
    final response = await appRepository.updateMemberBaseInfo(
      baseInfo: event.baseInfo,
    );
    if (response.status == ResponseStatus.success) {
      toastSuccess('Cập nhật thành công');
    } else {
      toastWarning('Cập nhật thất bại\n\nMã lỗi: ${response.message}');
    }
  }

  List<ContactDefaultTypeResponse>? _bankItems;
  List<ContactDefaultTypeResponse> get bankItems {
    _bankItems ??= bankOptions
        .map((e) => ContactDefaultTypeResponse(
              type: (e['value'] as Map)['type'],
              label: e['label'].toString(),
              value: e['label'].toString(),
              iconUrl: (e['value'] as Map)['iconUrl'],
            ))
        .toList();
    return _bankItems!;
  }

  List<ContactDefaultTypeResponse>? _contactItems;
  List<ContactDefaultTypeResponse> get contactItems {
    _contactItems ??= socialOptions
        .map((e) => ContactDefaultTypeResponse(
              type: (e['value'] as Map)['type'],
              label: e['label'].toString(),
              value: e['label'].toString(),
              iconUrl: (e['value'] as Map)['iconUrl'],
            ))
        .toList();
    return _contactItems!;
  }
}
