import 'package:boilerplate/presentation/home/widgets/feature_card.dart';
import 'package:boilerplate/presentation/home/widgets/section_header.dart';
import 'package:boilerplate/presentation/home/widgets/create_outfit_modal.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 24),

            SectionHeader(
              title: 'Popular features',
              onSeeAllTap: () => print('See all popular features tapped'),
            ),
            _buildPopularFeatures(context),
            SectionHeader(title: 'AI Stylist'),
            _buildAIStylist(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Hello, duncan98',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: CircleAvatar(
                radius: 14,
                backgroundColor: Colors.grey[200],
                child: Icon(Icons.person_outline, size: 20, color: Colors.black87),
              ),
              onPressed: () => print('Profile tapped'),
            ),
          ],
        ),
      ],
    );
  }



  Widget _buildPopularFeatures(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 100,
                child: FeatureCard(
                  title: 'Add items',
                  isLarge: true,
                  icon: Icon(Icons.add_circle, color: Colors.blue, size: 40),
                  backgroundColor: Color(0xFFE3F2FD),
                  onTap: () => context.push('/add-item'),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: SizedBox(
                height: 100,
                child: FeatureCard(
                  title: 'Create Outfit',
                  isLarge: true,
                  icon: Icon(Icons.accessibility_new, color: Colors.black87, size: 40),
                  backgroundColor: Color(0xFFFAFAFA),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (_) => const CreateOutfitModal(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 100,
                child: FeatureCard(
                  title: 'Beautify',
                  icon: Icon(Icons.auto_fix_high, color: Colors.grey, size: 30),
                  backgroundColor: Color(0xFFF5F6FA),
                  onTap: () => print('Beautify tapped'),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: SizedBox(
                height: 100,
                child: FeatureCard(
                  title: 'Style stats',
                  icon: Icon(Icons.bar_chart, color: Colors.blue, size: 30),
                  backgroundColor: Color(0xFFF5F6FA),
                  onTap: () => print('Style stats tapped'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAIStylist() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 100,
                child: FeatureCard(
                  title: 'Outfit suggestion',
                  icon: Icon(Icons.checkroom, color: Colors.blue, size: 30),
                  backgroundColor: Color(0xFFF5F6FA),
                  onTap: () => print('Outfit suggestion tapped'),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: SizedBox(
                height: 100,
                child: FeatureCard(
                  title: 'Find my fit',
                  icon: Icon(Icons.straighten, color: Colors.teal, size: 30),
                  backgroundColor: Color(0xFFF5F6FA),
                  onTap: () => print('Find my fit tapped'),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: SizedBox(
                height: 100,
                child: FeatureCard(
                  title: 'Try On',
                  icon: Icon(Icons.view_in_ar, color: Colors.black, size: 30),
                  backgroundColor: Color(0xFFF5F6FA),
                  onTap: () => print('Try On tapped'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
