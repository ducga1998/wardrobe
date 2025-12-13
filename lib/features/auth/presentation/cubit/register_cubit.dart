
import 'package:bloc/bloc.dart';
import 'package:boilerplate/domain/usecase/auth/register_usecase.dart';
import 'package:boilerplate/features/auth/presentation/cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterCubit(this._registerUseCase) : super(RegisterInitial());

  Future<void> register(String email, String password) async {
    emit(RegisterLoading());
    try {
      await _registerUseCase.call(params: RegisterParams(email: email, password: password));
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }
}
