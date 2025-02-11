import 'package:either_dart/either.dart';
import 'package:exam_app/features/auth/data/models/sign_in_request.dart';
import 'package:exam_app/features/auth/data/models/sign_up_request.dart';

import '../../../../core/error_handling/exceptions/api_exception.dart';

abstract class AuthRepository {
  Future<Either<ApiException, Null>> signIn(
    SignInRequest request,
  );
  Future<Either<ApiException, Null>> signUp(
    SignUpRequest request,
  );
  // Future<Either<ApiException, ForgetPasswordResponse>> forgotPassword(
  //     String email);
  // Future<Either<ApiException, ResetPasswordResponse>> resetPassword(
  //     String email, String resetCode, String newPassword);
  // Future<Either<ApiException, ChangePasswordResponse>> changePassword(
  //     String oldPassword, String newPassword);
  // Future<Either<ApiException, DeleteAccountResponse>> deleteAccount();
  // Future<Either<ApiException, EditProfileResponse>> editProfile(
  //     {required Map<String, String> changedFields});
  // Future<Either<ApiException, LogoutResponse>> logout();
  // Future<Either<ApiException, GetLoggedUserDataResponse>> getLoggedUserInfo();
  // Future<Either<ApiException, VerifyResetCodeResponse>> verifyResetCodeResponse(
  //     String otp);
}
