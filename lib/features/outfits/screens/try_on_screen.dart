import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:boilerplate/features/outfits/tryon_controller.dart';
import 'package:boilerplate/features/outfits/widgets/try_on_preview.dart';
import 'package:boilerplate/features/wardrobe/models/wardrobe_item.dart';

class TryOnScreen extends ConsumerStatefulWidget {
  final List<WardrobeItem> selectedItems;

  const TryOnScreen({super.key, required this.selectedItems});

  @override
  ConsumerState<TryOnScreen> createState() => _TryOnScreenState();
}

class _TryOnScreenState extends ConsumerState<TryOnScreen> {
  final _picker = ImagePicker();

  Future<void> _pickSelfie() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      ref.read(tryOnControllerProvider.notifier).startTryOn(
            pickedFile.path,
            widget.selectedItems.map((e) => e.localPath).toList(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(tryOnControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Virtual Try-On')),
      body: Column(
        children: [
          Expanded(
            child: state.status == TryOnStatus.idle
                ? Center(
                    child: ElevatedButton.icon(
                      onPressed: _pickSelfie,
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Take Selfie'),
                    ),
                  )
                : state.status == TryOnStatus.ready && state.selfiePath != null
                    ? TryOnPreview(
                        selfiePath: state.selfiePath!,
                        garmentPaths: widget.selectedItems.map((e) => e.localPath).toList(),
                      )
                    : const Center(child: CircularProgressIndicator()),
          ),
          if (state.status == TryOnStatus.ready)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  ref.read(tryOnControllerProvider.notifier).reset();
                },
                child: const Text('Try Again'),
              ),
            ),
        ],
      ),
    );
  }
}
