import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => {};

  void toggle(String carId) {
    if (state.contains(carId)) {
      state = {...state}..remove(carId);
    } else {
      state = {...state, carId};
    }
  }

  bool isFavorite(String carId) => state.contains(carId);
}

final favoritesProvider = NotifierProvider<FavoritesNotifier, Set<String>>(() {
  return FavoritesNotifier();
});
