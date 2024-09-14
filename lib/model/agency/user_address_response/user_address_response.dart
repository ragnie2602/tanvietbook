import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_address_response.freezed.dart';
part 'user_address_response.g.dart';

@freezed
class UserAddressResponse with _$UserAddressResponse {
  factory UserAddressResponse({
    String? id,
    String? name,
    String? email,
    String? address,
    String? commune,
    String? district,
    String? province,
    int? status,
    String? userId,
    String? phoneNumber,
  }) = _UserAddressResponse;

  factory UserAddressResponse.fromJson(Map<String, dynamic> json) =>
      _$UserAddressResponseFromJson(json);
}
