import 'package:injectable/injectable.dart';

import '../auth_repository/auth_repository.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepository authRepository;

  ResetPasswordUseCase(this.authRepository);

  Future<void> execute(String email, String resetCode, String newPassword) async {
    await authRepository.resetPassword(email, resetCode, newPassword);
  }
}
