import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import 'local_data_access.dart';

class SharePrefHelper implements LocalDataAccess {
  final SharedPreferences sharedPref;

  SharePrefHelper({required this.sharedPref});

  @override
  void clearAccessToken() {
    sharedPref.remove(SharedPreferenceKey.idToken);
  }

  @override
  void clearRefreshToken() {
    sharedPref.remove(SharedPreferenceKey.refreshToken);
  }

  @override
  String getUserId() {
    return sharedPref.getString(SharedPreferenceKey.userId).toString();
  }

  @override
  void clearData() {
    sharedPref.clear();
    // sharedPref.remove(SharedPreferenceKey.idToken);
    // sharedPref.remove(SharedPreferenceKey.username);
    // sharedPref.remove(SharedPreferenceKey.password);
    // sharedPref.remove(SharedPreferenceKey.rememberMe);
  }

  @override
  bool getAccountRemember() {
    return sharedPref.getBool(SharedPreferenceKey.rememberMe) ?? false;
  }

  @override
  String getPassword() => sharedPref.getString(SharedPreferenceKey.password) ?? '';

  @override
  String getUserName() => sharedPref.getString(SharedPreferenceKey.username) ?? '';

  @override
  void setAccountRemember(bool accountRemember) {
    sharedPref.setBool(SharedPreferenceKey.rememberMe, accountRemember);
  }

  @override
  void setPassword(String password) {
    sharedPref.setString(SharedPreferenceKey.password, password);
  }

  @override
  void setUserId(String userId) {
    sharedPref.setString(SharedPreferenceKey.userId, userId);
  }

  @override
  void setUsername(String username) {
    sharedPref.setString(SharedPreferenceKey.username, username);
  }

  @override
  int getUserRole() {
    return sharedPref.getInt(SharedPreferenceKey.userRole) ?? 0;
  }

  @override
  void setUserRole(int userRole) {
    sharedPref.setInt(SharedPreferenceKey.userRole, userRole);
  }

  @override
  String getXLicenseKey() => sharedPref.getString(SharedPreferenceKey.xLicenseKey) ?? '';

  @override
  void setXLicenseKey(String xLicenseKey) {
    sharedPref.setString(SharedPreferenceKey.xLicenseKey, xLicenseKey);
  }

  @override
  String getAccessToken() {
    return sharedPref.getString(SharedPreferenceKey.accessToken) ?? '';
  }

  @override
  void setAccessToken(String accessToken) {
    sharedPref.setString(SharedPreferenceKey.accessToken, accessToken);
  }

  @override
  String getRefreshToken() => sharedPref.getString(SharedPreferenceKey.refreshToken) ?? '';

  @override
  void setRefreshToken(String refreshToken) => sharedPref.setString(SharedPreferenceKey.refreshToken, refreshToken);

  @override
  String getIdToken() => sharedPref.getString(SharedPreferenceKey.idToken) ?? '';

  @override
  void setIdToken(String idToken) => sharedPref.setString(SharedPreferenceKey.idToken, idToken);

  @override
  bool getIsRegisterFCMToken() {
    return sharedPref.getBool(SharedPreferenceKey.isRegisterFCMToken) ?? false;
  }

  @override
  void setIsRegisterFCMToken(bool value) {
    sharedPref.setBool(SharedPreferenceKey.isRegisterFCMToken, value);
  }
}
