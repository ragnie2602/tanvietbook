import 'package:flutter_appauth/flutter_appauth.dart';
import '../../../model/login/login_response.dart';
import '../../../model/member/user_settings_response/user_settings_response.dart';
import '../../../model/sso/user_sso.dart';

import '../../../model/api/base_response.dart';

abstract class OpenIDRepository {
  Future<ResponseWrapper<LoginResponse>> loginRequest({
    required String username,
    required String password,
    required bool rememberMe,
  });

  Future<ResponseWrapper<AuthorizationTokenResponse>> loginBySSORequest();

  Future<ResponseWrapper<bool>> refreshToken();

  Future<ResponseWrapper<UserSSO>> getUserInfo();

  Future<ResponseWrapper<bool>> endSession();

  Future<ResponseWrapper<bool>> requestDeactive({
    required bool isDeactive,
  });

  Future<ResponseWrapper<UserSettingsResponse>> getCurrentMemberSettingInfo();
}
