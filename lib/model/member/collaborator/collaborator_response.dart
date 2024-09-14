import 'package:freezed_annotation/freezed_annotation.dart';

part 'collaborator_response.freezed.dart';
part 'collaborator_response.g.dart';

@unfreezed
class CollaboratorResponse with _$CollaboratorResponse {
  factory CollaboratorResponse({
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
    String? status,
  }) = _CollaboratorResponse;

  factory CollaboratorResponse.fromJson(Map<String, dynamic> json) =>
      _$CollaboratorResponseFromJson(json);
}
