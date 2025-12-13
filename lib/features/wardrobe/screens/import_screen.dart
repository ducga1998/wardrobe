import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:boilerplate/features/wardrobe/models/wardrobe_item.dart';
import 'package:boilerplate/features/wardrobe/wardrobe_controller.dart';

class ImportScreen extends ConsumerStatefulWidget {
  const ImportScreen({super.key});

  @override
  ConsumerState<ImportScreen> createState() => _ImportScreenState();
}

class _ImportScreenState extends ConsumerState<ImportScreen> {
  File? _image;
  WardrobeItemType _selectedType = WardrobeItemType.top;
  final _picker = ImagePicker();
  bool _isLoading = false;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      print('Picked image: ${pickedFile.path}');
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveItem() async {
    if (_image == null) return;

    setState(() => _isLoading = true);

    try {
      await ref.read(wardrobeControllerProvider.notifier).addItem(
            imagePath: _image!.path,
            type: _selectedType,
          );
      if (mounted) {
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving item: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Item')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: _image == null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => _pickImage(ImageSource.camera),
                            icon: const Icon(Icons.camera_alt),
                            label: const Text('Take Photo'),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: () => _pickImage(ImageSource.gallery),
                            icon: const Icon(Icons.photo_library),
                            label: const Text('Pick from Gallery'),
                          ),
                        ],
                      ),
                    )
                  : Image.file(_image!, fit: BoxFit.contain),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<WardrobeItemType>(
              value: _selectedType,
              decoration: const InputDecoration(labelText: 'Item Type'),
              items: WardrobeItemType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type.name.toUpperCase()),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) setState(() => _selectedType = value);
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _image != null && !_isLoading ? _saveItem : null,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Save to Wardrobe'),
            ),
          ],
        ),
      ),
    );
  }
}
