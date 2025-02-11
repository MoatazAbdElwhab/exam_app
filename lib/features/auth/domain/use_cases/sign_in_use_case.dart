import 'package:either_dart/either.dart';
import 'package:exam_app/core/error_handling/exceptions/api_exception.dart';
import 'package:exam_app/features/auth/data/models/sign_in_request.dart';
import 'package:injectable/injectable.dart';

import '../auth_repository/auth_repository.dart';

@injectable
class SignInUseCase {
  final AuthRepository authRepository;

  SignInUseCase(this.authRepository);

  Future<Either<ApiException, Null>> call(SignInRequest request) async {
    return await authRepository.signIn(request);
  }
}
