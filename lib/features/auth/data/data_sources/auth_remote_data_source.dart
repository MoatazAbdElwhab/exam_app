import 'package:exam_app/core/app_data/result.dart';
import 'package:exam_app/features/auth/data/models/sign_in_request.dart';
import 'package:exam_app/features/auth/data/models/sign_up_request.dart';
import 'package:exam_app/features/auth/data/models/auth_response.dart';

abstract class AuthRemoteDataSource {
  Future<Result<AuthResponse>> signIn(
    SignInRequest request,
  );

  Future<Result<AuthResponse>> signUp(
    SignUpRequest request,
  );

  // Future<Either<ApiException, ForgetPasswordResponse>> forgotPassword(
  //   String email,
  // );
  // Future<Either<ApiException, ResetPasswordResponse>> resetPassword(
  //   String email,
  //   String resetCode,
  //   String newPassword,
  // );
  // Future<Either<ApiException, ChangePasswordResponse>> changePassword(
  //   String oldPassword,
  //   String newPassword,
  // );
  // Future<Either<ApiException, DeleteAccountResponse>> deleteAccount();
  // Future<Either<ApiException, EditProfileResponse>> editProfile({
  //   required Map<String, String> changedFields,
  // });
  // Future<Either<ApiException, LogoutResponse>> logout();

  // Future<Either<ApiException, GetLoggedUserDataResponse>> getLoggedUserInfo();

  // Future<Either<ApiException, VerifyResetCodeResponse>> verifyResetCodeResponse(
  //   String otp,
  // );
}
