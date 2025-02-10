import 'package:injectable/injectable.dart';

import '../auth_repository/auth_repository.dart';

@injectable
class GetLoggedUserInfoUseCase {
  final AuthRepository authRepository;

  GetLoggedUserInfoUseCase(this.authRepository);

  Future<void> execute() async {
    await authRepository.getLoggedUserInfo();
  }
}
