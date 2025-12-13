import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:boilerplate/services/image_service.dart';

enum TryOnStatus { idle, preparing, segmenting, compositing, ready, failed }

class TryOnState {
  final TryOnStatus status;
  final String? selfiePath;
  final String? compositePath;
  final String? error;

  const TryOnState({
    this.status = TryOnStatus.idle,
    this.selfiePath,
    this.compositePath,
    this.error,
  });

  TryOnState copyWith({
    TryOnStatus? status,
    String? selfiePath,
    String? compositePath,
    String? error,
  }) {
    return TryOnState(
      status: status ?? this.status,
      selfiePath: selfiePath ?? this.selfiePath,
      compositePath: compositePath ?? this.compositePath,
      error: error ?? this.error,
    );
  }
}

class TryOnController extends StateNotifier<TryOnState> {
  final ImageService _imageService;

  TryOnController(this._imageService) : super(const TryOnState());

  Future<void> startTryOn(String selfiePath, List<String> garmentPaths) async {
    try {
      state = state.copyWith(status: TryOnStatus.preparing, selfiePath: selfiePath);
      
      // Simulate preparing
      await Future.delayed(const Duration(milliseconds: 500));

      state = state.copyWith(status: TryOnStatus.segmenting);
      // In a real app, we'd segment the selfie here if needed
      await Future.delayed(const Duration(milliseconds: 500));

      state = state.copyWith(status: TryOnStatus.compositing);
      final compositePath = await _imageService.composeOutfit(selfiePath, garmentPaths);

      state = state.copyWith(
        status: TryOnStatus.ready,
        compositePath: compositePath,
      );
    } catch (e) {
      state = state.copyWith(
        status: TryOnStatus.failed,
        error: e.toString(),
      );
    }
  }

  void reset() {
    state = const TryOnState();
  }
}

final tryOnControllerProvider = StateNotifierProvider<TryOnController, TryOnState>((ref) {
  final imageService = ref.watch(imageServiceProvider);
  return TryOnController(imageService);
});
