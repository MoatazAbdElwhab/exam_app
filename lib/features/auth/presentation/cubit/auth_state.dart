import 'package:equatable/equatable.dart';

enum Status { loading, success, error }

class AuthState extends Equatable {
  final Status status;
  final String? loadingMessage;
  final Exception? exception;
  final String? navigationRoute;

  const AuthState({
    required this.status,
    this.loadingMessage,
    this.exception,
    this.navigationRoute,
  });

  AuthState copyWith({
    Status? status,
    String? loadingMessage,
    Exception? exception,
  }) {
    return AuthState(
      status: status ?? this.status,
      loadingMessage: loadingMessage ?? this.loadingMessage,
      exception: exception ?? this.exception,
    );
  }

  @override
  List<Object?> get props => [
        status,
        loadingMessage,
        exception,
      ];
}
