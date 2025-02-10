import 'package:injectable/injectable.dart';

import '../auth_repository/auth_repository.dart';

@injectable
class ForgotPasswordUseCase {
  final AuthRepository authRepository;

  ForgotPasswordUseCase(this.authRepository);

  Future<void> execute(String email) async {
    await authRepository.forgotPassword(email);
  }
}
