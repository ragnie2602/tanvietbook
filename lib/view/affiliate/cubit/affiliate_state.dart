part of 'affiliate_cubit.dart';

@freezed
class AffiliateState with _$AffiliateState {
  const factory AffiliateState.initial() = AffiliateInitial;

  factory AffiliateState.getCollaboratorInfoSuccess(
          CollaboratorResponse? collaboratorResponse) =
      AffiliateGetCollaboratorInfoSuccess;
  factory AffiliateState.getCollaboratorInfoFailed() =
      AffiliateGetCollaboratorInfoFailed;

  factory AffiliateState.checkCollaboratorExistSuccess(bool isExisted) =
      AffiliateCheckCollaboratorExistSuccess;
  factory AffiliateState.checkCollaboratorExistFailed() =
      AffiliateCheckCollaboratorExistFailed;
  factory AffiliateState.regsiterCollaboratorSuccess(bool isExisted) =
      AffiliateRegsiterCollaboratorSuccess;
  factory AffiliateState.regsiterCollaboratorFailed() =
      AffiliateRegsiterCollaboratorFailed;

  factory AffiliateState.getComissionInfoSuccess(
          AgencyComissionInfo agencyComissionInfo) =
      AffiliateGetComissionInfoSuccess;
  factory AffiliateState.getComissionInfoFailed() =
      AffiliateGetComissionInfoFailed;

  factory AffiliateState.getKPInInfoSuccess(List<KPIInfoResponse> kpiInfos) =
      AffiliateGetKPIInfoSuccess;
  factory AffiliateState.getKPIInfoFailed() = AffiliateGetKPIInfoFailed;

  factory AffiliateState.getComissionTreeSuccess(
          AgencyComissionTree agencyComissionInfo) =
      AffiliateGetComissionTreeSuccess;
  factory AffiliateState.getComissionTreeFailed() =
      AffiliateGetComissionTreeFailed;

  factory AffiliateState.getComissionHistorySuccess(
          List<AgencyComissionHistoryResponse> agencyComissionHistories) =
      AffiliateGetComissionHistorySuccess;
  factory AffiliateState.getComissionHistoryFailed() =
      AffiliateGetComissionHistoryFailed;
}
