// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:exam_app/core/app_data/local_storage/local_storage_client.dart'
    as _i73;
import 'package:exam_app/core/di/modules.dart' as _i81;
import 'package:exam_app/features/auth/data/auth_repository/auth_repo_impl.dart'
    as _i122;
import 'package:exam_app/features/auth/data/data_sources/auth_api_remote_data_source.dart'
    as _i893;
import 'package:exam_app/features/auth/data/data_sources/auth_remote_data_source.dart'
    as _i583;
import 'package:exam_app/features/auth/domain/auth_repository/auth_repository.dart'
    as _i24;
import 'package:exam_app/features/auth/domain/use_cases/sign_in_use_case.dart'
    as _i533;
import 'package:exam_app/features/auth/domain/use_cases/sign_up_use_case.dart'
    as _i47;
import 'package:exam_app/features/auth/presentation/cubit/auth_cubit.dart'
    as _i533;
import 'package:flutter/material.dart' as _i409;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final getItRegisterModule = _$GetItRegisterModule();
    gh.singleton<_i973.InternetConnectionChecker>(
        () => getItRegisterModule.internetConnectionChecker);
    gh.singleton<_i409.GlobalKey<_i409.NavigatorState>>(
        () => getItRegisterModule.navigatorKey);
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => getItRegisterModule.sharedPreferences,
      preResolve: true,
    );
    gh.singleton<_i558.FlutterSecureStorage>(
        () => getItRegisterModule.secureStorage);
    gh.lazySingleton<_i361.Dio>(() => getItRegisterModule.dio);
    gh.lazySingleton<_i73.LocalStorageClient>(() => _i73.LocalStorageClient(
          sharedPreferences: gh<_i460.SharedPreferences>(),
          storage: gh<_i558.FlutterSecureStorage>(),
        ));
    gh.singleton<_i583.AuthRemoteDataSource>(
        () => _i893.AuthApiRemoteDataSource(gh<_i361.Dio>()));
    gh.singleton<_i24.AuthRepository>(() => _i122.AuthRepositoryImpl(
          gh<_i583.AuthRemoteDataSource>(),
          gh<_i73.LocalStorageClient>(),
        ));
    gh.singleton<_i533.SignInUseCase>(
        () => _i533.SignInUseCase(gh<_i24.AuthRepository>()));
    gh.singleton<_i47.SignUpUseCase>(
        () => _i47.SignUpUseCase(gh<_i24.AuthRepository>()));
    gh.singleton<_i533.AuthCubit>(() => _i533.AuthCubit(
          gh<_i533.SignInUseCase>(),
          gh<_i47.SignUpUseCase>(),
        ));
    return this;
  }
}

class _$GetItRegisterModule extends _i81.GetItRegisterModule {}
