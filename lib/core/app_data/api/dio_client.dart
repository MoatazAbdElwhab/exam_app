// core/app_data/api/dio_client.dart
import 'package:dio/dio.dart';
import 'package:exam_app/core/error_handling/dio_error_exception.dart';
import 'package:exam_app/core/error_handling/exceptions/api_exceptions.dart';
import 'package:exam_app/core/logger/app_logger.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
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
        )) {
    _dio.interceptors.add(_dioPrettyLogger());
  }

  Interceptor _dioPrettyLogger() {
    return PrettyDioLogger(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
      error: true,
      compact: true,
      maxWidth: 90,
    );
  }

  @override
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  }) async {
    return _handleRequest<T>(
      () async {
        final options = await _buildOptions(requiresToken);
        final response = await _dio.get(path, queryParameters: queryParameters, options: options);
        Log.d(response.data);
        return response.data as T;
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
        return response.data as T;
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
        return response.data as T;
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
        return response.data as T;
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
        return response.data as T;
      },
    );
  }

  Future<Options?> _buildOptions(bool requiresToken) async {
    if (!requiresToken) return null;

    final token = await localStorage.getSecuredData('token');
    if (token == null) {
      Log.e('User token is null');
      throw ApiException(message: 'User token is null');
    }
    return Options(headers: {'Authorization': 'Bearer $token'});
  }

  Future<T> _handleRequest<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      Log.e('DioException: ${e.message}');
      throw errorHandler.handle(e);
    } catch (e) {
      Log.e('Unexpected error: $e');
      throw ApiException(message: 'Unexpected error: $e');
    }
  }
}
