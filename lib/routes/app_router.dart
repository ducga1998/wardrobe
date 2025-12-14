import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:boilerplate/features/wardrobe/screens/wardrobe_screen.dart';
import 'package:boilerplate/features/wardrobe/screens/import_screen.dart';
import 'package:boilerplate/features/outfits/screens/outfits_screen.dart';
import 'package:boilerplate/features/outfits/screens/try_on_screen.dart';
import 'package:boilerplate/features/wardrobe/models/wardrobe_item.dart';
import 'package:boilerplate/features/wardrobe/screens/add_item_screen.dart';

// Placeholder screens
import 'package:boilerplate/presentation/home/widgets/home_content.dart';
import 'package:boilerplate/features/auth/presentation/screens/login_screen.dart';
import 'package:boilerplate/features/auth/presentation/screens/register_screen.dart';
import 'package:boilerplate/features/auth/presentation/controllers/auth_controller.dart';
import 'dart:async';


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
  // This notifier listens to auth state changes to trigger router refresh
  final listenable = ValueNotifier<bool>(true);
  
  ref.listen<AsyncValue<bool>>(authControllerProvider, (_, __) {
    // Notify GoRouter to re-evaluate redirect
    listenable.value = !listenable.value;
  });

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    refreshListenable: listenable,
    redirect: (context, state) {
      final authState = ref.read(authControllerProvider);
      
      // If loading or error, we might want to stay put or handle differently.
      // For now, assuming false if not data.
      final isLoggedIn = authState.valueOrNull ?? false;
      
      final isLoggingIn = state.uri.path == '/login';
      final isRegistering = state.uri.path == '/register';

      if (!isLoggedIn) {
        if (isLoggingIn || isRegistering) return null;
        return '/login';
      }

      if (isLoggingIn || isRegistering) return '/';
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/add-item',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const AddItemScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    title: const Text('Home'),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.logout),
                        onPressed: () {
                          ref.read(authControllerProvider.notifier).logout();
                        },
                      ),
                    ],
                  ),
                  body: const HomeContent(),
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
