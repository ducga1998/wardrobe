import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:boilerplate/platform/ios/native_image_service.dart';

abstract class ImageService {
  Future<String> segmentGarment(String imagePath);
  Future<String> composeOutfit(String selfiePath, List<String> garmentPaths);
}

class ImageServiceImpl implements ImageService {
  @override
  Future<String> segmentGarment(String imagePath) async {
    // TODO: Implement native channel call or Dart fallback
    // For now, return the original path as a mock
    return imagePath;
  }

  @override
  Future<String> composeOutfit(String selfiePath, List<String> garmentPaths) async {
    // TODO: Implement composition logic
    // For now, return the selfie path as a mock
    return selfiePath;
  }
}


final imageServiceProvider = Provider<ImageService>((ref) {
  if (Platform.isIOS) {
    return NativeImageService();
  }
  return ImageServiceImpl();
});
