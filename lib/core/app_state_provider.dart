import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppState {
  final bool hasCompletedOnboarding;
  final bool isAuthenticated;

  const AppState({
    this.hasCompletedOnboarding = false,
    this.isAuthenticated = false,
  });

  AppState copyWith({
    bool? hasCompletedOnboarding,
    bool? isAuthenticated,
  }) {
    return AppState(
      hasCompletedOnboarding: hasCompletedOnboarding ?? this.hasCompletedOnboarding,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}

class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier() : super(const AppState());

  void completeOnboarding() {
    state = state.copyWith(hasCompletedOnboarding: true);
  }

  void setAuthenticated(bool value) {
    state = state.copyWith(isAuthenticated: value);
  }
}

final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  return AppStateNotifier();
});
