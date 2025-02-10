import 'package:either_dart/src/either.dart';

import 'package:exam_app/core/error_handling/exceptions/api_exception.dart';

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
import '../../domain/auth_repository/auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRemoteDataSource authRemoteDataSource;
  AuthLocalDataSource authLocalDataSource;
  AuthRepositoryImpl(this.authLocalDataSource,this.authRemoteDataSource);

  @override
  Future<Either<ApiException, ChangePasswordResponse>> changePassword(
      String oldPassword, String newPassword) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  Future<Either<ApiException, DeleteAccountResponse>> deleteAccount() {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }

  @override
  Future<Either<ApiException, EditProfileResponse>> editProfile(
      {required Map<String, String> changedFields}) {
    // TODO: implement editProfile
    throw UnimplementedError();
  }

  @override
  Future<Either<ApiException, ForgetPasswordResponse>> forgotPassword(
      String email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<ApiException, GetLoggedUserDataResponse>> getLoggedUserInfo() {
    // TODO: implement getLoggedUserInfo
    throw UnimplementedError();
  }

  @override
  Future<Either<ApiException, LogoutResponse>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Either<ApiException, ResetPasswordResponse>> resetPassword(
      String email, String resetCode, String newPassword) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<ApiException, SignInResponse>> signIn(
      String email, String password) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<Either<ApiException, SignUpResponse>> signUp(
      {required String email,
      required String password,
      required String userName,
      required String firstName,
      required String lastName,
      required String phone}) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<Either<ApiException, VerifyResetCodeResponse>> verifyResetCodeResponse(
      String otp) {
    // TODO: implement verifyResetCodeResponse
    throw UnimplementedError();
  }
}
