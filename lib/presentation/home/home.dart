import 'package:boilerplate/presentation/home/widgets/home_content.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/presentation/login/store/login_store.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/utils/routes/routes.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeContent(),
    Center(child: Text('Closet Page')),
    Center(child: Text('Add Page')), // Placeholder for the middle button action
    Center(child: Text('Outfit Page')),
    Center(child: Text('Explore Page')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Call logout from store (you might need to inject UserStore here or use Provider/GetIt)
               // For now, assuming you can access it or need to add it to state.
               // Let's assume we can get it via GetIt for simplicity in this file as practiced in LoginScreen
               final _userStore = getIt<UserStore>(); 
               _userStore.logout();
                Navigator.of(context).pushReplacementNamed(Routes.login);
            },
          )
        ],
      ),
      body: _selectedIndex == 2 
          ? _pages[_selectedIndex] // Handle the middle button if it was a page, but usually it's a modal
          : _pages[_selectedIndex], 
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildTabItem(icon: Icons.home_filled, label: 'Home', index: 0),
              _buildTabItem(icon: Icons.door_sliding_outlined, label: 'Closet', index: 1),
              SizedBox(width: 48), // Space for FAB
              _buildTabItem(icon: Icons.checkroom, label: 'Outfit', index: 3),
              _buildTabItem(icon: Icons.explore_outlined, label: 'Explore', index: 4),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle add action
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.add, color: Colors.white),
        elevation: 2.0,
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildTabItem({required IconData icon, required String label, required int index}) {
    final isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.black : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
