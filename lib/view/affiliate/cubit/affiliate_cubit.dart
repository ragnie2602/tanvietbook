import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/repository/remote/agency_repository.dart';
import '../../../di/di.dart';
import '../../../model/agency/comission/agency_comission_history_response.dart';
import '../../../model/agency/comission/agency_comission_info_response.dart';
import '../../../model/agency/comission/agency_comission_tree_response.dart';
import '../../../model/agency/comission/agency_kpi_info_response.dart';
import '../../../model/api/base_response.dart';
import '../../../model/member/collaborator/collaborator_response.dart';

part 'affiliate_cubit.freezed.dart';
part 'affiliate_state.dart';

class AffiliateCubit extends Cubit<AffiliateState> {
  final AgencyRepository _agencyRepository = getIt.get();
  AffiliateCubit() : super(const AffiliateState.initial());

  CollaboratorResponse? collaboratorInfo;
  bool? isReferalUsernameExisted;
  String? lastUsernameChecked;

  resetState() {
    emit(const AffiliateState.initial());
  }

  getAffiliateRegisterInfo({bool force = false}) async {
    emit(const AffiliateState.initial());
    if (collaboratorInfo != null && force == false) {
      emit(AffiliateState.getCollaboratorInfoSuccess(collaboratorInfo));
      return;
    }
    final response = await _agencyRepository.getCollaboratorDetail();
    if (response.status == ResponseStatus.success) {
      collaboratorInfo = response.data;
      emit(AffiliateState.getCollaboratorInfoSuccess(collaboratorInfo));
    } else {
      emit(AffiliateState.getCollaboratorInfoFailed());
    }
  }

  checkCollaboratorExist(String username) async {
    if (lastUsernameChecked == username) {
      emit(AffiliateState.checkCollaboratorExistSuccess(
          isReferalUsernameExisted!));
      return;
    }

    lastUsernameChecked = username;
    final response =
        await _agencyRepository.checkCollaboratorExist(username: username);
    if (response.status == ResponseStatus.success) {
      isReferalUsernameExisted = response.data!;
      emit(AffiliateState.checkCollaboratorExistSuccess(
          isReferalUsernameExisted!));
    } else {
      emit(AffiliateState.checkCollaboratorExistFailed());
    }
    emit(const AffiliateState.initial());
  }

  regsiterCollaborator(CollaboratorResponse collaboratorInfo) async {
    final response =
        await _agencyRepository.regsiterCollaborator(collaboratorInfo);
    if (response.status == ResponseStatus.success) {
      emit(AffiliateState.regsiterCollaboratorSuccess(response.data!));
    } else {
      emit(AffiliateState.regsiterCollaboratorFailed());
    }
  }

  getComissionInfo({String? username}) async {
    final response =
        await _agencyRepository.getComissionInfo(username: username);
    if (response.status == ResponseStatus.success) {
      emit(AffiliateState.getComissionInfoSuccess(response.data!));
    } else {
      emit(AffiliateState.getComissionInfoFailed());
    }
  }

  getKPIInfo() async {
    final response = await _agencyRepository.getKPIInfo();
    if (response.status == ResponseStatus.success) {
      emit(AffiliateState.getKPInInfoSuccess(response.data!.toList()));
    } else {
      emit(AffiliateState.getKPIInfoFailed());
    }
  }

  getComissionTree({
    int page = 1,
    int pageSize = 999,
    bool isOwn = false,
  }) async {
    final response = await _agencyRepository.getComissionTree(isOwn: isOwn);
    if (response.status == ResponseStatus.success) {
      emit(AffiliateState.getComissionTreeSuccess(response.data!));
    } else {
      emit(AffiliateState.getComissionTreeFailed());
    }
  }

  getComissionHistory({
    int page = 1,
    int pageSize = 999,
    int? status,
    String? startDate,
    String? endDate,
    String? name,
    int? level,
    String? type,
  }) async {
    final response = await _agencyRepository.getComissionHistory(
      page: page,
      pageSize: pageSize,
      startDate: startDate,
      endDate: endDate,
      status: status,
      level: level,
      name: name,
      type: type,
    );
    if (response.status == ResponseStatus.success) {
      emit(AffiliateState.getComissionHistorySuccess(response.data!));
    } else {
      emit(AffiliateState.getComissionTreeFailed());
    }
  }
}
