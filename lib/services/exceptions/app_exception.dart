class AppException implements Exception {
  final String message;
  final dynamic error;

  AppException([this.message = "Đã xảy ra lỗi", this.error]);

  factory AppException.wrongLogin() =>
      AppException("Sai thông tin tài khoản hoặc mật khẩu đăng nhập");
}
