// core/app_data/api/dio_client.dart
import 'package:dio/dio.dart';
import 'package:exam_app/core/error_handling/dio_error_exception.dart';
import 'package:exam_app/core/error_handling/exceptions/api_exceptions.dart';
import 'package:exam_app/core/logger/app_logger.dart';
import 'package:injectable/injectable.dart';
import '../local_storage/local_storage_client.dart';
import 'api_client.dart';

@Injectable(as: ApiClient)
class DioApiClient implements ApiClient {
  final Dio _dio;
  final LocalStorageClient localStorage;
  final DioErrorHandler errorHandler;

  DioApiClient(this.localStorage, this.errorHandler)
      : _dio = Dio(BaseOptions(
          baseUrl: 'https://exam.elevateegy.com/api/v1/',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          responseType: ResponseType.json,
        ));

  @override
@override
Future<T> get<T>(
  String path, {
  Map<String, dynamic>? queryParameters,
  bool requiresToken = false,
}) async {
  return _handleRequest<T>(// Specify the generic type T when calling _handleRequest
    () async {
      final options = await _buildOptions(requiresToken);
      final response = await _dio.get(path, queryParameters: queryParameters, options: options);
      Log.d(response.data);
      return response.data as T; // Casting the response to type T
    },
  );
}

  @override
  Future<T> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  }) async {
    return _handleRequest<T>(
      () async {
        final options = await _buildOptions(requiresToken);
        final response = await _dio.post(path, data: data, queryParameters: queryParameters, options: options);
        Log.d(response.data);
        return response.data as T; // Casting the response to type T
      },
    );
  }

  @override
  Future<T> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  }) async {
    return _handleRequest<T>(
      () async {
        final options = await _buildOptions(requiresToken);
        final response = await _dio.put(path, data: data, queryParameters: queryParameters, options: options);
        Log.d(response.data);
        return response.data as T;  // Casting the response to type T
      },
    );
  }

  @override
  Future<T> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  }) async {
    return _handleRequest<T>(
      () async {
        final options = await _buildOptions(requiresToken);
        final response = await _dio.patch(path, data: data, queryParameters: queryParameters, options: options);
        Log.d(response.data);
        return response.data as T;  // Casting the response to type T
      },
    );
  }

  @override
  Future<T> delete<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  }) async {
    return _handleRequest<T>(
      () async {
        final options = await _buildOptions(requiresToken);
        final response = await _dio.delete(path, queryParameters: queryParameters, options: options);
        Log.d(response.data);
        return response.data as T;  // Casting the response to type T
      },
    );
  }

   /// Builds request options including authorization header if needed.
  Future<Options?> _buildOptions(bool requiresToken) async {
    if (!requiresToken) return null; // No token required, return null for options

    final token = await localStorage.getSecuredData('token'); // Retrieve token from local storage
    if (token == null) {
      Log.e('User token is null'); // Log error if no token is found
      throw ApiException(message: 'User token is null'); // Throw custom exception
    }
    return Options(headers: {'Authorization': 'Bearer $token'}); // Set Authorization header if token exists
  }

  /// Handles API request with error handling.
Future<T> _handleRequest<T>(Future<T> Function() request) async {
  try {
    return await request(); // This will return a Future<T>, ensuring the correct type is used
  } on DioException catch (e) {
    Log.e('DioException: ${e.message}');
    throw errorHandler.handle(e); // Handle Dio-specific errors and rethrow them
  } catch (e) {
    Log.e('Unexpected error: $e');
    throw ApiException(message: 'Unexpected error: $e'); // Handle unexpected errors
  }
}


}
