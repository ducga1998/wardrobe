import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:boilerplate/features/wardrobe/models/wardrobe_item.dart';

class OutfitScore {
  final List<WardrobeItem> items;
  final int score;
  final String reason;

  OutfitScore({required this.items, required this.score, required this.reason});
}

class ScoringService {
  // Deterministic scoring engine
  List<OutfitScore> suggestOutfits(List<WardrobeItem> wardrobe, {String? context}) {
    final tops = wardrobe.where((i) => i.type == WardrobeItemType.top).toList();
    final bottoms = wardrobe.where((i) => i.type == WardrobeItemType.bottom).toList();
    
    List<OutfitScore> suggestions = [];

    for (var top in tops) {
      for (var bottom in bottoms) {
        int score = 0;
        String reason = "Basic match";

        // Simple color matching heuristic (mock)
        if (top.colors.isNotEmpty && bottom.colors.isNotEmpty) {
           if (top.colors.first == bottom.colors.first) {
             score += 10;
             reason = "Monochrome match";
           }
        }

        suggestions.add(OutfitScore(items: [top, bottom], score: score, reason: reason));
      }
    }

    // Sort by score descending
    suggestions.sort((a, b) => b.score.compareTo(a.score));
    return suggestions;
  }
}

final scoringServiceProvider = Provider<ScoringService>((ref) {
  return ScoringService();
});
