// features/auth/domain/use_cases/verify_reset_code_usecase.dart
import 'package:either_dart/either.dart';
import 'package:exam_app/features/auth/data/data_models/response/verify_reset_code_response.dart';
import 'package:injectable/injectable.dart';
import '../auth_repository/auth_repository.dart';

@injectable
class VerifyResetCodeUseCase {
  final AuthRepository authRepository;

  // Constructor that takes an instance of AuthRepository
  VerifyResetCodeUseCase(this.authRepository);

  // Method to execute the verify reset code functionality
  Future<Either<Exception, VerifyResetCodeResponse>> execute(String otp) async {
    try {
      // Call the repository to verify the OTP and return the result
      return await authRepository.verifyResetCodeResponse(otp);
    } catch (e) {
      // Return exception in case of any errors
      return Left(Exception('Error verifying reset code: $e'));
    }
  }
}
