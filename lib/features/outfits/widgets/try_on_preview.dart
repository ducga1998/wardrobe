import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class TryOnPreview extends StatelessWidget {
  final String selfiePath;
  final List<String> garmentPaths;

  const TryOnPreview({
    super.key,
    required this.selfiePath,
    required this.garmentPaths,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ui.Image>>(
      future: _loadImages(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        return CustomPaint(
          painter: _TryOnPainter(snapshot.data!),
          child: Container(),
        );
      },
    );
  }

  Future<List<ui.Image>> _loadImages() async {
    final images = <ui.Image>[];
    
    // Load selfie
    final selfieData = await File(selfiePath).readAsBytes();
    final selfieCodec = await ui.instantiateImageCodec(selfieData);
    final selfieFrame = await selfieCodec.getNextFrame();
    images.add(selfieFrame.image);

    // Load garments
    for (final path in garmentPaths) {
      final data = await File(path).readAsBytes();
      final codec = await ui.instantiateImageCodec(data);
      final frame = await codec.getNextFrame();
      images.add(frame.image);
    }

    return images;
  }
}

class _TryOnPainter extends CustomPainter {
  final List<ui.Image> images;

  _TryOnPainter(this.images);

  @override
  void paint(Canvas canvas, Size size) {
    if (images.isEmpty) return;

    final paint = Paint();

    // Draw selfie (scaled to fit)
    final selfie = images[0];
    final src = Rect.fromLTWH(0, 0, selfie.width.toDouble(), selfie.height.toDouble());
    final dst = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawImageRect(selfie, src, dst, paint);

    // Draw garments (simple overlay for now)
    // In a real app, we'd use landmarks to position them
    for (int i = 1; i < images.length; i++) {
      final garment = images[i];
      final gSrc = Rect.fromLTWH(0, 0, garment.width.toDouble(), garment.height.toDouble());
      
      // Mock positioning: center the garment
      final gDst = Rect.fromCenter(
        center: dst.center,
        width: size.width * 0.5,
        height: size.height * 0.5,
      );
      
      canvas.drawImageRect(garment, gSrc, gDst, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
