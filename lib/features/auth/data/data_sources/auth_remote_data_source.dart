import 'package:either_dart/either.dart';
import 'package:exam_app/features/auth/data/data_models/response/change_password_response.dart';
import 'package:exam_app/features/auth/data/data_models/response/delete_account_response.dart';
import 'package:exam_app/features/auth/data/data_models/response/edit_profile_response.dart';
import 'package:exam_app/features/auth/data/data_models/response/forget_password_response.dart';
import 'package:exam_app/features/auth/data/data_models/response/get_logged_user_data_response.dart';
import 'package:exam_app/features/auth/data/data_models/response/logout_response.dart';
import 'package:exam_app/features/auth/data/data_models/response/reset_password_response.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/app_data/api/api_client.dart';
import '../../../../core/error_handling/exceptions/api_exception.dart';
import '../data_models/response/sign_in_response.dart';
import '../data_models/response/sign_up_response.dart';
import '../data_models/response/verify_reset_code_response.dart';

abstract class AuthRemoteDataSource {
  Future<Either<ApiException, SignInResponse>> signIn(
      String email, String password);
  Future<Either<ApiException, SignUpResponse>> signUp(
      {required String email,
      required String password,
      required String userName,
      required String firstName,
      required String lastName,
      required String phone});
  Future<Either<ApiException, ForgetPasswordResponse>> forgotPassword(
      String email);
  Future<Either<ApiException, ResetPasswordResponse>> resetPassword(
      String email, String resetCode, String newPassword);
  Future<Either<ApiException, ChangePasswordResponse>> changePassword(
      String oldPassword, String newPassword);
  Future<Either<ApiException, DeleteAccountResponse>> deleteAccount();
  Future<Either<ApiException, EditProfileResponse>> editProfile(
      {required Map<String, String> changedFields});
  Future<Either<ApiException, LogoutResponse>> logout();
  Future<Either<ApiException, GetLoggedUserDataResponse>> getLoggedUserInfo();
  Future<Either<ApiException, VerifyResetCodeResponse>> verifyResetCodeResponse(
      String otp);
}

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Either<ApiException, SignInResponse>> signIn(
      String email, String password) async {
    final response = await _apiClient.post(
      'auth/signin',
      data: {
        'email': email,
        'password': password,
      },
      requiresToken: false,
    );
    return response;
  }

  @override
  Future<Either<ApiException, SignUpResponse>> signUp(
      {required String email,
      required String password,
      required String userName,
      required String firstName,
      required String lastName,
      required String phone}) async {
    final response = await _apiClient.post(
      'auth/signup',
      data: {
        'username': userName,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'rePassword': password,
        'phone': phone,
      },
      requiresToken: false,
    );
    return response;
  }

  @override
  Future<Either<ApiException, ForgetPasswordResponse>> forgotPassword(
      String email) async {
    final response = await _apiClient.post(
      'auth/forgotPassword',
      data: {'email': email},
    );
    return response;
  }

  @override
  Future<Either<ApiException, ResetPasswordResponse>> resetPassword(
      String email, String resetCode, String newPassword) async {
    final response = await _apiClient.post(
      'auth/resetPassword',
      data: {
        'email': email,
        'resetCode': resetCode,
        'newPassword': newPassword,
      },
    );
    return response;
  }

  @override
  Future<Either<ApiException, ChangePasswordResponse>> changePassword(
      String oldPassword, String newPassword) async {
    final response = await _apiClient.post(
      'auth/changePassword',
      data: {
        'oldPassword': oldPassword,
        'newPassword': newPassword,
        'rePassword': newPassword,
      },
      requiresToken: true,
    );
    return response;
  }

  @override
  Future<Either<ApiException, DeleteAccountResponse>> deleteAccount() async {
    final response = await _apiClient.delete(
      'auth/deleteMe',
      requiresToken: true,
    );
    return response;
  }

  @override
  Future<Either<ApiException, EditProfileResponse>> editProfile(
      {required Map<String, String> changedFields}) async {
    final response = await _apiClient.put(
      'auth/editProfile',
      data: changedFields,
      requiresToken: true,
    );
    return response;
  }

  @override
  Future<Either<ApiException, LogoutResponse>> logout() async {
    final result = await _apiClient.post(
      'auth/logout',
      requiresToken: true,
    );
    return result;
  }

  @override
  Future<Either<ApiException, GetLoggedUserDataResponse>>
      getLoggedUserInfo() async {
    final response = await _apiClient.get(
      'auth/profileData',
      requiresToken: true,
    );
    return response;
  }

  @override
  Future<Either<ApiException, VerifyResetCodeResponse>> verifyResetCodeResponse(
      String otp) async {
    final response =
        await _apiClient.post('auth/verifyResetCode', data: {'resetCode': otp});
    return response;
  }
}
