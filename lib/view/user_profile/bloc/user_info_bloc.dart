import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/constants.dart';
import '../../../data/repository/local/local_data_access.dart';
import '../../../data/repository/remote/app_repository.dart';
import '../../../data/repository/remote/open_id_repository.dart';
import '../../../di/di.dart';
import '../../../model/api/base_response.dart';
import '../../../model/member/additional_path_response.dart';
import '../../../model/member/contact_member_info.dart';
import '../../../model/member/member_detail_info.dart';
import '../../../model/member/organization_info_response.dart';
import '../../../shared/utils/view_utils.dart';

part 'user_info_event.dart';
part 'user_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  final AppRepository appRepository = getIt.get<AppRepository>();
  final OpenIDRepository openIDRepository = getIt.get<OpenIDRepository>();

  MemberInfo? memberInfo;
  ResponseWrapper<List<ContactInfoResponse>>? contactResponse;

  UserInfoBloc() : super(UserInfoInitial()) {
    on<UserInfoUpdateUserAvatarUrlSuccessEvent>(_onUpdateUserAvatarUrlEvent);

    on<UserInfoGetPersonalInfoEvent>(_onGetPersonalInfo);

    on<UserInfoRebuildHighlightInfoEvent>(_onRebuildHighlight);

    on<UserInfoGetOrganizationInfoEvent>(_onGetOrganizationInfo);

    on<UserInfoGetContactInfoEvent>(_onGetContactInfo);

    on<UserInfoGetAdditionalPathInfoEvent>(_onGetAdditionalPathInfo);

    on<UserInfoGetInfoSSOEvent>(_onGetInfoSSO);

    on<UserInfoConfigurationDisplayEvent>(_onConfigurationDisplay);

    on<UserInfoConfigurationAdditionalPathEvent>(
        _onConfigurationAdditionalPath);

    on<UserInfoConfigurationContactEvent>(_onConfigurationContact);
  }

  FutureOr<void> _onGetInfoSSO(
      UserInfoGetInfoSSOEvent event, Emitter<UserInfoState> emit) async {
    final response = await openIDRepository.getUserInfo();
    if (response.status == ResponseStatus.success) {}
  }

  FutureOr<void> _onGetOrganizationInfo(UserInfoGetOrganizationInfoEvent event,
      Emitter<UserInfoState> emit) async {
    if (memberInfo == null) return;
    String? organizationBaseId = '';
    organizationBaseId = memberInfo?.baseInfor
        ?.where((element) => element.type == BaseInfoType.organization)
        .toList()
        .first
        .id;
    // get organization info
    late ResponseWrapper<OrganizationInfoResponse> organizationInfoResponse;
    if (event.viewType == ViewType.viewMember) {
      organizationInfoResponse = await appRepository.getMemberOrganizationInfo(
          organizationBaseId: organizationBaseId ?? '');
    } else {
      organizationInfoResponse =
          await appRepository.getMemberOrganizationInfoViewOwn(
              organizationBaseId: organizationBaseId ?? '');
    }

    if (organizationInfoResponse.status == ResponseStatus.success) {
      if (organizationInfoResponse.data != null) {
        emit(UserInfoGetOrganizationSuccessState(
            viewType: event.viewType,
            organizationInfoResponse: organizationInfoResponse.data!));
      }
    } else {
      if (organizationInfoResponse.statusCode == 204) {
        emit(UserInfoGetOrganizationSuccessState(
            viewType: event.viewType,
            organizationInfoResponse: organizationInfoResponse.data));
      } else {
        emit(UserInfoGetOrganizationFailedState());
      }
    }
  }

  FutureOr<void> _onGetPersonalInfo(
      UserInfoGetPersonalInfoEvent event, Emitter<UserInfoState> emit) async {
    // if view another user
    if (event.viewType == ViewType.viewMember) {
      final response = await appRepository.getMemberInfoByUsername(
        username: event.memberUserName!,
      );
      if (response.status == ResponseStatus.success) {
        memberInfo = response.data;
        emit(UserInfoSuccessState(
            memberInfo: memberInfo!, isShowBtn: false, isUpdateAll: true));
        emit(UserInfoGetHighlightSuccessState(
          highlightInfo: memberInfo?.hightlight,
        ));
      } else {
        emit(UserInfoFailedState());
      }
      // else view current user
    } else {
      final response = await appRepository.getMemberOwnInfo();
      if (response.status == ResponseStatus.success) {
        memberInfo = response.data;
        getIt.get<LocalDataAccess>()
          ..setUsername(memberInfo?.login ?? '')
          ..setUserId(memberInfo?.id ?? '');
        emit(UserInfoSuccessState(
          memberInfo: memberInfo!,
          isShowBtn: false,
          isUpdateAll: true,
          isPopLoadingDialog: event.isPopLoadingDialog,
          viewType: event.viewType,
        ));

        emit(UserInfoGetHighlightSuccessState(
          highlightInfo: memberInfo?.hightlight,
        ));

        // delay for avoiding the state UserInfoGetHighlightSuccessState losing
        await Future.delayed(const Duration(milliseconds: 100));
        // to update bottom nav avatar when update avatar
        if (memberInfo?.avatar != null) {
          emit(UserInfoUpdateUserAvatarUrlSuccessState(
              avatarUrl: memberInfo?.avatar ?? ''));
        }
      } else {
        emit(UserInfoFailedState());
      }
    }
  }

  FutureOr<void> _onGetAdditionalPathInfo(
      UserInfoGetAdditionalPathInfoEvent event,
      Emitter<UserInfoState> emit) async {
    if (memberInfo == null) return;
    // get additional path
    String? pathBaseId = '';
    try {
      pathBaseId = memberInfo?.baseInfor
          ?.where((element) => element.type == BaseInfoType.additionalPath)
          .toList()
          .first
          .id;
      // ignore: empty_catches
    } catch (e) {}
    if (event.viewType == ViewType.viewMember) {
      final additionalPathInfoResponse = await appRepository
          .getMemberAdditionalPathInfo(additionalPathBaseId: pathBaseId!);
      if (additionalPathInfoResponse.status == ResponseStatus.success) {
        if (additionalPathInfoResponse.data != null) {
          emit(UserInfoGetAdditionalPathSuccessState(
              additionalPathInfoResponse: additionalPathInfoResponse.data!));
        } else {
          emit(UserInfoGetAdditionalPathFailedState());
        }
      }
    } else {
      final additionalPathInfoResponse =
          await appRepository.getMemberAdditionalPathInfoViewOwn(
              additionalPathBaseId: pathBaseId!);
      if (additionalPathInfoResponse.status == ResponseStatus.success) {
        if (additionalPathInfoResponse.data != null) {
          emit(UserInfoGetAdditionalPathSuccessState(
              additionalPathInfoResponse: additionalPathInfoResponse.data!));
        } else {
          emit(UserInfoGetAdditionalPathFailedState());
        }
      }
    }
  }

  FutureOr<void> _onGetContactInfo(
      UserInfoGetContactInfoEvent event, Emitter<UserInfoState> emit) async {
    if (memberInfo == null) return;
    // get contact info
    late String contactBaseId;
    contactBaseId = memberInfo?.baseInfor
            ?.where((element) => element.type == BaseInfoType.contact)
            .toList()
            .first
            .id ??
        '';
    if (event.viewType == ViewType.viewMember) {
      final contactResponse = await appRepository.getMemberContactInfo(
          contactBaseId: contactBaseId);
      if (contactResponse.status == ResponseStatus.success) {
        if (contactResponse.data != null) {
          emit(UserInfoGetContactSuccessState(
              contactInfoResponse: contactResponse.data!));
        }
      } else {
        emit(UserInfoGetContactFailedState());
      }
    } else {
      final contactResponse = await appRepository.getMemberContactInfoViewOwn(
          contactBaseId: contactBaseId);
      if (contactResponse.status == ResponseStatus.success) {
        if (contactResponse.data != null) {
          emit(UserInfoGetContactSuccessState(
              contactInfoResponse: contactResponse.data!));
        }
      } else {
        emit(UserInfoGetContactFailedState());
      }
    }
  }

  FutureOr<void> _onConfigurationDisplay(
      UserInfoConfigurationDisplayEvent event,
      Emitter<UserInfoState> emit) async {
    emit(UserInfoLoadingState());
    ResponseWrapper response =
        await appRepository.swapDisplayPosition(event.listDisplayItem);
    if (response.status == ResponseStatus.success) {
      toastSuccess("Cập nhật thành công");
      add(UserInfoGetPersonalInfoEvent(
          viewType: ViewType.viewOwn, isPopLoadingDialog: true));
    }
  }

  FutureOr<void> _onUpdateUserAvatarUrlEvent(
      UserInfoUpdateUserAvatarUrlSuccessEvent event,
      Emitter<UserInfoState> emit) {
    emit(UserInfoUpdateUserAvatarUrlSuccessState(avatarUrl: event.avatarUrl));
  }

  FutureOr<void> _onConfigurationAdditionalPath(
      UserInfoConfigurationAdditionalPathEvent event,
      Emitter<UserInfoState> emit) async {
    emit(UserInfoLoadingState());
    ResponseWrapper response = await appRepository
        .swapAdditionalPathPosition(event.listAdditionalPath);
    if (response.status == ResponseStatus.success) {
      toastSuccess("Cập nhật thành công");
      add(UserInfoGetAdditionalPathInfoEvent(viewType: ViewType.viewOwn));
    }
  }

  FutureOr<void> _onConfigurationContact(
      UserInfoConfigurationContactEvent event,
      Emitter<UserInfoState> emit) async {
    emit(UserInfoLoadingState());
    ResponseWrapper response =
        await appRepository.swapContactPosition(event.listContact);
    if (response.status == ResponseStatus.success) {
      toastSuccess("Cập nhật thành công");
      add(UserInfoGetContactInfoEvent(viewType: ViewType.viewOwn));
    }
  }

  FutureOr<void> _onRebuildHighlight(
      UserInfoRebuildHighlightInfoEvent event, Emitter<UserInfoState> emit) {
    emit(UserInfoGetHighlightSuccessState(
        highlightInfo: memberInfo?.hightlight,
        isHidden: memberInfo?.hightlightHidden));
  }

  String getBaseInfoIdByType(String type) {
    log('${memberInfo?.baseInfor.toString()}');
    return memberInfo?.baseInfor
            ?.where((element) => element.type == type)
            .first
            .id ??
        '';
  }
}
