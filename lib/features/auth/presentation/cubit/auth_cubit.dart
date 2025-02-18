import 'dart:async';
import 'package:exam_app/core/app_data/local_storage/local_storage_client.dart';
import 'package:exam_app/core/logger/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/routes/navigator_observer.dart';
import '../../../../core/utils/validator.dart';
import '../../domain/use_cases/change_password_usecase.dart';
import '../../domain/use_cases/delete_account_usecase.dart';
import '../../domain/use_cases/edit_profile_usecase.dart';
import '../../domain/use_cases/forgot_password_usecase.dart';
import '../../domain/use_cases/get_logged_user_info_usecase.dart';
import '../../domain/use_cases/logout_usecase.dart';
import '../../domain/use_cases/reset_password_usecase.dart';
import '../../domain/use_cases/sign_in_usecase.dart';
import '../../domain/use_cases/sign_up_usecase.dart';
import '../../domain/use_cases/verify_reset_code_usecase.dart';
import 'auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  // useCases
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final ChangePasswordUseCase changePasswordUseCase;
  final DeleteAccountUseCase deleteAccountUseCase;
  final EditProfileUseCase editProfileUseCase;
  final LogoutUseCase logoutUseCase;
  final GetLoggedUserInfoUseCase getLoggedUserInfoUseCase;
  final VerifyResetCodeUseCase verifyResetCodeUseCase;
  // login
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  // signup
  final TextEditingController signUpUserNameController =
      TextEditingController();
  final TextEditingController signUpFirstNameController =
      TextEditingController();
  final TextEditingController signUpLastNameController =
      TextEditingController();
  final TextEditingController signUpEmailController = TextEditingController();
  final TextEditingController signUpPasswordController =
      TextEditingController();
  final TextEditingController signUpConfirmPasswordController =
      TextEditingController();
  final TextEditingController signUpPhoneNumberController =
      TextEditingController();

  final LocalStorageClient storageClient;

  AuthCubit({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.forgotPasswordUseCase,
    required this.resetPasswordUseCase,
    required this.changePasswordUseCase,
    required this.deleteAccountUseCase,
    required this.editProfileUseCase,
    required this.logoutUseCase,
    required this.getLoggedUserInfoUseCase,
    required this.verifyResetCodeUseCase,
    required this.storageClient,
  }) : super(const AuthState()) {
    Log.i('created cubit ${runtimeType.toString()} previous page: '
        '$appPreviousRoute current page $appCurrentRoute)}');
  }

  Future<void> signIn() async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await signInUseCase.execute(
        loginEmailController.text.trim(),
        loginPasswordController.text.trim(),
        state.shouldRememberUser);
    if (response.isLeft) {
      emit(state.copyWith(
          errorMessage: response.left.toString(), status: AuthStatus.failure));
    } else {
      emit(state.copyWith(
          user: state.shouldRememberUser ? response.right.user! : null,
          status: AuthStatus.loginSuccess,
          successMessage: 'logged in successfully'));
      loginEmailController.clear();
      loginPasswordController.clear();
    }
  }

  Future<void> signUp() async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await signUpUseCase.execute(
        email: signUpEmailController.text.trim(),
        password: signUpPasswordController.text.trim(),
        userName: signUpUserNameController.text.trim(),
        firstName: signUpFirstNameController.text.trim(),
        lastName: signUpLastNameController.text.trim(),
        phone: signUpPhoneNumberController.text.trim());
    if (response.isLeft) {
      emit(state.copyWith(
          errorMessage: response.left.toString(), status: AuthStatus.failure));
    } else {
      emit(state.copyWith(
          user: response.right.user,
          status: AuthStatus.signUpSuccess,
          successMessage: 'signed up successfully'));
      signUpEmailController.clear();
      signUpPasswordController.clear();
      signUpConfirmPasswordController.clear();
      signUpFirstNameController.clear();
      signUpLastNameController.clear();
      signUpPhoneNumberController.clear();
      signUpUserNameController.clear();
    }
  }

  Future<void> forgotPassword(String email) async {
    emit(
        state.copyWith(status: AuthStatus.loading, forgetPasswordEmail: email));
    final response = await forgotPasswordUseCase.execute(email);
    response.isLeft
        ? emit(state.copyWith(
            errorMessage: response.left.toString(), status: AuthStatus.failure))
        : emit(
            state.copyWith(shouldSendOtp: true, status: AuthStatus.success),
          );
  }

  Future<void> resendForgetPassword() async {
    if (state.forgetPasswordEmail == null) {
      emit(state.copyWith(errorMessage: 'no email provided to send code'));
    }
    await forgotPassword(state.forgetPasswordEmail!);
    if (state.shouldUpdatePassword == true) {
      emit(state.copyWith(forgetPasswordEmail: null));
    }
  }

  Future<void> resetPassword(String newPassword) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final email = state.forgetPasswordEmail;
    if (email == null) {
      Log.e('user email is null');
    }
    Log.d('message');
    final response = await resetPasswordUseCase.execute(email!, newPassword);
    response.isLeft
        ? emit(state.copyWith(
            errorMessage: response.left.toString(), status: AuthStatus.failure))
        : emit(state.copyWith(
            status: AuthStatus.success,
          ));
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response =
        await changePasswordUseCase.execute(oldPassword, newPassword);
    response.isLeft
        ? emit(state.copyWith(
            errorMessage: response.left.toString(), status: AuthStatus.failure))
        : emit(state.copyWith(status: AuthStatus.success));
  }

  Future<void> deleteAccount() async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await deleteAccountUseCase.execute();
    response.isLeft
        ? emit(state.copyWith(
            errorMessage: response.left.toString(), status: AuthStatus.failure))
        : emit(state.copyWith(status: AuthStatus.success, user: null));
  }

  Future<void> editProfile({required Map<String, String> changedFields}) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response =
        await editProfileUseCase.execute(changedFields: changedFields);
    response.isLeft
        ? emit(state.copyWith(
            errorMessage: response.left.toString(), status: AuthStatus.failure))
        : emit(state.copyWith(
            status: AuthStatus.success, user: response.right.user));
  }

  Future<void> logout() async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await logoutUseCase.execute();
    response.isLeft
        ? emit(state.copyWith(
            errorMessage: response.left.toString(), status: AuthStatus.failure))
        : emit(state.copyWith(
            status: AuthStatus.loggedOut,
            user: null,
            successMessage: 'you logged out successfully',
            shouldRememberUser: false));
  }

  Future<void> getLoggedUserInfo() async {
    if (await storageClient.getRememberMe() == false) return;
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await getLoggedUserInfoUseCase.execute();

    if (response.isLeft) {
      emit(state.copyWith(
          errorMessage: response.left.toString(), status: AuthStatus.failure));
    } else {
      emit(state.copyWith(
        user: response.right.user,
        status: AuthStatus.success,
      ));
    }
  }

  Future<void> verifyResetCode(String otp) async {
    emit(state.copyWith(shouldRememberUser: false, resetPasswordCode: null));
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await verifyResetCodeUseCase.execute(otp);
    if (response.isLeft) {
      emit(state.copyWith(
          errorMessage: response.left.toString(), status: AuthStatus.failure));
    } else {
      if (response.right.status != null) {
        emit(state.copyWith(
            status: AuthStatus.success,
            successMessage: 'success',
            shouldUpdatePassword: true,
            resetPasswordCode: int.parse(otp)));
      } else {
        emit(state.copyWith(errorMessage: 'null status from api'));
      }
    }
  }

  updateRememberMe(bool value) =>
      emit(state.copyWith(shouldRememberUser: value));

  disposeSignUpControllers() {
    signUpPhoneNumberController.dispose();
    signUpUserNameController.dispose();
    signUpConfirmPasswordController.dispose();
    signUpLastNameController.dispose();
    signUpFirstNameController.dispose();
    signUpEmailController.dispose();
    signUpPasswordController.dispose();
  }

  disposeSignInControllers() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
  }

  bool isFormValid({
    required bool isLogin,
  }) {
    if (isLogin) {
      var emailValidation =
          Validator.emailValidate(loginEmailController.text.trim());
      var passwordValidation =
          Validator.passwordValidation(loginPasswordController.text.trim());

      return emailValidation == null && passwordValidation == null;
    } else {
      dynamic emailV =
          Validator.emailValidate(signUpEmailController.text.trim());
      dynamic passwordV =
          Validator.passwordValidation(signUpPasswordController.text.trim());
      dynamic userNameV =
          Validator.userNameValidation(signUpUserNameController.text.trim());
      dynamic firstNameV =
          Validator.firstNameValidation(signUpFirstNameController.text.trim());
      dynamic lastNameV =
          Validator.lastNameValidation(signUpLastNameController.text.trim());
      dynamic confirmPasswordV = Validator.passwordValidation(
          signUpConfirmPasswordController.text.trim());
      dynamic phoneNumV = Validator.phoneNumberValidation(
          signUpPhoneNumberController.text.trim());
      return emailV == null &&
          passwordV == null &&
          userNameV == null &&
          firstNameV == null &&
          lastNameV == null &&
          confirmPasswordV == null &&
          phoneNumV == null;
    }
  }

  @override
  Future<void> close() {
    Log.i('closed cubit ${runtimeType.toString()} previous page: '
        '$appPreviousRoute current page: $appCurrentRoute)}');
    return super.close();
  }
}
