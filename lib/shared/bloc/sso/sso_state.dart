part of 'sso_cubit.dart';

@freezed
class SsoState with _$SsoState {
  const factory SsoState.initial() = _Initial;

  factory SsoState.getUserInfoSuccessState(UserSettingsResponse user) =
      SsoGetUserInfoSuccess;
  factory SsoState.getUserInfoFailedState() = SsoGetUserInfoFailed;
}
