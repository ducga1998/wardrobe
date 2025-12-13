
import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/repository/auth/auth_repository.dart';

class LogoutUseCase extends UseCase<void, void> {
  final AuthRepository _authRepository;

  LogoutUseCase(this._authRepository);

  @override
  Future<void> call({required void params}) {
    return _authRepository.logout();
  }
}
