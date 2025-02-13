import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../data/data_models/response/change_password_response.dart';
import '../auth_repository/auth_repository.dart';

@injectable
class ChangePasswordUseCase {
  final AuthRepository authRepository;

  ChangePasswordUseCase(this.authRepository);

  Future<Either<Exception, ChangePasswordResponse>> execute(
      String oldPassword, String newPassword) async {
    return await authRepository.changePassword(oldPassword, newPassword);
  }
}
