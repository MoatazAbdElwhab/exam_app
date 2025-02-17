import 'package:dio/dio.dart';
import 'package:exam_app/core/error_handling/dio_error_handler.dart';
import 'package:exam_app/core/logger/app_logger.dart';
import 'package:exam_app/core/routes/navigator_observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import '../../error_handling/exceptions/api_exception.dart';
import '../../routes/routes.dart';
import '../local_storage/local_storage_client.dart';
import 'api_client.dart';

@Injectable(as: ApiClient)
class DioApiClient implements ApiClient {
  final Dio _dio;
  final LocalStorageClient localStorage;
  final DioErrorHandler errorHandler;
  final AppNavigatorObserver _navigatorObserver;
  final GlobalKey<NavigatorState> _appNavigator;

  DioApiClient(this.localStorage, this.errorHandler, this._navigatorObserver,
      this._appNavigator)
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
    try {
      await checkToken(requiresToken);
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
      );
      Log.d(response);
      Log.d(response.data);
      return response.data;
    } on DioException catch (e) {
      Log.e(e.toString());
      throw errorHandler.handle(e);
    }
  }

  @override
  Future<dynamic> post(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      bool requiresToken = false}) async {
    try {
      await checkToken(requiresToken);
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      Log.d(response.data);
      return response.data;
    } on DioException catch (e) {
      Log.e(e.toString());
      throw errorHandler.handle(e);
    }
  }

  @override
  Future<dynamic> put(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      bool requiresToken = false}) async {
    try {
      await checkToken(requiresToken);
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      Log.d(response.data);
      return response.data;
    } on DioException catch (e) {
      Log.e(e.toString());
     throw errorHandler.handle(e);
    }
  }

  @override
  Future<dynamic> patch(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      bool requiresToken = false}) async {
    try {
      await checkToken(requiresToken);
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      Log.d(response.data);
      return response.data;
    } on DioException catch (e) {
      Log.e(e.toString());
     throw errorHandler.handle(e);
    }
  }

  @override
  Future<dynamic> delete(String path,
      {Map<String, dynamic>? queryParameters,
      bool requiresToken = false}) async {
    try {
      await checkToken(requiresToken);
      final response = await _dio.delete(
        path,
        queryParameters: queryParameters,
      );
      Log.d(response.data);
      return response.data;
    } on DioException catch (e) {
      Log.e(e.toString());
     throw errorHandler.handle(e);
    }
  }

  Future<void> checkToken(bool requiresToken) async {
    Log.i('requires token : $requiresToken');
    if (!requiresToken) return;
    try {
      final token = await localStorage.getSecuredData('token');
      if (token != null) {
        _dio.options.headers.addAll({'token': token});
      } else {
        Log.e('throwing ApiException(message: User token is null)');
        throw ApiException(message: 'User token is null');
      }
    } catch (e) {
      Log.e(
          'throwing ApiException(message: Failed to retrieve token: ${e.toString()}');
      if (_navigatorObserver.currentRoute != Routes.login &&
          _navigatorObserver.currentRoute != Routes.signup) {
        await localStorage.saveRememberMe(false);
        _appNavigator.currentState
            ?.pushNamedAndRemoveUntil(Routes.login, (route) => false);
      }
      throw ApiException(message: 'Failed to retrieve token: ${e.toString()}');
    }
  }
}
