import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:boilerplate/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:boilerplate/features/auth/providers/auth_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setPreferredOrientations();
  
  final sharedPrefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWith((ref) => sharedPrefs),
      ],
      child: const OutfitApp(),
    ),
  );
}

Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
