import 'package:exam_app/core/app_data/api/api_constants.dart';
import 'package:exam_app/core/app_data/local_storage/local_storage_client.dart';
import 'package:exam_app/core/app_data/result.dart';
import 'package:exam_app/features/auth/data/models/auth_response.dart';
import 'package:exam_app/features/auth/data/models/sign_in_request.dart';
import 'package:exam_app/features/auth/data/models/sign_up_request.dart';
import 'package:exam_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:injectable/injectable.dart';
import '../../domain/auth_repository/auth_repository.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final LocalStorageClient _localStorageClient;

  AuthRepositoryImpl(this._remoteDataSource, this._localStorageClient);

  @override
  Future<Result<Null>> signIn(
    SignInRequest request,
  ) async {
    final response = await _remoteDataSource.signIn(request);
    if (response is Success<AuthResponse>) {
      final authResponse = response.data;
      if (authResponse != null) {
        await _localStorageClient.saveSecuredData(
          ApiConstants.tokenKey,
          authResponse.token,
        );
        print(authResponse.token);
      }
      return Success(null);
    }

    return Error((response as Error).exception);
  }

  @override
  Future<Result<Null>> signUp(SignUpRequest request) async {
    final response = await _remoteDataSource.signUp(request);

    if (response is Success<AuthResponse>) {
      final authResponse = response.data;
      if (authResponse != null) {
        await _localStorageClient.saveSecuredData(
          ApiConstants.tokenKey,
          authResponse.token,
        );
      }
      return Success(null);
    }

    return Error((response as Error).exception);
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
