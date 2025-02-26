import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../data/data_models/response/reset_password_response.dart';
import '../auth_repository/auth_repository.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepository authRepository;

  ResetPasswordUseCase(this.authRepository);

  Future<Either<Exception, ResetPasswordResponse>> execute(
      String email, String newPassword) async {
    return await authRepository.resetPassword(email, newPassword);
  }
}
