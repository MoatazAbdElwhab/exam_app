import 'package:exam_app/core/app_data/result.dart';
import 'package:exam_app/features/auth/data/models/sign_up_request.dart';
import 'package:injectable/injectable.dart';
import '../auth_repository/auth_repository.dart';

@singleton
class SignUpUseCase {
  final AuthRepository authRepository;
  SignUpUseCase(this.authRepository);

  Future<Result<Null>> call(
    SignUpRequest request,
  ) async {
    return await authRepository.signUp(request);
  }
}
