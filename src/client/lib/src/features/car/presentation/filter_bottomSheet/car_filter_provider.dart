import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:car_rent_client/src/features/car/data/remote/car_service.dart';
import 'package:car_rent_client/src/features/car/domain/car.dart';
import 'package:flutter_riverpod/legacy.dart';

enum CarTypeFilter { all, regular, luxury }

const Object _unset = Object();

@immutable
class CarFilterState {
  final String? brand;
  final CarTypeFilter carType;
  final double? minPrice;
  final double? maxPrice;
  final String rentalType;
  final List<DateTime?> selectedDates;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final String location;
  final double minRating;
  final Set<int> seatingCapacities;
  final Set<String> fuelTypes;

  final int resetToken;

  const CarFilterState({
    this.brand,
    this.carType = CarTypeFilter.all,
    this.minPrice,
    this.maxPrice,
    this.rentalType = 'Day',
    this.selectedDates = const [],
    this.startTime,
    this.endTime,
    this.location = '',
    this.minRating = 0,
    this.seatingCapacities = const {},
    this.fuelTypes = const {},
    this.resetToken = 0,
  });

  CarFilterState copyWith({
    Object? brand = _unset,
    CarTypeFilter? carType,
    double? minPrice,
    double? maxPrice,
    String? rentalType,
    List<DateTime?>? selectedDates,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    String? location,
    double? minRating,
    Set<int>? seatingCapacities,
    Set<String>? fuelTypes,
  }) {
    return CarFilterState(
      brand: identical(brand, _unset) ? this.brand : brand as String?,
      carType: carType ?? this.carType,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      rentalType: rentalType ?? this.rentalType,
      selectedDates: selectedDates ?? this.selectedDates,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      location: location ?? this.location,
      minRating: minRating ?? this.minRating,
      seatingCapacities: seatingCapacities ?? this.seatingCapacities,
      fuelTypes: fuelTypes ?? this.fuelTypes,
      resetToken: resetToken,
    );
  }

  bool get hasActiveFilters =>
      brand != null ||
      carType != CarTypeFilter.all ||
      minPrice != null ||
      maxPrice != null ||
      location.trim().isNotEmpty ||
      minRating > 0 ||
      seatingCapacities.isNotEmpty ||
      fuelTypes.isNotEmpty ||
      (selectedDates.isNotEmpty && selectedDates.first != null);
}

class CarFilterNotifier extends StateNotifier<CarFilterState> {
  CarFilterNotifier() : super(const CarFilterState());

  void toggleBrand(String brand) =>
      state = state.copyWith(brand: state.brand == brand ? null : brand);

  void setCarType(CarTypeFilter type) => state = state.copyWith(carType: type);

  void setPriceRange(double min, double max) =>
      state = state.copyWith(minPrice: min, maxPrice: max);

  void setRentalType(String type) {
    state = CarFilterState(
      brand: state.brand,
      carType: state.carType,
      minPrice: state.minPrice,
      maxPrice: state.maxPrice,
      rentalType: type,
      selectedDates: const [],
      startTime: null,
      endTime: null,
      location: state.location,
      minRating: state.minRating,
      seatingCapacities: state.seatingCapacities,
      fuelTypes: state.fuelTypes,
      resetToken: state.resetToken,
    );
  }

  void setSelectedDates(List<DateTime?> dates) =>
      state = state.copyWith(selectedDates: dates);

  void setStartTime(TimeOfDay time) => state = state.copyWith(startTime: time);

  void setEndTime(TimeOfDay time) => state = state.copyWith(endTime: time);

  void setLocation(String location) =>
      state = state.copyWith(location: location);

  void setMinRating(double rating) => state = state.copyWith(minRating: rating);

  void toggleSeating(int seats) {
    final updated = Set<int>.from(state.seatingCapacities);
    updated.contains(seats) ? updated.remove(seats) : updated.add(seats);
    state = state.copyWith(seatingCapacities: updated);
  }

  void toggleFuel(String fuel) {
    final updated = Set<String>.from(state.fuelTypes);
    updated.contains(fuel) ? updated.remove(fuel) : updated.add(fuel);
    state = state.copyWith(fuelTypes: updated);
  }

  void clearAll() {
    state = CarFilterState(resetToken: state.resetToken + 1);
  }
}

final carFilterProvider =
    StateNotifierProvider<CarFilterNotifier, CarFilterState>(
      (ref) => CarFilterNotifier(),
    );

final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredCarsProvider = Provider<AsyncValue<List<Car>>>((ref) {
  final carsAsync = ref.watch(carsListFutureProvider);
  final filter = ref.watch(carFilterProvider);
  final query = ref.watch(searchQueryProvider);

  return carsAsync.whenData((cars) => _applyFilters(cars, filter, query));
});

List<Car> _applyFilters(List<Car> cars, CarFilterState filter, String query) {
  final normalizedQuery = query.trim().toLowerCase();

  return cars.where((car) {
    if (normalizedQuery.isNotEmpty) {
      final matchesText =
          car.marque.toLowerCase().contains(normalizedQuery) ||
          car.modele.toLowerCase().contains(normalizedQuery);
      if (!matchesText) return false;
    }

    if (filter.brand != null && car.marque.trim() != filter.brand) {
      return false;
    }

    if (filter.carType != CarTypeFilter.all) {
      const seuilLuxe = 1000;
      final isLuxury = car.tarifs.jour > seuilLuxe;

      if (filter.carType == CarTypeFilter.luxury && !isLuxury) return false;
      if (filter.carType == CarTypeFilter.regular && isLuxury) return false;
    }

    if (filter.minPrice != null && car.tarifs.jour < filter.minPrice!) {
      return false;
    }
    if (filter.maxPrice != null && car.tarifs.jour > filter.maxPrice!) {
      return false;
    }

    if (filter.location.trim().isNotEmpty) {
      final loc = filter.location.trim().toLowerCase();
      final matchesLocation =
          car.localisation.ville.toLowerCase().contains(loc) ||
          car.localisation.canton.toLowerCase().contains(loc);
      if (!matchesLocation) return false;
    }

    if (filter.minRating > 0 && car.note.moyenne < filter.minRating) {
      return false;
    }

    if (filter.seatingCapacities.isNotEmpty &&
        !filter.seatingCapacities.contains(car.caracteristiques.places)) {
      return false;
    }

    if (filter.fuelTypes.isNotEmpty) {
      final carburant = _normalize(car.caracteristiques.carburant);
      final matchesFuel = filter.fuelTypes.any(
        (f) => _fuelMatches(f, carburant),
      );
      if (!matchesFuel) return false;
    }

    if (filter.rentalType == 'Day' &&
        filter.selectedDates.isNotEmpty &&
        filter.selectedDates.first != null &&
        filter.selectedDates.length > 1 &&
        filter.selectedDates[1] != null) {
      final start = filter.selectedDates.first!;
      final end = filter.selectedDates[1]!;
      final hasConflict = car.indisponibilites.any(
        (i) => start.isBefore(i.fin) && end.isAfter(i.debut),
      );
      if (hasConflict) return false;
    }

    return true;
  }).toList();
}

String _normalize(String s) => s
    .toLowerCase()
    .replaceAll('é', 'e')
    .replaceAll('è', 'e')
    .replaceAll('ê', 'e')
    .replaceAll('à', 'a');

bool _fuelMatches(String uiLabel, String normalizedCarburant) {
  switch (uiLabel) {
    case 'Petrol':
      return normalizedCarburant.contains('essence') ||
          normalizedCarburant.contains('petrol');
    case 'Hybrid':
      return normalizedCarburant.contains('hybrid');
    case 'Electric':
      return normalizedCarburant.contains('electr');
    case 'Diesel':
      return normalizedCarburant.contains('diesel');
    default:
      return false;
  }
}
