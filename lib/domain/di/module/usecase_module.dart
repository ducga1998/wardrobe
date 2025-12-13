import 'dart:async';

import 'package:boilerplate/domain/repository/post/post_repository.dart';
import 'package:boilerplate/domain/repository/user/user_repository.dart';
import 'package:boilerplate/domain/usecase/post/delete_post_usecase.dart';
import 'package:boilerplate/domain/usecase/post/find_post_by_id_usecase.dart';
import 'package:boilerplate/domain/usecase/post/get_post_usecase.dart';
import 'package:boilerplate/domain/usecase/post/insert_post_usecase.dart';
import 'package:boilerplate/domain/usecase/post/udpate_post_usecase.dart';
import 'package:boilerplate/domain/usecase/user/is_logged_in_usecase.dart';
import 'package:boilerplate/domain/usecase/user/login_usecase.dart';
import 'package:boilerplate/domain/usecase/user/save_login_in_status_usecase.dart';
import 'package:boilerplate/domain/usecase/auth/register_usecase.dart';
import 'package:boilerplate/domain/usecase/auth/login_usecase.dart' as auth_ops;
import 'package:boilerplate/domain/usecase/auth/logout_usecase.dart';
import 'package:boilerplate/domain/repository/auth/auth_repository.dart';

import '../../../di/service_locator.dart';

class UseCaseModule {
  static Future<void> configureUseCaseModuleInjection() async {
    // user:--------------------------------------------------------------------
    getIt.registerSingleton<IsLoggedInUseCase>(
      IsLoggedInUseCase(getIt<UserRepository>()),
    );
    getIt.registerSingleton<SaveLoginStatusUseCase>(
      SaveLoginStatusUseCase(getIt<UserRepository>()),
    );
    getIt.registerSingleton<LoginUseCase>(
      LoginUseCase(getIt<UserRepository>()),
    );
    getIt.registerSingleton<auth_ops.LoginUseCase>(
      auth_ops.LoginUseCase(getIt<AuthRepository>()),
    );
    getIt.registerSingleton<RegisterUseCase>(
      RegisterUseCase(getIt<AuthRepository>()),
    );
    getIt.registerSingleton<LogoutUseCase>(
      LogoutUseCase(getIt<AuthRepository>()),
    );

    // post:--------------------------------------------------------------------
    getIt.registerSingleton<GetPostUseCase>(
      GetPostUseCase(getIt<PostRepository>()),
    );
    getIt.registerSingleton<FindPostByIdUseCase>(
      FindPostByIdUseCase(getIt<PostRepository>()),
    );
    getIt.registerSingleton<InsertPostUseCase>(
      InsertPostUseCase(getIt<PostRepository>()),
    );
    getIt.registerSingleton<UpdatePostUseCase>(
      UpdatePostUseCase(getIt<PostRepository>()),
    );
    getIt.registerSingleton<DeletePostUseCase>(
      DeletePostUseCase(getIt<PostRepository>()),
    );
  }
}
