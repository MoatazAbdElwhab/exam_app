import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../data/data_models/response/sign_in_response.dart';
import '../auth_repository/auth_repository.dart';

@injectable

class SignInUseCase {
  final AuthRepository authRepository;

  SignInUseCase(this.authRepository);

  Future<Either<Exception, SignInResponse>> execute(String email, String password,
      bool shouldRememberUser) async {
    return await authRepository.signIn(email, password, shouldRememberUser);
  }
}