import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../data/data_models/response/edit_profile_response.dart';
import '../auth_repository/auth_repository.dart';

@injectable
class EditProfileUseCase {
  final AuthRepository authRepository;

  EditProfileUseCase(this.authRepository);

  Future<Either<Exception, EditProfileResponse>> execute({required Map<String,String> changedFields}) async {
    return await authRepository.editProfile(changedFields: changedFields);
  }
}
