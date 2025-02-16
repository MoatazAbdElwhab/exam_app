// features/auth/data/auth_repository/auth_repo_impl.dart
import 'package:either_dart/src/either.dart';
import 'package:exam_app/core/app_repository/app_repository.dart';
import 'package:exam_app/core/error_handling/exceptions/api_exceptions.dart';
import 'package:exam_app/core/error_handling/exceptions/network_exception.dart';
import 'package:exam_app/features/auth/data/data_models/response/change_password_response.dart';
import 'package:exam_app/features/auth/data/data_models/response/delete_account_response.dart';
import 'package:exam_app/features/auth/data/data_models/response/edit_profile_response.dart';
import 'package:exam_app/features/auth/data/data_models/response/forget_password_response.dart';
import 'package:exam_app/features/auth/data/data_models/response/get_logged_user_data_response.dart';
import 'package:exam_app/features/auth/data/data_models/response/logout_response.dart';
import 'package:exam_app/features/auth/data/data_models/response/reset_password_response.dart';
import 'package:exam_app/features/auth/data/data_models/response/sign_in_response.dart';
import 'package:exam_app/features/auth/data/data_models/response/sign_up_response.dart';
import 'package:exam_app/features/auth/data/data_models/response/verify_reset_code_response.dart';
import 'package:exam_app/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:exam_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error_handling/exceptions/local_storage_exception.dart';
import '../../../../core/logger/app_logger.dart';
import '../../domain/auth_repository/auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends AppRepository implements AuthRepository {
  AuthRemoteDataSource authRemoteDataSource;
  AuthLocalDataSource authLocalDataSource;
  AuthRepositoryImpl(
      this.authLocalDataSource, this.authRemoteDataSource, super.checker);

  @override
  Future<Either<Exception, ChangePasswordResponse>> changePassword(
      String oldPassword, String newPassword) async {
    if (!isOnline) {
      return Left(NetworkException('No internet connection'));
    }
    try {
      final apiResponse =
          await authRemoteDataSource.changePassword(oldPassword, newPassword);
      if (apiResponse.isRight && apiResponse.right.token != null) {
        await authLocalDataSource.cacheToken(apiResponse.right.token!);
        return Right(apiResponse.right);
      }else{
        return Left(apiResponse.left);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Exception, DeleteAccountResponse>> deleteAccount() async {
    if (!isOnline) {
      return Left(NetworkException('No internet connection'));
    }
    try {
      final apiResponse = await authRemoteDataSource.deleteAccount();
      await authLocalDataSource.deleteUserAccount();
      return apiResponse;
    } catch (e) {
      return Left(
          ApiException(message: 'Delete account failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Exception, EditProfileResponse>> editProfile(
      {required Map<String, String> changedFields}) async {
    if (!isOnline) {
      return Left(NetworkException('No internet connection'));
    }
    try {
      final apiResponse =
          await authRemoteDataSource.editProfile(changedFields: changedFields);
      if (apiResponse.isRight) {
        await authLocalDataSource
            .cacheUserProfileInfo(apiResponse.right.toJson());
      }else{
        return Left(apiResponse.left);
      }
      return apiResponse;
    } catch (e) {
      return Left(
          ApiException(message: 'Edit profile failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Exception, ForgetPasswordResponse>> forgotPassword(
      String email) async {
    if (!isOnline) {
      return Left(NetworkException('No internet connection'));
    }
    try {
      final response = await authRemoteDataSource.forgotPassword(email);
      return response;
    } catch (e) {
      return Left(
          ApiException(message: 'Forgot password failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Exception, GetLoggedUserDataResponse>>
      getLoggedUserInfo() async {
    if (!isOnline) {
      print({'isOnline $isOnline'});
      try {
        final response = await authLocalDataSource.getCachedUserInfo();
        final localResponse = GetLoggedUserDataResponse.fromJson(response!);
        return Right(localResponse);
      } catch (e) {
        return Left(LocalStorageException(
            'Failed to get cached user info: ${e.toString()}'));
      }
    }
    print({'isOnline $isOnline'});

    try {
      final apiResponse = await authRemoteDataSource.getLoggedUserInfo();
      if (apiResponse.isRight) {
        await authLocalDataSource
            .cacheUserProfileInfo(apiResponse.right.toJson());
        return Right(apiResponse.right);
      }else{
        return Left(apiResponse.left);
      }

    } catch (e) {
      return Left(
          ApiException(message: 'Get user info failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Exception, LogoutResponse>> logout() async {
    if (!isOnline) {
      return Left(NetworkException('No internet connection'));
    }
    try {
      final apiResponse = await authRemoteDataSource.logout();
      if(apiResponse.isRight){
        await authLocalDataSource.deleteUserAccount();
        return apiResponse;
      }else{
        return Left(apiResponse.left);
      }
    } catch (e) {
      return Left(ApiException(message: 'Logout failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Exception, ResetPasswordResponse>> resetPassword(
      String email, dynamic resetCode, String newPassword) async {
    if (!isOnline) {
      return Left(NetworkException('No internet connection'));
    }
    try {
      final response = await authRemoteDataSource.resetPassword(
          email, resetCode, newPassword);

      if (response.isRight && response.right.token != null) {
        await authLocalDataSource.cacheToken(response.right.token!);
        return Right(response.right);
      }else{
        return Left(response.left);
      }

    } catch (e) {
      return Left(
          ApiException(message: 'Reset password failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Exception, SignInResponse>> signIn(
      String email, String password, bool rememberMe) async {
    if (!isOnline) {
      return Left(NetworkException('No internet connection'));
    }
    try {
      final apiResponse = await authRemoteDataSource.signIn(email, password);
      if (apiResponse.isRight) {
        if(rememberMe) {
          await _cacheUserSigningData(apiResponse.right);
        }
        return Right(apiResponse.right);
      }
      return Left(apiResponse.left);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<Exception, SignUpResponse>> signUp(
      {required String email,
      required String password,
      required String userName,
      required String firstName,
      required String lastName,
      required String phone}) async {
    if (!isOnline) {
      return Left(NetworkException('No internet connection'));
    }
    try {
      final apiResponse = await authRemoteDataSource.signUp(
          email: email,
          password: password,
          userName: userName,
          firstName: firstName,
          lastName: lastName,
          phone: phone);

      if (apiResponse.isRight) {
        await _cacheUserSigningData(apiResponse.right);
        return Right(apiResponse.right);
      }
      return Left(apiResponse.left);
    } catch (e) {
      return Left(ApiException(message: 'Sign up failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Exception, VerifyResetCodeResponse>> verifyResetCodeResponse(
      String otp) async {
    if (!isOnline) {
      return Left(NetworkException('No internet connection'));
    }
    try {
      final apiResponse =
          await authRemoteDataSource.verifyResetCodeResponse(otp);
      if(apiResponse.isRight){
        return apiResponse;
      }else{
        return Left(apiResponse.left);
      }
    } catch (e) {
      return Left(
          ApiException(message: 'Verify reset code failed: ${e.toString()}'));
    }
  }

  Future<void> _cacheUserSigningData(dynamic response) async {
    Log.i('will caching user data');
    try {
      if (response.token != null) {
        await authLocalDataSource.cacheToken(response.token!);
        Log.i('cached user token successfully');
      }
      if (response.user != null) {
        await authLocalDataSource.cacheUserProfileInfo(response.user!.toJson());
        Log.i('cached user data successfully');
      }
    } catch (e) {
      Log.e('Failed to cache user data: ${e.toString()}');
      throw LocalStorageException('Failed to cache user data: ${e.toString()}');
    }
  }
}