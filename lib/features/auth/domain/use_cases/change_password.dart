import 'package:injectable/injectable.dart';
import '../auth_repository/auth_repository.dart';

@injectable
class ChangePasswordUseCase {
  final AuthRepository authRepository;

  ChangePasswordUseCase(this.authRepository);

  Future<void> execute(String oldPassword, String newPassword) async {
    await authRepository.changePassword(oldPassword, newPassword);
  }
}