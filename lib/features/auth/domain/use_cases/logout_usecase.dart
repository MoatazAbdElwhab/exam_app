// features/auth/domain/use_cases/logout_usecase.dart
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../data/data_models/response/logout_response.dart';
import '../auth_repository/auth_repository.dart';

@injectable
class LogoutUseCase {
  final AuthRepository authRepository;

  LogoutUseCase(this.authRepository);

  Future<Either<Exception, LogoutResponse>> execute() async {
    return await authRepository.logout();
  }
}