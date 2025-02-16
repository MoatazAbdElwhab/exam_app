import 'package:exam_app/core/app_data/api/api_constants.dart';
import 'package:exam_app/core/app_data/local_storage/local_storage_client.dart';
import 'package:exam_app/core/app_data/result.dart';
import 'package:exam_app/core/di/injectable.dart';
import 'package:exam_app/core/utils/error_message_handler.dart';
import 'package:exam_app/features/auth/data/models/sign_in_request.dart';
import 'package:exam_app/features/auth/data/models/sign_up_request.dart';
import 'package:exam_app/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:exam_app/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:injectable/injectable.dart';
import 'auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@singleton
class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  AuthCubit(this._signInUseCase, this._signUpUseCase)
      : super(const AuthState(status: Status.loading));

  Future<void> signIn() async {
    emit(state.copyWith(status: Status.loading));
    final result = await _signInUseCase(
      SignInRequest(
        email: 'moatazAbdElwhabb@gmail.com',
        password: 'moataz@A21',
      ),
    );
    switch (result) {
      case Success():
        emit(state.copyWith(status: Status.success));
        print('success');
        final token = await getIt
            .get<LocalStorageClient>()
            .getSecuredData(ApiConstants.tokenKey);
        print(token);

      case Error():
        emit(state.copyWith(status: Status.error, exception: result.exception));
        print(handleErrorMessage(result.exception));

        break;
      default:
    }
  }

  Future<void> signUp() async {
    emit(state.copyWith(status: Status.loading));
    final result = await _signUpUseCase(
      SignUpRequest(
        username: 'moatazsz',
        firstName: 'moataz',
        lastName: 'moataz',
        email: 'moatazAbdElwhabb@gmail.com',
        password: 'moataz@A1',
        rePassword: 'moataz@A21',
        phone: '01023541303',
      ),
    );
    switch (result) {
      case Success():
        emit(state.copyWith(status: Status.success));
        print('success');

      case Error():
        emit(state.copyWith(status: Status.error, exception: result.exception));
        print(handleErrorMessage(result.exception));
        break;
      default:
    }
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
