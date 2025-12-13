import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DbProvider {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('outfit_app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('DROP TABLE IF EXISTS wardrobe_items');
          await db.execute('DROP TABLE IF EXISTS outfits');
          await _createDB(db, newVersion);
        }
      },
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';

    // Wardrobe Items Table
    await db.execute('''
CREATE TABLE wardrobe_items (
  id TEXT PRIMARY KEY,
  local_path $textType,
  mask_path $textType,
  type $textType,
  colors $textType,
  tags $textType,
  created_at $textType
)
''');

    // Outfits Table
    await db.execute('''
CREATE TABLE outfits (
  id TEXT PRIMARY KEY,
  item_ids $textType,
  score $intType,
  thumbnail_path $textType,
  created_at $textType
)
''');
  }
}

final dbProvider = Provider<DbProvider>((ref) {
  return DbProvider();
});
