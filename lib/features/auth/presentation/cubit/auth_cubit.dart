import 'package:exam_app/features/auth/data/models/sign_in_request.dart';
import 'package:exam_app/features/auth/data/models/sign_up_request.dart';
import 'package:exam_app/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:exam_app/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:injectable/injectable.dart';
import 'auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  AuthCubit(this._signInUseCase, this._signUpUseCase) : super(AuthInitial());

  Future<void> signIn() async {
    emit(AuthLoading());
    final result = await _signInUseCase(
      SignInRequest(
        email: 'email',
        password: 'password',
      ),
    );
    result.fold(
      (fail) => emit(AuthFailure(fail.message)),
      (right) => emit(AuthSuccess()),
    );
  }

  Future<void> signUp() async {
    emit(AuthLoading());
    final result = await _signUpUseCase(
      SignUpRequest(
        username: 'username',
        firstName: 'firstName',
        lastName: 'lastName',
        email: 'email',
        password: 'password',
        rePassword: 'rePassword',
        phone: 'phone',
      ),
    );
    result.fold(
      (fail) => emit(AuthFailure(fail.message)),
      (right) => emit(AuthSuccess()),
    );
  }

  // Future<void> forgotPassword(String email) async {
  //   try {
  //     emit(AuthLoading());
  //     await forgotPasswordUseCase.execute(email);
  //     emit(AuthSuccess());
  //   } catch (e) {
  //     emit(AuthFailure(e.toString()));
  //   }
  // }

  // Future<void> resetPassword(
  //     String email, String resetCode, String newPassword) async {
  //   try {
  //     emit(AuthLoading());
  //     await resetPasswordUseCase.execute(email, resetCode, newPassword);
  //     emit(AuthSuccess());
  //   } catch (e) {
  //     emit(AuthFailure(e.toString()));
  //   }
  // }

  // Future<void> changePassword(String oldPassword, String newPassword) async {
  //   try {
  //     emit(AuthLoading());
  //     await changePasswordUseCase.execute(oldPassword, newPassword);
  //     emit(AuthSuccess());
  //   } catch (e) {
  //     emit(AuthFailure(e.toString()));
  //   }
  // }

  // Future<void> deleteAccount() async {
  //   try {
  //     emit(AuthLoading());
  //     await deleteAccountUseCase.execute();
  //     emit(AuthSuccess());
  //   } catch (e) {
  //     emit(AuthFailure(e.toString()));
  //   }
  // }

  // Future<void> editProfile({required Map<String, String> changedFields}) async {
  //   try {
  //     emit(AuthLoading());
  //     await editProfileUseCase.execute(changedFields: changedFields);
  //     emit(AuthSuccess());
  //   } catch (e) {
  //     emit(AuthFailure(e.toString()));
  //   }
  // }

  // Future<void> logout() async {
  //   try {
  //     emit(AuthLoading());
  //     final response = await logoutUseCase.execute();
  //     emit(AuthSuccess());
  //   } catch (e) {
  //     emit(AuthFailure(e.toString()));
  //   }
  // }

  // // Get Logged User Info
  // Future<void> getLoggedUserInfo() async {
  //   try {
  //     emit(AuthLoading());
  //     await getLoggedUserInfoUseCase.execute();
  //     emit(AuthSuccess());
  //   } catch (e) {
  //     emit(AuthFailure(e.toString()));
  //   }
  // }
}
