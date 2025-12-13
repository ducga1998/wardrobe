
import 'package:boilerplate/domain/usecase/auth/register_usecase.dart';
import 'package:boilerplate/features/auth/presentation/cubit/register_cubit.dart';

import '../../../di/service_locator.dart';

class BlocModule {
  static Future<void> configureBlocModuleInjection() async {
    // auth:--------------------------------------------------------------------
    getIt.registerFactory<RegisterCubit>(
      () => RegisterCubit(getIt<RegisterUseCase>()),
    );
  }
}
