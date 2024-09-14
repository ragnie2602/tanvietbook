abstract class LocalDataAccess {
  void clearAccessToken();

  void clearRefreshToken();

  String getIdToken();

  void setIdToken(String idToken);

  String getAccessToken();

  void setAccessToken(String accessToken);

  String getRefreshToken();

  void setRefreshToken(String accessToken);

  String getUserId();

  void setUserId(String userId);

  String getUserName();

  void setUsername(String username);

  String getPassword();

  void setPassword(String password);

  int getUserRole();

  void setUserRole(int userRole);

  bool getAccountRemember();

  void setAccountRemember(bool accountRemember);

  String getXLicenseKey();

  void setXLicenseKey(String xLicenseKey);

  bool getIsRegisterFCMToken();

  void setIsRegisterFCMToken(bool value);

  void clearData();
}
