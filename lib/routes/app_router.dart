import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:boilerplate/features/wardrobe/screens/wardrobe_screen.dart';
import 'package:boilerplate/features/wardrobe/screens/import_screen.dart';
import 'package:boilerplate/features/outfits/screens/outfits_screen.dart';
import 'package:boilerplate/features/outfits/screens/try_on_screen.dart';
import 'package:boilerplate/features/wardrobe/models/wardrobe_item.dart';

// Placeholder screens
import 'package:boilerplate/presentation/home/widgets/home_content.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Settings')));
}

class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.checkroom), label: 'Wardrobe'),
          BottomNavigationBarItem(icon: Icon(Icons.style), label: 'Outfits'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => _onTap(context, index),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

final rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const Scaffold(
                  backgroundColor: Colors.white,
                  body: HomeContent(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/wardrobe',
                builder: (context, state) => const WardrobeScreen(),
                routes: [
                  GoRoute(
                    path: 'import',
                    parentNavigatorKey: rootNavigatorKey, // Use the defined root key
                    builder: (context, state) => const ImportScreen(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/outfits',
                builder: (context, state) => const OutfitsScreen(),
                routes: [
                  GoRoute(
                    path: 'try-on',
                    parentNavigatorKey: rootNavigatorKey, // Use the defined root key
                    builder: (context, state) {
                      final items = state.extra as List<WardrobeItem>;
                      return TryOnScreen(selectedItems: items);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
