import 'package:injectable/injectable.dart';

import '../auth_repository/auth_repository.dart';

@injectable

class SignInUseCase {
  final AuthRepository authRepository;

  SignInUseCase(this.authRepository);

  Future<void> execute(String email, String password) async {
    await authRepository.signIn(email, password);
  }
}