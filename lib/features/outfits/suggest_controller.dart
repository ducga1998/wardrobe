import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:boilerplate/features/wardrobe/wardrobe_controller.dart';
import 'package:boilerplate/services/scoring_service.dart';

class SuggestController extends StateNotifier<AsyncValue<List<OutfitScore>>> {
  final ScoringService _scoringService;
  final Ref _ref;

  SuggestController(this._scoringService, this._ref) : super(const AsyncValue.loading()) {
    generateSuggestions();
  }

  Future<void> generateSuggestions() async {
    try {
      state = const AsyncValue.loading();
      
      // Get current wardrobe items
      final wardrobeAsyncValue = _ref.read(wardrobeControllerProvider);
      
      // Check if data is available
      if (wardrobeAsyncValue.hasValue) {
        final items = wardrobeAsyncValue.value!;
        // Generate suggestions
        final suggestions = _scoringService.suggestOutfits(items);
        state = AsyncValue.data(suggestions);
      } else {
        // If no data or loading, just return empty or keep loading
        state = const AsyncValue.data([]);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final suggestControllerProvider = StateNotifierProvider<SuggestController, AsyncValue<List<OutfitScore>>>((ref) {
  final scoringService = ref.watch(scoringServiceProvider);
  return SuggestController(scoringService, ref);
});
