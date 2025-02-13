import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../logger/app_logger.dart';
import 'exceptions/api_exception.dart';

@singleton
class DioErrorHandler {
  ApiException handle(DioException error) {
    Log.e('DioErrorHandler: handling dio error, ${error.response?.data}');

    if (error.response?.data != null &&
        error.response?.data['message'] != null) {
      return ApiException(
        message: error.response?.data['message'],
        statusCode: error.response?.statusCode,
        response: error.response?.data,
      );
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.connectionError:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException(message: 'Connection timeout. Please check your internet connection.');
      case DioExceptionType.cancel:
        return ApiException(message: 'Request is cancelled');
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case 400:
            return ApiException(
              message: 'Bad request. Please check your input.',
              statusCode: 400,
              response: error.response?.data,
            );
          case 401:
            return ApiException(
              message: 'Unauthorized. Please login again.',
              statusCode: 401,
              response: error.response?.data,
            );
          case 403:
            return ApiException(
              message: 'Access denied. You don\'t have permission for this action.',
              statusCode: 403,
              response: error.response?.data,
            );
          case 404:
            return ApiException(
              message: 'Resource not found.',
              statusCode: 404,
              response: error.response?.data,
            );
          case 500:
          case 502:
          case 503:
            return ApiException(
              message: 'Server error. Please try again later.',
              statusCode: error.response?.statusCode,
              response: error.response?.data,
            );
          default:
            return ApiException(
              message: 'Server error occurred.',
              statusCode: error.response?.statusCode,
              response: error.response?.data,
            );
        }

      case DioExceptionType.unknown:
        if (error.error != null && error.error.toString().contains('SocketException')) {
          return ApiException(message: 'No internet connection');
        }
        return ApiException(message: 'Network error occurred');

      default:
        return ApiException(message: 'Something went wrong');
    }
  }
}