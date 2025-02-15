// features/auth/domain/use_cases/get_logged_user_info_usecase.dart
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../data/data_models/response/get_logged_user_data_response.dart';
import '../auth_repository/auth_repository.dart';

@injectable
class GetLoggedUserInfoUseCase {
  final AuthRepository authRepository;

  GetLoggedUserInfoUseCase(this.authRepository);

  Future<Either<Exception, GetLoggedUserDataResponse>> execute() async {
    return await authRepository.getLoggedUserInfo();
  }
}
