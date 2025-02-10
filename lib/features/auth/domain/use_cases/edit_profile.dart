import 'package:injectable/injectable.dart';

import '../auth_repository/auth_repository.dart';

@injectable
class EditProfileUseCase {
  final AuthRepository authRepository;

  EditProfileUseCase(this.authRepository);

  Future<void> execute({required Map<String,String> changedFields}) async {
    await authRepository.editProfile(changedFields: changedFields);
  }
}
