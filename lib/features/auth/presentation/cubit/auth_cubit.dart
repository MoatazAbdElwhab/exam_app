import 'package:injectable/injectable.dart';
import '../../domain/use_cases/change_password.dart';
import '../../domain/use_cases/delete_account.dart';
import '../../domain/use_cases/edit_profile.dart';
import '../../domain/use_cases/forgot_password.dart';
import '../../domain/use_cases/get_logged_user_info.dart';
import '../../domain/use_cases/logout.dart';
import '../../domain/use_cases/reset_password.dart';
import '../../domain/use_cases/sign_in.dart';
import '../../domain/use_cases/sign_up.dart';
import 'auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@singleton
class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final ChangePasswordUseCase changePasswordUseCase;
  final DeleteAccountUseCase deleteAccountUseCase;
  final EditProfileUseCase editProfileUseCase;
  final LogoutUseCase logoutUseCase;
  final GetLoggedUserInfoUseCase getLoggedUserInfoUseCase;

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
  }) : super(AuthInitial());

  Future<void> signIn(String email, String password) async {
    try {
      emit(AuthLoading());
      final response = await signInUseCase.execute(email, password);

      emit(AuthSuccess(user: ));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signUp(
      {required String email,
      required String password,
      required String userName,
      required String firstName,
      required String lastName,
      required String phone}) async {
    try {
      emit(AuthLoading());
      await signUpUseCase.execute(
          email: email,
          password: password,
          userName: userName,
          firstName: firstName,
          lastName: lastName,
          phone: phone);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      emit(AuthLoading());
      await forgotPasswordUseCase.execute(email);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> resetPassword(
      String email, String resetCode, String newPassword) async {
    try {
      emit(AuthLoading());
      await resetPasswordUseCase.execute(email, resetCode, newPassword);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    try {
      emit(AuthLoading());
      await changePasswordUseCase.execute(oldPassword, newPassword);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> deleteAccount() async {
    try {
      emit(AuthLoading());
      await deleteAccountUseCase.execute();
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> editProfile({required Map<String, String> changedFields}) async {
    try {
      emit(AuthLoading());
      await editProfileUseCase.execute(changedFields: changedFields);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      emit(AuthLoading());
      final response = await logoutUseCase.execute();
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  // Get Logged User Info
  Future<void> getLoggedUserInfo() async {
    try {
      emit(AuthLoading());
      await getLoggedUserInfoUseCase.execute();
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
