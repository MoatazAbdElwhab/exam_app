// features/auth/domain/use_cases/sign_up_usecase.dart
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../data/data_models/response/sign_up_response.dart';
import '../auth_repository/auth_repository.dart';

@injectable
class SignUpUseCase {
  final AuthRepository authRepository;
  SignUpUseCase(this.authRepository);

  Future<Either<Exception, SignUpResponse>> execute({
    required String email,
    required String password,
    required String userName,
    required String firstName,
    required String lastName,
    required String phone
}) async {
   return await authRepository.signUp(email: email, password: password
        , userName: userName,
        firstName: firstName,
        lastName: lastName,
        phone: phone);
  }
}