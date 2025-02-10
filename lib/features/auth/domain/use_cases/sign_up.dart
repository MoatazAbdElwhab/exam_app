import 'package:injectable/injectable.dart';
import '../auth_repository/auth_repository.dart';

@injectable
class SignUpUseCase {
  final AuthRepository authRepository;
  SignUpUseCase(this.authRepository);

  Future<void> execute({
    required String email,
    required String password,
    required String userName,
    required String firstName,
    required String lastName,
    required String phone
}) async {
    await authRepository.signUp(email: email, password: password
        , userName: userName,
        firstName: firstName,
        lastName: lastName,
        phone: phone);
  }
}
