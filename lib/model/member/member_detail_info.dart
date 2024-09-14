import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_info_response.dart';

part 'member_detail_info.freezed.dart';
part 'member_detail_info.g.dart';

@freezed
class MemberInfo with _$MemberInfo {
  factory MemberInfo({
    String? id,
    String? fullName,
    String? nickName,
    String? bio,
    String? favoriteQuote,
    String? login,
    String? avatar,
    String? coverImage,
    String? dob,
    String? gender,
    String? address,
    String? city,
    String? district,
    String? commune,
    String? registerAddressLink,
    String? hightlight,
    bool? hideInfo,
    bool? favoriteQuoteHidden,
    bool? dobHidden,
    bool? genderHidden,
    bool? addressHidden,
    bool? fullNameHidden,
    bool? nickNameHidden,
    bool? bioHidden,
    bool? hightlightHidden,
    String? logo,
    List<BaseInfoResponse>? baseInfor,
    dynamic error,
  }) = _MemberInfo;

  factory MemberInfo.fromJson(Map<String, dynamic> json) =>
      _$MemberInfoFromJson(json);
}
