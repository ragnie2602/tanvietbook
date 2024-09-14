import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_settings_response.freezed.dart';
part 'user_settings_response.g.dart';

@freezed
class UserSettingsResponse with _$UserSettingsResponse {
  factory UserSettingsResponse({
    String? id,
    String? login,
    String? referralCode,
    String? firstName,
    String? email,
    bool? emailConfirmed,
    String? phoneNumber,
    dynamic type,
    String? imageUrl,
    bool? activated,
    String? activationKey,
    String? langKey,
    String? createdBy,
    DateTime? createdDate,
    String? lastModifiedBy,
    DateTime? lastModifiedDate,
    dynamic authorities,
  }) = _UserSettingsResponse;

  factory UserSettingsResponse.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsResponseFromJson(json);
}
