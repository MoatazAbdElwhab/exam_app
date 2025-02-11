import 'package:either_dart/either.dart';
import 'package:exam_app/core/error_handling/exceptions/api_exception.dart';
import 'package:exam_app/features/auth/data/models/sign_up_request.dart';
import 'package:injectable/injectable.dart';
import '../auth_repository/auth_repository.dart';

@injectable
class SignUpUseCase {
  final AuthRepository authRepository;
  SignUpUseCase(this.authRepository);

  Future<Either<ApiException, Null>> call(
    SignUpRequest request,
  ) async {
    return await authRepository.signUp(request);
  }
}
