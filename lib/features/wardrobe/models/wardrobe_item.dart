import 'package:equatable/equatable.dart';

enum WardrobeItemType { top, bottom, shoe, accessory }

class WardrobeItem extends Equatable {
  final String id;
  final String localPath;
  final String? maskPath;
  final WardrobeItemType type;
  final List<String> colors;
  final List<String> tags;
  final DateTime createdAt;

  const WardrobeItem({
    required this.id,
    required this.localPath,
    this.maskPath,
    required this.type,
    this.colors = const [],
    this.tags = const [],
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, localPath, maskPath, type, colors, tags, createdAt];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'local_path': localPath,
      'mask_path': maskPath,
      'type': type.name,
      'colors': colors.join(','),
      'tags': tags.join(','),
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory WardrobeItem.fromMap(Map<String, dynamic> map) {
    return WardrobeItem(
      id: map['id'].toString(),
      localPath: map['local_path'],
      maskPath: map['mask_path'],
      type: WardrobeItemType.values.firstWhere((e) => e.name == map['type']),
      colors: (map['colors'] as String).split(',').where((e) => e.isNotEmpty).toList(),
      tags: (map['tags'] as String).split(',').where((e) => e.isNotEmpty).toList(),
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}
