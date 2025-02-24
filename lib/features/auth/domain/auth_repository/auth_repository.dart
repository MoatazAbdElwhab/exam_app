import 'package:either_dart/either.dart';
import '../../data/data_models/response/change_password_response.dart';
import '../../data/data_models/response/delete_account_response.dart';
import '../../data/data_models/response/edit_profile_response.dart';
import '../../data/data_models/response/forget_password_response.dart';
import '../../data/data_models/response/get_logged_user_data_response.dart';
import '../../data/data_models/response/logout_response.dart';
import '../../data/data_models/response/reset_password_response.dart';
import '../../data/data_models/response/sign_in_response.dart';
import '../../data/data_models/response/sign_up_response.dart';
import '../../data/data_models/response/verify_reset_code_response.dart';

abstract class AuthRepository {
  Future<Either<Exception, SignInResponse>> signIn(
      String email, String password, bool shouldRememberUser);
  Future<Either<Exception, SignUpResponse>> signUp(
      {required String email,
      required String password,
      required String userName,
      required String firstName,
      required String lastName,
      required String phone});
  Future<Either<Exception, ForgetPasswordResponse>> forgotPassword(
      String email);
  Future<Either<Exception, ResetPasswordResponse>> resetPassword(
      String email, String newPassword);
  Future<Either<Exception, ChangePasswordResponse>> changePassword(
      String oldPassword, String newPassword);
  Future<Either<Exception, DeleteAccountResponse>> deleteAccount();
  Future<Either<Exception, EditProfileResponse>> editProfile(
      {required Map<String, String> changedFields});
  Future<Either<Exception, LogoutResponse>> logout();
  Future<Either<Exception, GetLoggedUserDataResponse>> getLoggedUserInfo();
  Future<Either<Exception, VerifyResetCodeResponse>> verifyResetCodeResponse(
      String otp);
}
