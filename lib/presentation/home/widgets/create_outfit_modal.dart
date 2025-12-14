import 'package:flutter/material.dart';

class CreateOutfitModal extends StatelessWidget {
  const CreateOutfitModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 36),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Text(
            'How would you like to create an outfit',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _buildOptionItem(
                  title: 'Place freely',
                  // Using Icons as placeholders for the actual clothing images
                  content: _buildPlaceholderImage([Icons.checkroom, Icons.layers]),
                  backgroundColor: const Color(0xFFF5F5F5),
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildOptionItem(
                  title: 'Select by category',
                  content: _buildPlaceholderImage([Icons.iron, Icons.dry_cleaning, Icons.style]),
                  backgroundColor: const Color(0xFFF5F5F5),
                  onTap: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildOptionItem(
                  title: 'Acloset Layout',
                  content: _buildPlaceholderImage([Icons.grid_view]),
                  backgroundColor: const Color(0xFFF5F5F5),
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildOptionItem(
                  title: 'Outfit Suggestions',
                  content: Center(
                    child: Icon(Icons.face, size: 48, color: Colors.blue.shade300),
                  ),
                  backgroundColor: const Color(0xFFF5F5F5),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderImage(List<IconData> icons) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: icons.map((icon) => 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Icon(icon, size: 32, color: Colors.grey.shade400),
          )
        ).toList(),
      ),
    );
  }

  Widget _buildOptionItem({
    required String title,
    required Widget content,
    required Color backgroundColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 140, // Taller to accommodate image + text
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: content,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
