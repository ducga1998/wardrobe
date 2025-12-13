
import 'package:boilerplate/features/auth/providers/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthState {
  final bool isLoggedIn;
  final bool isLoading;
  final String? error;

  AuthState({
    this.isLoggedIn = false,
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    bool? isLoggedIn,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
      error: error, // Nullable, so we can clear error by passing null but passing nothing keeps current? 
                    // To clear error we might need a specific mechanism or just pass null explicitly if we handle copyWith carefully.
                    // For simplicity, if passed, it updates. If not passed (null), we'll assume we keep it? 
                    // Standard copyWith:
                    // error: error ?? this.error (if we want to keep it)
                    // But we often want to clear it. Let's stick to simple copyWith for now.
      // actually better to separate "loading/error" from the persistent "isLoggedIn".
    );
  }
}

class AuthController extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    final prefs = ref.watch(sharedPreferenceHelperProvider);
    return prefs.isLoggedIn;
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(authRepositoryProvider);
      await repo.login(email, password);
      
      final prefs = ref.read(sharedPreferenceHelperProvider);
      await prefs.saveIsLoggedIn(true);

      state = const AsyncValue.data(true);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> register(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(authRepositoryProvider);
      await repo.register(email, password);
      // Typically register doesn't log you in immediately or maybe it does?
      // Following previous pattern checking RegisterCubit: it returned success then navigated back to login.
      // So here we won't set isLoggedIn = true.
      state = const AsyncValue.data(false);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> logout() async {
     state = const AsyncValue.loading();
    try {
      final repo = ref.read(authRepositoryProvider);
      await repo.logout();

      final prefs = ref.read(sharedPreferenceHelperProvider);
      await prefs.saveIsLoggedIn(false); // or removeAuthToken

      state = const AsyncValue.data(false);
    } catch (e) {
       // Even if logout API fails, we should probably clear local state
      final prefs = ref.read(sharedPreferenceHelperProvider);
      await prefs.saveIsLoggedIn(false);
      state = const AsyncValue.data(false);
    }
  }
}

final authControllerProvider = AsyncNotifierProvider<AuthController, bool>(AuthController.new);
