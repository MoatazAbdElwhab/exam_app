import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../data/data_models/response/delete_account_response.dart';
import '../auth_repository/auth_repository.dart';

@injectable
class DeleteAccountUseCase {
  final AuthRepository authRepository;

  DeleteAccountUseCase(this.authRepository);

  Future<Either<Exception, DeleteAccountResponse>> execute() async {
    return await authRepository.deleteAccount();
  }
}
