import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalStore {
  Future<String> saveImage(File imageFile) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = basename(imageFile.path);
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    return savedImage.path;
  }

  Future<File> getImage(String path) async {
    return File(path);
  }
}

final localStoreProvider = Provider<LocalStore>((ref) {
  return LocalStore();
});
