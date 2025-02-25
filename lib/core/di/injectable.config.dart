// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:exam_app/core/app_data/api/api_client.dart' as _i93;
import 'package:exam_app/core/app_data/api/dio_client.dart' as _i797;
import 'package:exam_app/core/app_data/local_storage/local_storage_client.dart'
    as _i73;
import 'package:exam_app/core/di/modules.dart' as _i81;
import 'package:exam_app/core/error_handling/dio_error_handler.dart' as _i32;
import 'package:exam_app/core/routes/navigator_observer.dart' as _i69;
import 'package:exam_app/core/widgets/dialog_utils.dart' as _i985;
import 'package:exam_app/features/auth/data/auth_repository/auth_repo_impl.dart'
    as _i122;
import 'package:exam_app/features/auth/data/data_sources/auth_local_data_source.dart'
    as _i937;
import 'package:exam_app/features/auth/data/data_sources/auth_remote_data_source.dart'
    as _i583;
import 'package:exam_app/features/auth/domain/auth_repository/auth_repository.dart'
    as _i24;
import 'package:exam_app/features/auth/domain/use_cases/change_password_usecase.dart'
    as _i890;
import 'package:exam_app/features/auth/domain/use_cases/delete_account_usecase.dart'
    as _i997;
import 'package:exam_app/features/auth/domain/use_cases/edit_profile_usecase.dart'
    as _i710;
import 'package:exam_app/features/auth/domain/use_cases/forgot_password_usecase.dart'
    as _i879;
import 'package:exam_app/features/auth/domain/use_cases/get_logged_user_info_usecase.dart'
    as _i306;
import 'package:exam_app/features/auth/domain/use_cases/logout_usecase.dart'
    as _i696;
import 'package:exam_app/features/auth/domain/use_cases/reset_password_usecase.dart'
    as _i754;
import 'package:exam_app/features/auth/domain/use_cases/sign_in_usecase.dart'
    as _i937;
import 'package:exam_app/features/auth/domain/use_cases/sign_up_usecase.dart'
    as _i756;
import 'package:exam_app/features/auth/domain/use_cases/verify_reset_code_usecase.dart'
    as _i923;
import 'package:exam_app/features/auth/presentation/cubit/auth_cubit.dart'
    as _i533;
import 'package:exam_app/features/result/data/data_sources/result_remote_data_source.dart'
    as _i933;
import 'package:exam_app/features/result/data/repositories/result_repository_impl.dart'
    as _i161;
import 'package:exam_app/features/result/domain/result_repository/result_repository.dart'
    as _i451;
import 'package:exam_app/features/result/domain/use_cases/check_answers_use_case.dart'
    as _i696;
import 'package:exam_app/features/result/domain/use_cases/get_result_usecase.dart'
    as _i101;
import 'package:exam_app/features/result/domain/use_cases/submit_answers.dart'
    as _i389;
import 'package:exam_app/features/results/presentation/cubit/result_cubit.dart'
    as _i517;
import 'package:flutter/cupertino.dart' as _i719;
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
    gh.singleton<_i409.GlobalKey<_i409.NavigatorState>>(
        () => getItRegisterModule.navigatorKey);
    gh.singleton<_i973.InternetConnectionChecker>(
        () => getItRegisterModule.checker);
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => getItRegisterModule.sharedPreferences,
      preResolve: true,
    );
    gh.singleton<_i558.FlutterSecureStorage>(
        () => getItRegisterModule.secureStorage);
    gh.singleton<_i69.AppNavigatorObserver>(() => _i69.AppNavigatorObserver());
    gh.singleton<_i985.DialogUtils>(() => _i985.DialogUtils());
    gh.singleton<_i73.LocalStorageClient>(() => _i73.LocalStorageClient(
          gh<_i460.SharedPreferences>(),
          gh<_i558.FlutterSecureStorage>(),
        ));
    gh.singleton<_i32.DioErrorHandler>(() => _i32.DioErrorHandler(
          gh<_i73.LocalStorageClient>(),
          gh<_i719.GlobalKey<_i719.NavigatorState>>(),
        ));
    gh.factory<_i937.AuthLocalDataSource>(
        () => _i937.AuthLocalDataSourceImpl(gh<_i73.LocalStorageClient>()));
    gh.singleton<_i93.ApiClient>(() => _i797.DioApiClient(
          gh<_i73.LocalStorageClient>(),
          gh<_i32.DioErrorHandler>(),
          gh<_i69.AppNavigatorObserver>(),
          gh<_i719.GlobalKey<_i719.NavigatorState>>(),
        ));
    gh.factory<_i933.ResultRemoteDataSource>(
        () => _i933.ResultRemoteDataSource(gh<_i93.ApiClient>()));
    gh.factory<_i451.ResultRepository>(
        () => _i161.ResultRepositoryImpl(gh<_i933.ResultRemoteDataSource>()));
    gh.factory<_i583.AuthRemoteDataSource>(
        () => _i583.AuthRemoteDataSourceImpl(gh<_i93.ApiClient>()));
    gh.singleton<_i101.GetResultUseCase>(
        () => _i101.GetResultUseCase(gh<_i451.ResultRepository>()));
    gh.singleton<_i389.SubmitAnswers>(
        () => _i389.SubmitAnswers(gh<_i451.ResultRepository>()));
    gh.factory<_i696.CheckAnswersUseCase>(
        () => _i696.CheckAnswersUseCase(gh<_i451.ResultRepository>()));
    gh.factory<_i24.AuthRepository>(() => _i122.AuthRepositoryImpl(
          gh<_i937.AuthLocalDataSource>(),
          gh<_i583.AuthRemoteDataSource>(),
        ));
    gh.factory<_i517.ResultCubit>(
        () => _i517.ResultCubit(gh<_i451.ResultRepository>()));
    gh.factory<_i890.ChangePasswordUseCase>(
        () => _i890.ChangePasswordUseCase(gh<_i24.AuthRepository>()));
    gh.factory<_i997.DeleteAccountUseCase>(
        () => _i997.DeleteAccountUseCase(gh<_i24.AuthRepository>()));
    gh.factory<_i710.EditProfileUseCase>(
        () => _i710.EditProfileUseCase(gh<_i24.AuthRepository>()));
    gh.factory<_i879.ForgotPasswordUseCase>(
        () => _i879.ForgotPasswordUseCase(gh<_i24.AuthRepository>()));
    gh.factory<_i306.GetLoggedUserInfoUseCase>(
        () => _i306.GetLoggedUserInfoUseCase(gh<_i24.AuthRepository>()));
    gh.factory<_i696.LogoutUseCase>(
        () => _i696.LogoutUseCase(gh<_i24.AuthRepository>()));
    gh.factory<_i754.ResetPasswordUseCase>(
        () => _i754.ResetPasswordUseCase(gh<_i24.AuthRepository>()));
    gh.factory<_i937.SignInUseCase>(
        () => _i937.SignInUseCase(gh<_i24.AuthRepository>()));
    gh.factory<_i756.SignUpUseCase>(
        () => _i756.SignUpUseCase(gh<_i24.AuthRepository>()));
    gh.factory<_i923.VerifyResetCodeUseCase>(
        () => _i923.VerifyResetCodeUseCase(gh<_i24.AuthRepository>()));
    gh.factory<_i533.AuthCubit>(() => _i533.AuthCubit(
          signInUseCase: gh<_i937.SignInUseCase>(),
          signUpUseCase: gh<_i756.SignUpUseCase>(),
          forgotPasswordUseCase: gh<_i879.ForgotPasswordUseCase>(),
          resetPasswordUseCase: gh<_i754.ResetPasswordUseCase>(),
          changePasswordUseCase: gh<_i890.ChangePasswordUseCase>(),
          deleteAccountUseCase: gh<_i997.DeleteAccountUseCase>(),
          editProfileUseCase: gh<_i710.EditProfileUseCase>(),
          logoutUseCase: gh<_i696.LogoutUseCase>(),
          getLoggedUserInfoUseCase: gh<_i306.GetLoggedUserInfoUseCase>(),
          verifyResetCodeUseCase: gh<_i923.VerifyResetCodeUseCase>(),
          storageClient: gh<_i73.LocalStorageClient>(),
        ));
    return this;
  }
}

class _$GetItRegisterModule extends _i81.GetItRegisterModule {}
