// features/auth/persentation/cubit/auth_state.dart
import 'package:equatable/equatable.dart';
import 'package:exam_app/features/auth/data/data_models/user_dto.dart';

class AuthState extends Equatable {
  final AuthStatus status;
  final UserDto? user;
  final String? errorMessage;
  final String? successMessage;
  final String? forgetPasswordMessage;
  final int? resetPasswordCode;
  final bool rememberMe;
  final String? email;
  final String? resetCode;
  final String? token;

  const AuthState(
      {this.status = AuthStatus.initial,
      this.user,
      this.errorMessage,
      this.forgetPasswordMessage,
      this.resetPasswordCode,
      this.successMessage,
      this.email,
      this.resetCode,
      this.token,
      this.rememberMe = false});

  AuthState copyWith({
    AuthStatus? status,
    UserDto? user,
    String? errorMessage,
    String? successMessage,
    String? forgetPasswordMessage,
    int? resetPasswordCode,
    bool? rememberMe,
    String? email,
    String ? resetCode
  }) {
    return AuthState(
        status: status ?? this.status,
        user: user ?? this.user,
        errorMessage: errorMessage,
        successMessage: successMessage,
        forgetPasswordMessage:
            forgetPasswordMessage ?? this.forgetPasswordMessage,
        resetPasswordCode: resetPasswordCode ?? this.resetPasswordCode,
        rememberMe: rememberMe ?? this.rememberMe,
        email: email ?? this.email,
        resetCode: resetCode ?? this.resetCode
        );
  }

  @override
  List<Object?> get props => [
        status,
        rememberMe,
        user,
        errorMessage,
        forgetPasswordMessage,
        resetPasswordCode,
        successMessage
      ];
}

enum AuthStatus {
  initial,
  loading,
  success,
  loginSuccess,
  signUpSuccess,
  failure,
}

extension AuthStatusExtensions on AuthStatus {
  bool get isInitial => this == AuthStatus.initial;
  bool get isLoading => this == AuthStatus.loading;
  bool get isSuccess => this == AuthStatus.success;
  bool get isFailure => this == AuthStatus.failure;
  bool get isLoginSuccess => this == AuthStatus.loginSuccess;
  bool get isSignUpSuccess => this == AuthStatus.signUpSuccess;
}
