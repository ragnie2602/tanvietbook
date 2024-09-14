import 'package:dio/dio.dart';

import '../../../model/api/base_response.dart';
import '../../../model/login/login_response.dart';

abstract class UserRepository {
  UserRepository();

  Future<ResponseWrapper<LoginResponse>> loginRequest({
    required String username,
    required String password,
    required bool rememberMe,
  });

  // Future<CollaboratorInfo?> getCollabInfo();

  // Future<CollaboratorTreeResponse?> getCollabTree();

  // Future<CheckCollaboratorResponse?> checkCollaborator();

  Future<Response> getForgotPasswordMethod({required String username});

  Future<Response> sendOTP(
      {required String username, required String type, required String value});

  Future<Response> checkOTP({required String username, required String key});

  Future<Response> forgotPasswordComplete(
      {required String newPassword,
      required String username,
      required String key});

  Future<Response> vcfFile({required String username, required Object body});

  Future<Response> getDetailMedia(
      {required String memberId, required String type});

  Future<Response> verifiedEmailOtp(
      {required String username, required String value});

  Future<Response> verifiedEmailComplete(
      {required String username, required String key});

  Future<Response> getInformation();

  Future<Response> changePassword(
      {required String currentPassword, required String newPassword});
}
