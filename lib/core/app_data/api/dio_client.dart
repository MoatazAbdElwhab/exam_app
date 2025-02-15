// core/app_data/api/dio_client.dart
import 'package:dio/dio.dart';
import 'package:exam_app/core/error_handling/dio_error_handler.dart';
import 'package:exam_app/core/logger/app_logger.dart';
import 'package:injectable/injectable.dart';
import '../../error_handling/exceptions/api_exception.dart';
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
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  }) async {
    return _handleRequest(
      () async {
        final options = await _buildOptions(requiresToken);
        final response = await _dio.get(path, queryParameters: queryParameters, options: options);
        Log.d(response.data);
        return response.data;
      },
    );
  }

  @override
  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  }) async {
    return _handleRequest(
      () async {
        final options = await _buildOptions(requiresToken);
        final response = await _dio.post(path, data: data, queryParameters: queryParameters, options: options);
        Log.d(response.data);
        return response.data;
      },
    );
  }

  @override
  Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  }) async {
    return _handleRequest(
      () async {
        final options = await _buildOptions(requiresToken);
        final response = await _dio.put(path, data: data, queryParameters: queryParameters, options: options);
        Log.d(response.data);
        return response.data;
      },
    );
  }

  @override
  Future<dynamic> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  }) async {
    return _handleRequest(
      () async {
        final options = await _buildOptions(requiresToken);
        final response = await _dio.patch(path, data: data, queryParameters: queryParameters, options: options);
        Log.d(response.data);
        return response.data;
      },
    );
  }

  @override
  Future<dynamic> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  }) async {
    return _handleRequest(
      () async {
        final options = await _buildOptions(requiresToken);
        final response = await _dio.delete(path, queryParameters: queryParameters, options: options);
        Log.d(response.data);
        return response.data;
      },
    );
  }

  /// Builds request options including authorization header if needed.
  Future<Options?> _buildOptions(bool requiresToken) async {
    if (!requiresToken) return null;

    final token = await localStorage.getSecuredData('token');
    if (token == null) {
      Log.e('User token is null');
      throw ApiException(message: 'User token is null');
    }
    return Options(headers: {'Authorization': 'Bearer $token'});
  }

  /// Handles API request with error handling.
  Future<dynamic> _handleRequest(Future<dynamic> Function() request) async {
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
