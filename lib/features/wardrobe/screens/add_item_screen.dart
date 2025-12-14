import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddItemScreen extends StatelessWidget {
  const AddItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: const Text(''), // Intentionally empty to match design often having specific layouts
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: TextButton(
              onPressed: () {
                // TODO: Guide action
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                side: const BorderSide(color: Colors.grey, width: 0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: const Text('Guide'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add item',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 24),
            _buildGridOptions(context),
            const SizedBox(height: 32),
            const Text(
              'Library',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            _buildLibrarySearch(),
            const SizedBox(height: 16),
            _buildLibraryOptions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildGridOptions(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate item width based on 2 columns with spacing
        // (total width - spacing) / 2
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildGridItem(
              context,
              icon: Icons.image_outlined,
              label: 'Album',
              isDark: true,
              onTap: () {
                // Navigate to import from gallery
                 context.push('/wardrobe/import'); // Re-using import for now for the action
              },
            ),
            _buildGridItem(
              context,
              icon: Icons.camera_alt_outlined,
              label: 'Camera',
              onTap: () {},
            ),
            _buildGridItem(
              context,
              icon: Icons.crop_free, // Approximation for Smart Detector
              label: 'Smart Detector',
              onTap: () {},
            ),
            _buildGridItem(
              context,
              icon: Icons.language,
              label: 'Web',
              onTap: () {},
            ),
            _buildGridItem(
              context,
              icon: Icons.qr_code_scanner,
              label: 'Product code',
              onTap: () {},
            ),
            _buildGridItem(
              context,
              icon: Icons.content_paste,
              label: 'Clipboard',
              onTap: () {},
            ),
          ],
        );
      },
    );
  }

  Widget _buildGridItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isDark = false,
  }) {
    // Fixed width allowing 2 items per row with padding
    final width = (MediaQuery.of(context).size.width - 32 - 12) / 2;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: width,
        height: 80,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              color: isDark ? Colors.white : Colors.black54,
              size: 24,
            ),
            Text(
              label,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLibrarySearch() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Wide denim skirt',
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          suffixIcon: Icon(Icons.camera_alt_outlined, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildLibraryOptions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildLibraryOptionItem(
            icon: Icons.remove_red_eye_outlined,
            label: 'See all items',
            onTap: () {},
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildLibraryOptionItem(
            icon: Icons.lightbulb_outline,
            label: 'Easy search',
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildLibraryOptionItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 80,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: Colors.black54),
             Text(
              label,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
