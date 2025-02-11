import 'package:either_dart/either.dart';
import 'package:exam_app/core/di/injectable.dart';
import 'package:exam_app/core/error_handling/exceptions/api_exception.dart';
import 'package:exam_app/features/auth/data/models/sign_in_request.dart';
import 'package:exam_app/features/auth/data/models/sign_up_request.dart';
import 'package:exam_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/auth_repository/auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<ApiException, Null>> signIn(
    SignInRequest request,
  ) async {
    try {
      final response = await _remoteDataSource.signIn(request);
      getIt.get<SharedPreferences>().setString('token', response.token);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiException(message: 'message'));
    }
  }

  @override
  Future<Either<ApiException, Null>> signUp(
    SignUpRequest request,
  ) async {
    try {
      final response = await _remoteDataSource.signUp(request);
      getIt.get<SharedPreferences>().setString('token', response.token);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiException(message: 'message'));
    }
  }

  // @override
  // Future<Either<ApiException, ChangePasswordResponse>> changePassword(
  //     String oldPassword, String newPassword) {
  //   // TODO: implement changePassword
  //   throw UnimplementedError();
  // }

  // @override
  // Future<Either<ApiException, DeleteAccountResponse>> deleteAccount() {
  //   // TODO: implement deleteAccount
  //   throw UnimplementedError();
  // }

  // @override
  // Future<Either<ApiException, EditProfileResponse>> editProfile(
  //     {required Map<String, String> changedFields}) {
  //   // TODO: implement editProfile
  //   throw UnimplementedError();
  // }

  // @override
  // Future<Either<ApiException, ForgetPasswordResponse>> forgotPassword(
  //     String email) {
  //   // TODO: implement forgotPassword
  //   throw UnimplementedError();
  // }

  // @override
  // Future<Either<ApiException, GetLoggedUserDataResponse>> getLoggedUserInfo() {
  //   // TODO: implement getLoggedUserInfo
  //   throw UnimplementedError();
  // }

  // @override
  // Future<Either<ApiException, LogoutResponse>> logout() {
  //   // TODO: implement logout
  //   throw UnimplementedError();
  // }

  // @override
  // Future<Either<ApiException, ResetPasswordResponse>> resetPassword(
  //     String email, String resetCode, String newPassword) {
  //   // TODO: implement resetPassword
  //   throw UnimplementedError();
  // }

  // @override
  // Future<Either<ApiException, SignInResponse>> signIn(
  //     String email, String password) {
  //   // TODO: implement signIn
  //   throw UnimplementedError();
  // }

  // @override
  // Future<Either<ApiException, SignUpResponse>> signUp(
  //     {required String email,
  //     required String password,
  //     required String userName,
  //     required String firstName,
  //     required String lastName,
  //     required String phone}) {
  //   // TODO: implement signUp
  //   throw UnimplementedError();
  // }

  // @override
  // Future<Either<ApiException, VerifyResetCodeResponse>> verifyResetCodeResponse(
  //     String otp) {
  //   // TODO: implement verifyResetCodeResponse
  //   throw UnimplementedError();
  // }
}
