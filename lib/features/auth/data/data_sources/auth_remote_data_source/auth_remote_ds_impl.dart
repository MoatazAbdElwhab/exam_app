import 'package:either_dart/either.dart';
import 'package:exam_app/features/auth/data/data_models/response/change_password_response.dart';
import 'package:exam_app/features/auth/data/data_models/response/delete_account_response.dart';
import 'package:exam_app/features/auth/data/data_models/response/edit_profile_response.dart';
import 'package:exam_app/features/auth/data/data_models/response/forget_password_response.dart';
import 'package:exam_app/features/auth/data/data_models/response/get_logged_user_data_response.dart';
import 'package:exam_app/features/auth/data/data_models/response/logout_response.dart';
import 'package:exam_app/features/auth/data/data_models/response/reset_password_response.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/app_data/api/api_client.dart';
import '../../../../../core/error_handling/exceptions/api_exception.dart';
import '../../../../../core/logger/app_logger.dart';
import '../../data_models/response/sign_in_response.dart';
import '../../data_models/response/sign_up_response.dart';
import '../../data_models/response/verify_reset_code_response.dart';
import 'auth_remote_ds_interface.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Either<ApiException, SignInResponse>> signIn(
      String email, String password) async {
    try {
      final response = await _apiClient.post(
        'auth/signin',
        data: {
          'email': email,
          'password': password,
        },
        requiresToken: false,
      );
      Log.d('auth remote datasource got response / returns \n '
          '${Right(SignInResponse.fromJson(response))}');
      return Right(SignInResponse.fromJson(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<ApiException, SignUpResponse>> signUp(
      {required String email,
      required String password,
      required String userName,
      required String firstName,
      required String lastName,
      required String phone}) async {
    try {
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
      Log.d('auth remote datasource got response / returns \n '
          '${Right(SignUpResponse.fromJson(response))}');
      return Right(SignUpResponse.fromJson(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<ApiException, ForgetPasswordResponse>> forgotPassword(
      String email) async {
    try {
      final response = await _apiClient.post(
        'auth/forgotPassword',
        data: {'email': email},
        requiresToken: false,
      );
      Log.d('auth remote datasource got response / returns \n'
          '${Right(ForgetPasswordResponse.fromJson(response))}');
      return Right(ForgetPasswordResponse.fromJson(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<ApiException, ResetPasswordResponse>> resetPassword(
      String email, String newPassword) async {
    try {
      final response = await _apiClient.put(
        'auth/resetPassword',
        data: {
          'email': email,
          'newPassword': newPassword,
        },
        requiresToken: false,
      );
      Log.d('auth remote datasource got response / returns \n '
          '${Right(ResetPasswordResponse.fromJson(response))}');
      return Right(ResetPasswordResponse.fromJson(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<ApiException, ChangePasswordResponse>> changePassword(
      String oldPassword, String newPassword) async {
    try {
      final response = await _apiClient.patch(
        'auth/changePassword',
        data: {
          'oldPassword': oldPassword,
          'password': newPassword,
          'rePassword': newPassword,
        },
      );
      Log.d('auth remote datasource got response / returns \n '
          '${Right(ChangePasswordResponse.fromJson(response))}');
      return Right(ChangePasswordResponse.fromJson(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<ApiException, DeleteAccountResponse>> deleteAccount() async {
    try {
      final response = await _apiClient.delete(
        'auth/deleteMe',
      );
      Log.d('auth remote datasource got response / returns \n '
          '${Right(DeleteAccountResponse.fromJson(response))}');
      return Right(DeleteAccountResponse.fromJson(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<ApiException, EditProfileResponse>> editProfile(
      {required Map<String, String> changedFields}) async {
    try {
      final response = await _apiClient.put(
        'auth/editProfile',
        data: changedFields,
      );
      Log.d('auth remote datasource got response / returns \n '
          '${Right(EditProfileResponse.fromJson(response))}');
      return Right(EditProfileResponse.fromJson(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<ApiException, LogoutResponse>> logout() async {
    try {
      final response = await _apiClient.get(
        'auth/logout',
      );
      Log.d('auth remote datasource got response / returns \n'
          '${Right(LogoutResponse.fromJson(response))}');
      return Right(LogoutResponse.fromJson(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<ApiException, GetLoggedUserDataResponse>>
      getLoggedUserInfo() async {
    try {
      final response = await _apiClient.get(
        'auth/profileData',
      );
      Log.d('auth remote datasource got response / returns \n '
          '${Right(GetLoggedUserDataResponse.fromJson(response))}');
      return Right(GetLoggedUserDataResponse.fromJson(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<ApiException, VerifyResetCodeResponse>> verifyResetCodeResponse(
      String otp) async {
    try {
      final response = await _apiClient.post('auth/verifyResetCode',
          data: {'resetCode': otp}, requiresToken: false);
      Log.d('auth remote datasource got response / returns \n'
          '${Right(VerifyResetCodeResponse.fromJson(response))}');
      return Right(VerifyResetCodeResponse.fromJson(response));
    } catch (e) {
      rethrow;
    }
  }
}
