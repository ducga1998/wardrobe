import 'package:boilerplate/presentation/home/widgets/feature_card.dart';
import 'package:boilerplate/presentation/home/widgets/section_header.dart';
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
            _buildBanner(),
            SectionHeader(
              title: 'Popular features',
              onSeeAllTap: () => print('See all popular features tapped'),
            ),
            _buildPopularFeatures(),
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
              icon: Icon(Icons.calendar_today_outlined),
              onPressed: () => print('Calendar tapped'),
              color: Colors.black87,
            ),
            IconButton(
              icon: Icon(Icons.notifications_none_outlined),
              onPressed: () => print('Notifications tapped'),
              color: Colors.black87,
            ),
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

  Widget _buildBanner() {
    return Material(
      color: Color(0xFFF3E5F5), // Light purple
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => print('Banner tapped'),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.door_sliding_outlined, color: Colors.purple),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Share your closet',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Icon(Icons.close, size: 18, color: Colors.grey),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Share items from your closet and get outfit ideas!',
                      style: TextStyle(color: Colors.grey[700], fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularFeatures() {
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
                  onTap: () => print('Add items tapped'),
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
                  onTap: () => print('Create Outfit tapped'),
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
                  title: 'Calendar',
                  icon: Icon(Icons.calendar_month, color: Colors.blueAccent, size: 30),
                  backgroundColor: Color(0xFFF5F6FA),
                  onTap: () => print('Calendar tapped'),
                ),
              ),
            ),
            SizedBox(width: 16),
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
                  title: 'Shopping',
                  icon: Icon(Icons.shopping_cart_outlined, color: Colors.grey, size: 30),
                  backgroundColor: Color(0xFFF5F6FA),
                  onTap: () => print('Shopping tapped'),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: SizedBox(
                height: 100,
                child: FeatureCard(
                  title: 'Style chat',
                  icon: Icon(Icons.chat_bubble_outline, color: Colors.blue, size: 30),
                  backgroundColor: Color(0xFFF5F6FA),
                  onTap: () => print('Style chat tapped'),
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
                  title: 'Find my color',
                  icon: Icon(Icons.color_lens, color: Colors.pinkAccent, size: 30),
                  backgroundColor: Color(0xFFF5F6FA),
                  onTap: () => print('Find my color tapped'),
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
                  title: 'Rate style',
                  icon: Icon(Icons.star, color: Colors.blue, size: 30),
                  backgroundColor: Color(0xFFF5F6FA),
                  onTap: () => print('Rate style tapped'),
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
