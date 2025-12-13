import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import 'package:boilerplate/data/db_provider.dart';
import 'package:boilerplate/data/local_store.dart';
import 'package:boilerplate/features/wardrobe/models/wardrobe_item.dart';
import 'package:boilerplate/services/image_service.dart';

class WardrobeController extends StateNotifier<AsyncValue<List<WardrobeItem>>> {
  final DbProvider _dbProvider;
  final ImageService _imageService;
  final LocalStore _localStore;
  final _uuid = const Uuid();

  WardrobeController(this._dbProvider, this._imageService, this._localStore) : super(const AsyncValue.loading()) {
    _loadItems();
  }

  Future<void> _loadItems() async {
    try {
      final db = await _dbProvider.database;
      final maps = await db.query('wardrobe_items');
      final items = maps.map((e) => WardrobeItem.fromMap(e)).toList();
      state = AsyncValue.data(items);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addItem({
    required String imagePath,
    required WardrobeItemType type,
  }) async {
    try {
      // 1. Save image to local store
      print('Saving image to local store...');
      final savedPath = await _localStore.saveImage(File(imagePath));
      print('Image saved to: $savedPath');

      // 2. Segment image (async)
      print('Segmenting image...');
      final maskPath = await _imageService.segmentGarment(savedPath);
      print('Segmentation complete. Mask path: $maskPath');

      // 3. Create item
      final item = WardrobeItem(
        id: _uuid.v4(),
        localPath: savedPath,
        maskPath: maskPath,
        type: type,
        createdAt: DateTime.now(),
      );

      // 4. Save to DB
      print('Inserting into DB...');
      final db = await _dbProvider.database;
      await db.insert('wardrobe_items', item.toMap());
      print('DB insert complete.');

      // 5. Update state
      print('Updating state...');
      final currentItems = state.value ?? [];
      state = AsyncValue.data([...currentItems, item]);
      print('State updated with ${state.value?.length} items.');
    } catch (e, st) {
      print('Error adding item: $e');
      throw e; // Rethrow to let UI handle it
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      final db = await _dbProvider.database;
      await db.delete('wardrobe_items', where: 'id = ?', whereArgs: [id]);
      
      final currentItems = state.value ?? [];
      state = AsyncValue.data(currentItems.where((item) => item.id != id).toList());
    } catch (e) {
       print('Error deleting item: $e');
    }
  }
}

final wardrobeControllerProvider = StateNotifierProvider<WardrobeController, AsyncValue<List<WardrobeItem>>>((ref) {
  final db = ref.watch(dbProvider);
  final imageService = ref.watch(imageServiceProvider);
  final localStore = ref.watch(localStoreProvider);
  return WardrobeController(db, imageService, localStore);
});
