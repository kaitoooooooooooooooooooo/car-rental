import 'package:car_rent_client/src/features/car/data/remote/car_service.dart';
import 'package:car_rent_client/src/features/car/domain/car.dart';
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

final favoriteCarsProvider = Provider<AsyncValue<List<Car>>>((ref) {
  final favorites = ref.watch(favoritesProvider);
  final carsValue = ref.watch(carsListFutureProvider);
  return carsValue.whenData(
    (cars) => cars.where((car) => favorites.contains(car.id)).toList(),
  );
});
