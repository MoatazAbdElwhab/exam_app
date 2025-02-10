import 'package:injectable/injectable.dart';

import '../auth_repository/auth_repository.dart';

@injectable
class DeleteAccountUseCase {
  final AuthRepository authRepository;

  DeleteAccountUseCase(this.authRepository);

  Future<void> execute() async {
    await authRepository.deleteAccount();
  }
}
