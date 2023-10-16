import 'package:hooks_riverpod/hooks_riverpod.dart';

class SlideIndexNotifier extends StateNotifier<int> {
  SlideIndexNotifier() : super(0);

  void increment() {
    state > 1 ? state = state : state += 1;
  }

  void decrement() {
    state == 0 ? state = state : state -= 1;
  }
}

final slideIndexProvider =
    StateNotifierProvider<SlideIndexNotifier, int>((ref) {
  return SlideIndexNotifier();
});
