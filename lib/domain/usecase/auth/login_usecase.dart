
import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/repository/auth/auth_repository.dart';

class LoginUseCase extends UseCase<void, LoginParams> {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  @override
  Future<void> call({required LoginParams params}) {
    return _authRepository.login(params.email, params.password);
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
