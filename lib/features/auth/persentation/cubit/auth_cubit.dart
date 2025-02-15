// features/auth/persentation/cubit/auth_cubit.dart
import 'package:exam_app/core/error_handling/exceptions/api_exceptions.dart';
import 'package:exam_app/features/auth/domain/use_cases/forget_password_usecase.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/logger/app_logger.dart';
import '../../../../core/utils/validator.dart';
import '../../domain/use_cases/change_password_usecase.dart';
import '../../domain/use_cases/delete_account_usecase.dart';
import '../../domain/use_cases/edit_profile_usecase.dart';
import '../../domain/use_cases/get_logged_user_info_usecase.dart';
import '../../domain/use_cases/logout_usecase.dart';
import '../../domain/use_cases/reset_password_usecase.dart';
import '../../domain/use_cases/sign_in_usecase.dart';
import '../../domain/use_cases/sign_up_usecase.dart';
import '../../domain/use_cases/verify_reset_code_usecase.dart';
import 'auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@singleton
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
  }) : super(const AuthState());

  Future<void> signIn() async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await signInUseCase.execute(
        loginEmailController.text.trim(),
        loginPasswordController.text.trim(),
        state.rememberMe);
    response.isLeft
        ? emit(state.copyWith(
            errorMessage: response.left.toString(), status: AuthStatus.failure))
        : emit(state.copyWith(
            user: response.right.user!,
            status: AuthStatus.loginSuccess,
            successMessage: 'logged in successfully',
          ));
  }

  Future<void> signUp(
      {required String email,
      required String password,
      required String userName,
      required String firstName,
      required String lastName,
      required String phone}) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await signUpUseCase.execute(
        email: email,
        password: password,
        userName: userName,
        firstName: firstName,
        lastName: lastName,
        phone: phone);
    response.isLeft
        ? emit(state.copyWith(
            errorMessage: response.left.toString(), status: AuthStatus.failure))
        : emit(state.copyWith(
            user: response.right.user,
            status: AuthStatus.signUpSuccess,
            successMessage: 'signed up successfully'));
  }

  Future<void> forgotPassword(String email) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await forgotPasswordUseCase.execute(email);
    response.isLeft
        ? emit(state.copyWith(
            errorMessage: response.left.toString(), status: AuthStatus.failure))
        : emit(
            state.copyWith(
                forgetPasswordMessage: response.right.info,
                status: AuthStatus.success),
          );
  }

  Future<void> resetPassword(
      String email, String resetCode, String newPassword) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response =
        await resetPasswordUseCase.execute(email, resetCode, newPassword);
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
        : emit(state.copyWith(status: AuthStatus.success, user: null));
  }

  Future<void> getLoggedUserInfo() async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await getLoggedUserInfoUseCase.execute();
    if (response.isLeft) {
      emit(state.copyWith(
          errorMessage: response.left.toString(), status: AuthStatus.failure));
    } else {
      emit(state.copyWith(
          user: response.right.user, status: AuthStatus.success));
    }
  }

  Future<void> verifyResetCode(String otp) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await verifyResetCodeUseCase.execute(otp);
    if (response.isLeft) {
      emit(state.copyWith(
          errorMessage: response.left.toString(), status: AuthStatus.failure));
    } else {
      if (response.right.status != null) {
        emit(state.copyWith(
            status: AuthStatus.success,
            resetPasswordCode: int.parse(response.right.status!)));
      } else {
        emit(state.copyWith(errorMessage: 'null status from api'));
      }
    }
  }

  updateRememberMe(bool value) {
    emit(state.copyWith(rememberMe: value));
  }

  bool isFormValid({required bool isLogin}) {
    if (isLogin) {
      var emailValidation =
          Validator.emailValidate(loginEmailController.text.trim());
      var passwordValidation =
          Validator.passwordValidation(loginPasswordController.text.trim());

      return emailValidation == null && passwordValidation == null;
    } else {
      var emailV = Validator.emailValidate(signUpEmailController.text.trim());
      var passwordV =
          Validator.passwordValidation(signUpPasswordController.text.trim());
      var userNameV =
          Validator.userNameValidation(signUpUserNameController.text.trim());
      var firstNameV =
          Validator.firstNameValidation(signUpFirstNameController.text.trim());
      var lastNameV =
          Validator.emailValidate(signUpLastNameController.text.trim());
      var confirmPasswordV = Validator.passwordValidation(
          signUpConfirmPasswordController.text.trim());
      var phoneNumV = Validator.phoneNumberValidation(
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
    Log.i('disposing controllers');
    disposeSignUpControllers();
    disposeSignInControllers();
    return super.close();
  }

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
}
