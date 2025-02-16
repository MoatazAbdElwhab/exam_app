import 'package:exam_app/core/app_data/result.dart';
import 'package:exam_app/features/auth/data/models/sign_in_request.dart';
import 'package:injectable/injectable.dart';

import '../auth_repository/auth_repository.dart';

@singleton
class SignInUseCase {
  final AuthRepository authRepository;

  SignInUseCase(this.authRepository);

  Future<Result<Null>> call(SignInRequest request) async {
    return await authRepository.signIn(request);
  }
}
