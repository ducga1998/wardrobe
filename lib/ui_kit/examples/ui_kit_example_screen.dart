import 'package:flutter/material.dart';
import '../apple_ui_kit.dart';

/// Example screen demonstrating all Apple UI Kit components
class UIKitExampleScreen extends StatefulWidget {
  const UIKitExampleScreen({Key? key}) : super(key: key);

  @override
  State<UIKitExampleScreen> createState() => _UIKitExampleScreenState();
}

class _UIKitExampleScreenState extends State<UIKitExampleScreen> {
  int _selectedTab = 0;
  bool _switchValue = true;
  String _selectedSegment = 'Option 1';
  final _searchController = TextEditingController();
  final _textController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppleAppBar(
        titleText: 'Apple UI Kit',
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSection('Typography', _buildTypographyExamples()),
            const SizedBox(height: 24),
            _buildSection('Colors', _buildColorExamples()),
            const SizedBox(height: 24),
            _buildSection('Buttons', _buildButtonExamples()),
            const SizedBox(height: 24),
            _buildSection('Text Fields', _buildTextFieldExamples()),
            const SizedBox(height: 24),
            _buildSection('Cards', _buildCardExamples()),
            const SizedBox(height: 24),
            _buildSection('Segmented Control', _buildSegmentedControlExample()),
            const SizedBox(height: 24),
            _buildSection('Switches', _buildSwitchExamples()),
            const SizedBox(height: 24),
            _buildSection('List Tiles', _buildListTileExamples()),
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: AppleNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) => setState(() => _selectedTab = index),
        items: const [
          AppleNavigationBarItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: 'Home',
          ),
          AppleNavigationBarItem(
            icon: Icons.search,
            label: 'Search',
          ),
          AppleNavigationBarItem(
            icon: Icons.favorite_outline,
            activeIcon: Icons.favorite,
            label: 'Favorites',
          ),
          AppleNavigationBarItem(
            icon: Icons.person_outline,
            activeIcon: Icons.person,
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppleTypography.title2Emphasized.copyWith(
            color: isDark ? AppleColors.labelDark : AppleColors.label,
          ),
        ),
        const SizedBox(height: 12),
        content,
      ],
    );
  }

  Widget _buildTypographyExamples() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppleColors.labelDark : AppleColors.label;

    return AppleCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Large Title', style: AppleTypography.largeTitle.copyWith(color: textColor)),
          const SizedBox(height: 8),
          Text('Title 1', style: AppleTypography.title1.copyWith(color: textColor)),
          const SizedBox(height: 8),
          Text('Title 2', style: AppleTypography.title2.copyWith(color: textColor)),
          const SizedBox(height: 8),
          Text('Title 3', style: AppleTypography.title3.copyWith(color: textColor)),
          const SizedBox(height: 8),
          Text('Headline', style: AppleTypography.headline.copyWith(color: textColor)),
          const SizedBox(height: 8),
          Text('Body', style: AppleTypography.body.copyWith(color: textColor)),
          const SizedBox(height: 8),
          Text('Callout', style: AppleTypography.callout.copyWith(color: textColor)),
          const SizedBox(height: 8),
          Text('Subheadline', style: AppleTypography.subheadline.copyWith(color: textColor)),
          const SizedBox(height: 8),
          Text('Footnote', style: AppleTypography.footnote.copyWith(color: textColor)),
          const SizedBox(height: 8),
          Text('Caption 1', style: AppleTypography.caption1.copyWith(color: textColor)),
          const SizedBox(height: 4),
          Text('Caption 2', style: AppleTypography.caption2.copyWith(color: textColor)),
        ],
      ),
    );
  }

  Widget _buildColorExamples() {
    return AppleCard(
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          _buildColorChip('Blue', AppleColors.systemBlue),
          _buildColorChip('Green', AppleColors.systemGreen),
          _buildColorChip('Indigo', AppleColors.systemIndigo),
          _buildColorChip('Orange', AppleColors.systemOrange),
          _buildColorChip('Pink', AppleColors.systemPink),
          _buildColorChip('Purple', AppleColors.systemPurple),
          _buildColorChip('Red', AppleColors.systemRed),
          _buildColorChip('Teal', AppleColors.systemTeal),
          _buildColorChip('Yellow', AppleColors.systemYellow),
        ],
      ),
    );
  }

  Widget _buildColorChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: AppleTypography.footnote.copyWith(
          color: Colors.white,
          fontWeight: AppleTypography.semibold,
        ),
      ),
    );
  }

  Widget _buildButtonExamples() {
    return AppleCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppleButton(
            text: 'Filled Button',
            onPressed: () {},
            style: AppleButtonStyle.filled,
          ),
          const SizedBox(height: 12),
          AppleButton(
            text: 'Tinted Button',
            onPressed: () {},
            style: AppleButtonStyle.tinted,
            color: AppleColors.systemPurple,
          ),
          const SizedBox(height: 12),
          AppleButton(
            text: 'Gray Button',
            onPressed: () {},
            style: AppleButtonStyle.gray,
          ),
          const SizedBox(height: 12),
          AppleButton(
            text: 'Bordered Button',
            onPressed: () {},
            style: AppleButtonStyle.bordered,
            color: AppleColors.systemOrange,
          ),
          const SizedBox(height: 12),
          AppleButton(
            text: 'Plain Button',
            onPressed: () {},
            style: AppleButtonStyle.plain,
          ),
          const SizedBox(height: 12),
          AppleButton(
            text: 'Button with Icon',
            icon: Icons.star,
            onPressed: () {},
            style: AppleButtonStyle.filled,
            color: AppleColors.systemGreen,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: AppleButton(
                  text: 'Small',
                  onPressed: () {},
                  size: AppleButtonSize.small,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: AppleButton(
                  text: 'Medium',
                  onPressed: () {},
                  size: AppleButtonSize.medium,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: AppleButton(
                  text: 'Large',
                  onPressed: () {},
                  size: AppleButtonSize.large,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AppleButton(
            text: 'Disabled Button',
            onPressed: null,
            style: AppleButtonStyle.filled,
          ),
          const SizedBox(height: 12),
          AppleButton(
            text: 'Loading...',
            onPressed: () {},
            loading: true,
            style: AppleButtonStyle.filled,
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldExamples() {
    return AppleCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppleTextField(
            label: 'Email',
            placeholder: 'Enter your email',
            prefixIcon: Icons.email,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          AppleTextField(
            label: 'Password',
            placeholder: 'Enter your password',
            prefixIcon: Icons.lock,
            obscureText: true,
          ),
          const SizedBox(height: 16),
          AppleTextField(
            controller: _textController,
            label: 'Message',
            placeholder: 'Type your message',
            clearButtonMode: true,
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          AppleSearchField(
            controller: _searchController,
            placeholder: 'Search something...',
          ),
          const SizedBox(height: 16),
          AppleTextField(
            placeholder: 'Error state example',
            errorText: 'This field is required',
          ),
        ],
      ),
    );
  }

  Widget _buildCardExamples() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppleColors.labelDark : AppleColors.label;
    final secondaryColor = isDark ? AppleColors.secondaryLabelDark : AppleColors.secondaryLabel;

    return Column(
      children: [
        AppleCard(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tappable Card',
                style: AppleTypography.headline.copyWith(color: textColor),
              ),
              const SizedBox(height: 8),
              Text(
                'This card has an onTap handler and will respond to touches.',
                style: AppleTypography.body.copyWith(color: secondaryColor),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        AppleCard(
          border: Border.all(
            color: AppleColors.systemBlue,
            width: 2,
          ),
          filled: false,
          child: Text(
            'Bordered Card',
            style: AppleTypography.body.copyWith(color: textColor),
          ),
        ),
      ],
    );
  }

  Widget _buildSegmentedControlExample() {
    return AppleCard(
      child: AppleSegmentedControl<String>(
        segments: const {
          'Option 1': 'Option 1',
          'Option 2': 'Option 2',
          'Option 3': 'Option 3',
        },
        selectedValue: _selectedSegment,
        onValueChanged: (value) {
          setState(() => _selectedSegment = value);
        },
      ),
    );
  }

  Widget _buildSwitchExamples() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppleColors.labelDark : AppleColors.label;
    final secondaryColor = isDark ? AppleColors.secondaryLabelDark : AppleColors.secondaryLabel;

    return AppleGroupedCard(
      children: [
        AppleSwitchTile(
          title: Text(
            'Notifications',
            style: AppleTypography.body.copyWith(color: textColor),
          ),
          subtitle: Text(
            'Receive push notifications',
            style: AppleTypography.footnote.copyWith(color: secondaryColor),
          ),
          leading: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppleColors.systemRed,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.notifications, color: Colors.white, size: 20),
          ),
          value: _switchValue,
          onChanged: (value) => setState(() => _switchValue = value),
        ),
        AppleSwitchTile(
          title: Text(
            'Dark Mode',
            style: AppleTypography.body.copyWith(color: textColor),
          ),
          leading: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppleColors.systemIndigo,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.dark_mode, color: Colors.white, size: 20),
          ),
          value: isDark,
          onChanged: (value) {},
        ),
      ],
    );
  }

  Widget _buildListTileExamples() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppleColors.labelDark : AppleColors.label;
    final secondaryColor = isDark ? AppleColors.secondaryLabelDark : AppleColors.secondaryLabel;

    return AppleGroupedCard(
      children: [
        AppleListTile(
          leading: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppleColors.systemBlue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 20),
          ),
          title: Text(
            'Profile',
            style: AppleTypography.body.copyWith(color: textColor),
          ),
          subtitle: Text(
            'View and edit your profile',
            style: AppleTypography.footnote.copyWith(color: secondaryColor),
          ),
          showChevron: true,
          onTap: () {},
        ),
        AppleListTile(
          leading: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppleColors.systemGreen,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.security, color: Colors.white, size: 20),
          ),
          title: Text(
            'Privacy',
            style: AppleTypography.body.copyWith(color: textColor),
          ),
          showChevron: true,
          onTap: () {},
        ),
        AppleListTile(
          leading: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppleColors.systemOrange,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.help, color: Colors.white, size: 20),
          ),
          title: Text(
            'Help & Support',
            style: AppleTypography.body.copyWith(color: textColor),
          ),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppleColors.systemRed,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '3',
              style: AppleTypography.caption2.copyWith(
                color: Colors.white,
                fontWeight: AppleTypography.bold,
              ),
            ),
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
