import 'package:dio/dio.dart';
import 'package:exam_app/core/app_data/api/api_constants.dart';
import 'package:exam_app/core/app_data/api/api_excuter.dart';
import 'package:exam_app/core/app_data/result.dart';
import 'package:exam_app/features/auth/data/models/sign_in_request.dart';
import 'package:exam_app/features/auth/data/models/sign_up_request.dart';
import 'package:exam_app/features/auth/data/models/auth_response.dart';
import 'package:exam_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AuthRemoteDataSource)
class AuthApiRemoteDataSource implements AuthRemoteDataSource {
  final Dio _dio;

  AuthApiRemoteDataSource(this._dio);

  @override
  Future<Result<AuthResponse>> signIn(SignInRequest request) async {
    return executeApi(
      () async {
        final response = await _dio.post(
          ApiConstants.signInEndpoint,
          data: request.toJson(),
        );
        return AuthResponse.fromJson(response.data);
      },
    );
  }

  @override
  Future<Result<AuthResponse>> signUp(
    SignUpRequest request,
  ) async {
    return executeApi(
      () async {
        final response = await _dio.post(
          ApiConstants.signUpEndpoint,
          data: request.toJson(),
        );
        return AuthResponse.fromJson(response.data);
      },
    );
  }

  // @override
  // Future<Either<ApiException, ForgetPasswordResponse>> forgotPassword(
  //     String email) async {
  //   final response = await _apiClient.post(
  //     'auth/forgotPassword',
  //     data: {'email': email},
  //   );
  //   return response;
  // }

  // @override
  // Future<Either<ApiException, ResetPasswordResponse>> resetPassword(
  //     String email, String resetCode, String newPassword) async {
  //   final response = await _apiClient.post(
  //     'auth/resetPassword',
  //     data: {
  //       'email': email,
  //       'resetCode': resetCode,
  //       'newPassword': newPassword,
  //     },
  //   );
  //   return response;
  // }

  // @override
  // Future<Either<ApiException, ChangePasswordResponse>> changePassword(
  //     String oldPassword, String newPassword) async {
  //   final response = await _apiClient.post(
  //     'auth/changePassword',
  //     data: {
  //       'oldPassword': oldPassword,
  //       'newPassword': newPassword,
  //       'rePassword': newPassword,
  //     },
  //     requiresToken: true,
  //   );
  //   return response;
  // }

  // @override
  // Future<Either<ApiException, DeleteAccountResponse>> deleteAccount() async {
  //   final response = await _apiClient.delete(
  //     'auth/deleteMe',
  //     requiresToken: true,
  //   );
  //   return response;
  // }

  // @override
  // Future<Either<ApiException, EditProfileResponse>> editProfile(
  //     {required Map<String, String> changedFields}) async {
  //   final response = await _apiClient.put(
  //     'auth/editProfile',
  //     data: changedFields,
  //     requiresToken: true,
  //   );
  //   return response;
  // }

  // @override
  // Future<Either<ApiException, LogoutResponse>> logout() async {
  //   final result = await _apiClient.post(
  //     'auth/logout',
  //     requiresToken: true,
  //   );
  //   return result;
  // }

  // @override
  // Future<Either<ApiException, GetLoggedUserDataResponse>>
  //     getLoggedUserInfo() async {
  //   final response = await _apiClient.get(
  //     'auth/profileData',
  //     requiresToken: true,
  //   );
  //   return response;
  // }

  // @override
  // Future<Either<ApiException, VerifyResetCodeResponse>> verifyResetCodeResponse(
  //     String otp) async {
  //   final response =
  //       await _apiClient.post('auth/verifyResetCode', data: {'resetCode': otp});
  //   return response;
  // }
}
