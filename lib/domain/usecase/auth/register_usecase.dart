
import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/repository/auth/auth_repository.dart';

class RegisterUseCase extends UseCase<void, RegisterParams> {
  final AuthRepository _authRepository;

  RegisterUseCase(this._authRepository);

  @override
  Future<void> call({required RegisterParams params}) {
    return _authRepository.register(params.email, params.password);
  }
}

class RegisterParams {
  final String email;
  final String password;

  RegisterParams({required this.email, required this.password});
}
