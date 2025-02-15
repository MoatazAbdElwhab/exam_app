// features/auth/domain/use_cases/forget_password_usecase.dart
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../data/data_models/response/forget_password_response.dart';
import '../auth_repository/auth_repository.dart';

@injectable
class ForgotPasswordUseCase {
  final AuthRepository authRepository;

  ForgotPasswordUseCase(this.authRepository);

  Future<Either<Exception, ForgetPasswordResponse>> execute(String email) async {
    return await authRepository.forgotPassword(email);
  }
}