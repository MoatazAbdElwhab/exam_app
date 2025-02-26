import 'package:either_dart/either.dart';
import '../../../../../core/error_handling/exceptions/api_exception.dart';
import '../../data_models/response/forget_password_response.dart';
import '../../data_models/response/sign_in_response.dart';
import '../../data_models/response/sign_up_response.dart';
import 'package:exam_app/features/auth/data/data_models/response/change_password_response.dart';
import 'package:exam_app/features/auth/data/data_models/response/delete_account_response.dart';
import 'package:exam_app/features/auth/data/data_models/response/edit_profile_response.dart';
import 'package:exam_app/features/auth/data/data_models/response/get_logged_user_data_response.dart';
import 'package:exam_app/features/auth/data/data_models/response/logout_response.dart';
import 'package:exam_app/features/auth/data/data_models/response/reset_password_response.dart';
import '../../data_models/response/verify_reset_code_response.dart';

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
      String email,String newPassword);
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
