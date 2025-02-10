import 'package:injectable/injectable.dart';

import '../auth_repository/auth_repository.dart';

@injectable
class LogoutUseCase {
  final AuthRepository authRepository;

  LogoutUseCase(this.authRepository);

  Future<void> execute() async {
    await authRepository.logout();
  }
}
