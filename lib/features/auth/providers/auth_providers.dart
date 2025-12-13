
import 'package:boilerplate/core/data/network/dio/configs/dio_configs.dart';
import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/apis/auth/auth_api.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/data/repository/auth/auth_repository_impl.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/repository/auth/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Shared Prefs
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(); // Overridden in main
});

final sharedPreferenceHelperProvider = Provider<SharedPreferenceHelper>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return SharedPreferenceHelper(prefs);
});

// Network
final dioConfigsProvider = Provider<DioConfigs>((ref) {
  return const DioConfigs(
    baseUrl: Endpoints.baseUrl,
    connectionTimeout: Endpoints.connectionTimeout,
    receiveTimeout: Endpoints.receiveTimeout,
  );
});

final dioClientProvider = Provider<DioClient>((ref) {
  final config = ref.watch(dioConfigsProvider);
  return DioClient(dioConfigs: config);
});

final restClientProvider = Provider<RestClient>((ref) {
  return RestClient();
});

// API
final authApiProvider = Provider<AuthApi>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  final restClient = ref.watch(restClientProvider);
  return AuthApi(dioClient, restClient);
});

// Repository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authApi = ref.watch(authApiProvider);
  final sharedPrefs = ref.watch(sharedPreferenceHelperProvider);
  return AuthRepositoryImpl(authApi, sharedPrefs);
});
