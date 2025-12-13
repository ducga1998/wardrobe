import 'package:flutter/services.dart';
import 'package:boilerplate/services/image_service.dart';

class NativeImageService implements ImageService {
  static const platform = MethodChannel('com.example.outfit_app/image_processing');

  @override
  Future<String> segmentGarment(String imagePath) async {
    try {
      final String maskPath = await platform.invokeMethod('segmentGarment', {'imagePath': imagePath});
      return maskPath;
    } on PlatformException catch (e) {
      print("Failed to segment garment: '${e.message}'. Falling back to original.");
      return imagePath; // Fallback
    }
  }

  @override
  Future<String> composeOutfit(String selfiePath, List<String> garmentPaths) async {
    try {
      final String compositePath = await platform.invokeMethod('composeOutfit', {
        'selfiePath': selfiePath,
        'garmentPaths': garmentPaths,
      });
      return compositePath;
    } on PlatformException catch (e) {
      print("Failed to compose outfit: '${e.message}'.");
      throw e;
    }
  }
}
