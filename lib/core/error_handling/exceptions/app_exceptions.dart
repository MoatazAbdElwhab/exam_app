// core/error_handling/exceptions/app_exceptions.dart
abstract class AppException implements Exception {
  final String message;

  //constructor to initialize the message
  AppException(this.message);
}
