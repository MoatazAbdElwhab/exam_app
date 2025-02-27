// features/auth/presentation/cubit/auth_state.dart
import 'package:equatable/equatable.dart';
import 'package:exam_app/features/auth/data/data_models/user_dto.dart';

class AuthState extends Equatable {
  final AuthStatus status;
  final UserDto? user;
  final String? errorMessage;
  final String? successMessage;
  final bool? shouldSendOtp;
  final int? resetPasswordCode;
  final bool shouldRememberUser;
  final bool? shouldUpdatePassword;
  final String? forgetPasswordEmail;

  const AuthState(
      {this.status = AuthStatus.initial,
      this.user,
      this.errorMessage,
      this.shouldSendOtp,
      this.resetPasswordCode,
      this.successMessage,
      this.forgetPasswordEmail,
      this.shouldUpdatePassword = false,
      this.shouldRememberUser = false});

  AuthState copyWith(
      {AuthStatus? status,
      UserDto? user,
      String? errorMessage,
      String? successMessage,
      bool? shouldSendOtp,
      int? resetPasswordCode,
      bool? shouldUpdatePassword,
      String? forgetPasswordEmail,
      bool? shouldRememberUser}) {
    return AuthState(
        status: status ?? this.status,
        user: user ?? this.user,
        errorMessage: errorMessage,
        successMessage: successMessage,
        shouldSendOtp: shouldSendOtp,
        shouldUpdatePassword: shouldUpdatePassword,
        forgetPasswordEmail: forgetPasswordEmail ?? this.forgetPasswordEmail,
        resetPasswordCode: resetPasswordCode ?? this.resetPasswordCode,
        shouldRememberUser: shouldRememberUser ?? this.shouldRememberUser);
  }

  @override
  List<Object?> get props => [
        status,
        shouldRememberUser,
        user,
        errorMessage,
        shouldSendOtp,
        resetPasswordCode,
        successMessage,
        shouldUpdatePassword,
        shouldRememberUser,
        forgetPasswordEmail
      ];
}

enum AuthStatus {
  initial,
  loading,
  success,
  loginSuccess,
  signUpSuccess,
  failure,
  loggedOut
}

extension AuthStatusExtensions on AuthStatus {
  bool get isInitial => this == AuthStatus.initial;
  bool get isLoading => this == AuthStatus.loading;
  bool get isSuccess => this == AuthStatus.success;
  bool get isFailure => this == AuthStatus.failure;
  bool get isLoginSuccess => this == AuthStatus.loginSuccess;
  bool get isSignUpSuccess => this == AuthStatus.signUpSuccess;
  bool get isLoggedOut => this == AuthStatus.loggedOut;
}
