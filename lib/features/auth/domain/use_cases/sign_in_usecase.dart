// features/auth/domain/use_cases/sign_in_usecase.dart
import 'package:either_dart/either.dart';
import 'package:exam_app/features/auth/data/data_models/response/sign_in_response.dart';
import 'package:injectable/injectable.dart';
import '../auth_repository/auth_repository.dart';

@injectable

class SignInUseCase {
  final AuthRepository authRepository;

  SignInUseCase(this.authRepository);

  Future<Either<Exception, SignInResponse>> execute(String email, String password,
      bool rememberMe) async {
    return await authRepository.signIn(email, password, rememberMe);
  }
}