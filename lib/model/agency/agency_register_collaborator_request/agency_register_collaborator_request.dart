import 'package:freezed_annotation/freezed_annotation.dart';

part 'agency_register_collaborator_request.freezed.dart';
part 'agency_register_collaborator_request.g.dart';

@unfreezed
class AgencyRegisterCollaboratorRequest
    with _$AgencyRegisterCollaboratorRequest {
  factory AgencyRegisterCollaboratorRequest({
    String? username,
    String? referralCode,
    String? fullname,
    String? email,
    String? mobile,
    String? dateOfBirth,
    String? permanentAddress,
    String? currentAddress,
    String? taxCode,
    String? citizenIdentityCard,
    String? dateOfIssue,
    String? placeOfIssue,
    String? image1,
    String? image2,
    String? accountName,
    String? accountNumber,
    String? bankName,
    String? agency,
    String? userId,
  }) = _AgencyRegisterCollaboratorRequest;

  factory AgencyRegisterCollaboratorRequest.fromJson(
          Map<String, dynamic> json) =>
      _$AgencyRegisterCollaboratorRequestFromJson(json);
}
