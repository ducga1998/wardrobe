import 'package:boilerplate/presentation/di/module/store_module.dart';
import 'package:boilerplate/presentation/di/module/bloc_module.dart';

class PresentationLayerInjection {
  static Future<void> configurePresentationLayerInjection() async {
    await StoreModule.configureStoreModuleInjection();
    await BlocModule.configureBlocModuleInjection();
  }
}
