import 'package:equatable/equatable.dart';
import 'package:exam_app/features/auth/data/data_models/user_dto.dart';

class AuthState extends Equatable {
  final AuthStatus status;
  final UserDto? user;
  final String? errorMessage;
  final String? successMessage;
  final bool? shouldSendOtp;
  final int? resetPasswordCode;
  final bool loginRememberMeCheckBoxValue;
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
      this.loginRememberMeCheckBoxValue = false});

  AuthState copyWith(
      {AuthStatus? status,
      UserDto? user,
      String? errorMessage,
      String? successMessage,
      bool? shouldSendOtp,
      int? resetPasswordCode,
      bool? shouldUpdatePassword,
      String? forgetPasswordEmail,
      bool? loginRememberMeCheckBoxValue}) {
    return AuthState(
        status: status ?? this.status,
        user: user ?? this.user,
        errorMessage: errorMessage,
        successMessage: successMessage,
        shouldSendOtp: shouldSendOtp,
        shouldUpdatePassword: shouldUpdatePassword,
        forgetPasswordEmail: forgetPasswordEmail ?? this.forgetPasswordEmail,
        resetPasswordCode: resetPasswordCode ?? this.resetPasswordCode,
        loginRememberMeCheckBoxValue: loginRememberMeCheckBoxValue ?? this.loginRememberMeCheckBoxValue);
  }

  @override
  List<Object?> get props => [
        status,
    loginRememberMeCheckBoxValue,
        user,
        errorMessage,
        shouldSendOtp,
        resetPasswordCode,
        successMessage,
        shouldUpdatePassword,
        forgetPasswordEmail,
      ];
}

enum AuthStatus {
  initial,
  loading,
  success,
  loginSuccess,
  signUpSuccess,
  failure,
  loggedOut,
  profileUpdated;
}

extension AuthStatusExtensions on AuthStatus {
  bool get isInitial => this == AuthStatus.initial;
  bool get isLoading => this == AuthStatus.loading;
  bool get isSuccess => this == AuthStatus.success;
  bool get isFailure => this == AuthStatus.failure;
  bool get isLoginSuccess => this == AuthStatus.loginSuccess;
  bool get isSignUpSuccess => this == AuthStatus.signUpSuccess;
  bool get isLoggedOut => this == AuthStatus.loggedOut;
  bool get isProfileUpdated => this == AuthStatus.profileUpdated;
}
