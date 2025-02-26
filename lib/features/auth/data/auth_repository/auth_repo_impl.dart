import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:exam_app/core/di/injectable.dart';
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
import 'package:exam_app/features/auth/data/data_models/user_dto.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error_handling/exceptions/api_exception.dart';
import '../../../../core/error_handling/exceptions/local_storage_exception.dart';
import '../../../../core/logger/app_logger.dart';
import '../../../../main.dart';
import '../../../splash/splash.dart';
import '../../domain/auth_repository/auth_repository.dart';
import '../data_sources/auth_local_data_source/auth_local_ds_interface.dart';
import '../data_sources/auth_remote_data_source/auth_remote_ds_interface.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRemoteDataSource authRemoteDataSource;
  AuthLocalDataSource authLocalDataSource;
  AuthRepositoryImpl(this.authLocalDataSource, this.authRemoteDataSource);

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
      } else {
        return Left(apiResponse.left);
      }
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<Exception, DeleteAccountResponse>> deleteAccount() async {
    if (!isOnline) {
      return Left(NetworkException('No internet connection'));
    }
    try {
      final apiResponse = await authRemoteDataSource.deleteAccount();
      await authLocalDataSource.deleteUser();
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
      } else {
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
    try {
      final userJson = authLocalDataSource.getCachedUserInfo();
      Log.i(userJson);
      final user = GetLoggedUserDataResponse.fromJson(userJson!);
      Log.i('user: $user');
      return Right(user);
    } catch (e) {
      Log.e('auth repo failed to get user local data ${e.toString()}');
      if (!isOnline) {
        return Left(ApiException(
            message: 'error due to local data fetching,'
                ' no internet to fetch data online'));
      } else {
        final apiResponse = await authRemoteDataSource.getLoggedUserInfo();
        if (apiResponse.isRight) {
          await authLocalDataSource
              .cacheUserProfileInfo(apiResponse.right.toJson());
          return Right(apiResponse.right);
        } else {
          return Left(apiResponse.left);
        }
      }
    }
  }

  @override
  Future<Either<Exception, LogoutResponse>> logout() async {
    if (!isOnline) {
      Log.i('isOnline : $isOnline');
      return Left(NetworkException('No internet connection'));
    }
    try {
      final apiResponse = await authRemoteDataSource.logout();
      if (apiResponse.isRight) {
        await ([
          authLocalDataSource.deleteUser(),
          authLocalDataSource.removeToken(),
          authLocalDataSource.deleteRememberMe(),
        ]).wait;
        return apiResponse;
      } else {
        return Left(apiResponse.left);
      }
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<Exception, ResetPasswordResponse>> resetPassword(
      String email, String newPassword) async {
    if (!isOnline) {
      return Left(NetworkException('No internet connection'));
    }
    try {
      final response =
          await authRemoteDataSource.resetPassword(email, newPassword);
      if (response.isRight && response.right.token != null) {
        await authLocalDataSource.cacheToken(response.right.token!);
        return Right(response.right);
      } else {
        return Left(response.left);
      }
    } catch (e) {
      return Left(
          ApiException(message: 'Reset password failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Exception, SignInResponse>> signIn(
      String email, String password, bool shouldRememberUser) async {
    if (!isOnline) {
      return Left(NetworkException('No internet connection'));
    }
    try {
      Log.e('remember me: $shouldRememberUser');
      final apiResponse = await authRemoteDataSource.signIn(email, password);
      if (apiResponse.isRight) {
        await _cacheUserSigningData(apiResponse.right, shouldRememberUser);
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
        await _cacheUserSigningData(apiResponse.right, true);
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
      if (apiResponse.isRight) {
        return apiResponse;
      } else {
        return Left(apiResponse.left);
      }
    } catch (e) {
      return Left(
          ApiException(message: 'Verify reset code failed: ${e.toString()}'));
    }
  }

  Future<void> _cacheUserSigningData(dynamic response, bool rememberMe) async {
    try {
      await authLocalDataSource.cacheRememberMe(rememberMe);
      if (response.token != null) {
        Log.i('caching token');
        await authLocalDataSource.cacheToken(response.token!);
        Log.i('cached user token successfully');
      }
      if (response.user != null) {
        Log.i('cachingUserProfileInfo');
        await authLocalDataSource.cacheUserProfileInfo(response.user!.toJson());
        Log.i('cached user data successfully');
      }
    } catch (e) {
      Log.e('Failed to cache user data: ${e.toString()}');
      throw LocalStorageException('Failed to cache user data: ${e.toString()}');
    }
  }
}
