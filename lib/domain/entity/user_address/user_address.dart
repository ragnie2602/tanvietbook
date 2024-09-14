import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_address.freezed.dart';
part 'user_address.g.dart';

@unfreezed
class UserAddress with _$UserAddress {
  factory UserAddress({
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
  }) = _UserAddress;

  factory UserAddress.fromJson(Map<String, dynamic> json) =>
      _$UserAddressFromJson(json);
}
