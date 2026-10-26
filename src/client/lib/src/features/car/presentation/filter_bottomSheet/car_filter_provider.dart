import 'package:car_rent_client/src/features/car/data/remote/car_service.dart';
import 'package:car_rent_client/src/features/car/domain/car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum CarTypeFilter { all, regular, luxury }

enum FilterFacet { carType, price, seating, fuel }

const int luxuryDailyPriceThreshold = 1000;

const Map<String, String> fuelValues = {
  'Petrol': 'essence',
  'Hybrid': 'hybride',
  'Electric': 'electrique',
  'Diesel': 'diesel',
};

const List<String> seatingOptions = ['2', '4', '5-6', '7+'];

String seatingLabel(int places) {
  if (places >= 7) return '7+';
  if (places >= 5) return '5-6';
  if (places >= 4) return '4';
  return '2';
}

bool matchesCarType(Car car, CarTypeFilter type) {
  final isLuxury = car.tarifs.jour > luxuryDailyPriceThreshold;
  switch (type) {
    case CarTypeFilter.all:
      return true;
    case CarTypeFilter.luxury:
      return isLuxury;
    case CarTypeFilter.regular:
      return !isLuxury;
  }
}

bool matchesSeats(Car car, String label) =>
    seatingLabel(car.caracteristiques.places) == label;

bool matchesFuel(Car car, String label) =>
    fuelValues[label] == car.caracteristiques.carburant;

class CarFilterState {
  final String brand;
  final CarTypeFilter carType;
  final double minPrice;
  final double maxPrice;
  final String rentalType;
  final List<DateTime?> selectedDates;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final String location;
  final double minRating;
  final Set<String> seatingCapacities;
  final Set<String> fuelTypes;
  final int resetToken;

  const CarFilterState({
    this.brand = '',
    this.carType = CarTypeFilter.all,
    this.minPrice = 0,
    this.maxPrice = double.infinity,
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
    String? brand,
    CarTypeFilter? carType,
    double? minPrice,
    double? maxPrice,
    String? rentalType,
    List<DateTime?>? selectedDates,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    String? location,
    double? minRating,
    Set<String>? seatingCapacities,
    Set<String>? fuelTypes,
  }) {
    return CarFilterState(
      brand: brand ?? this.brand,
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
}

class CarFilterNotifier extends Notifier<CarFilterState> {
  @override
  CarFilterState build() {
    return const CarFilterState();
  }

  void toggleBrand(String brand) =>
      state = state.copyWith(brand: state.brand == brand ? '' : brand);

  void setCarType(CarTypeFilter type) {
    if (type == state.carType) return;
    state = state.copyWith(
      carType: type,
      minPrice: 0,
      maxPrice: double.infinity,
    );
  }

  void setPriceRange(double min, double max) =>
      state = state.copyWith(minPrice: min, maxPrice: max);

  void setRentalType(String type) {
    state = CarFilterState(
      brand: state.brand,
      carType: state.carType,
      minPrice: state.minPrice,
      maxPrice: state.maxPrice,
      rentalType: type,
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

  void toggleSeating(String seats) {
    final updated = Set<String>.from(state.seatingCapacities);
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

  void replaceWith(CarFilterState filter) => state = filter;
}

final carFilterProvider = NotifierProvider<CarFilterNotifier, CarFilterState>(
  () {
    return CarFilterNotifier();
  },
);

final draftFilterProvider = NotifierProvider<CarFilterNotifier, CarFilterState>(
  () {
    return CarFilterNotifier();
  },
);

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() {
    return '';
  }

  void setQuery(String query) => state = query;
}

final searchQueryProvider = NotifierProvider<SearchQueryNotifier, String>(() {
  return SearchQueryNotifier();
});

final filteredCarsProvider = Provider<AsyncValue<List<Car>>>((ref) {
  final carsAsync = ref.watch(carsListFutureProvider);
  final filter = ref.watch(carFilterProvider);
  final query = ref.watch(searchQueryProvider);

  return carsAsync.whenData((cars) => _applyFilters(cars, filter, query));
});

final draftFilteredCarsProvider = Provider<AsyncValue<List<Car>>>((ref) {
  final carsAsync = ref.watch(carsListFutureProvider);
  final filter = ref.watch(draftFilterProvider);
  final query = ref.watch(searchQueryProvider);

  return carsAsync.whenData((cars) => _applyFilters(cars, filter, query));
});

final draftCarsIgnoringProvider = Provider.family<List<Car>?, FilterFacet>((
  ref,
  facet,
) {
  final cars = ref.watch(carsListFutureProvider).value;
  if (cars == null) return null;
  final filter = ref.watch(draftFilterProvider);
  final query = ref.watch(searchQueryProvider);
  return _applyFilters(cars, filter, query, ignore: facet);
});

List<Car> _applyFilters(
  List<Car> cars,
  CarFilterState filter,
  String query, {
  FilterFacet? ignore,
}) {
  final search = query.trim().toLowerCase();
  final location = filter.location.trim().toLowerCase();

  return cars.where((car) {
    if (search.isNotEmpty &&
        !car.marque.toLowerCase().contains(search) &&
        !car.modele.toLowerCase().contains(search)) {
      return false;
    }

    if (filter.brand.isNotEmpty && car.marque.trim() != filter.brand) {
      return false;
    }

    if (ignore != FilterFacet.carType && !matchesCarType(car, filter.carType)) {
      return false;
    }

    if (ignore != FilterFacet.price &&
        (car.tarifs.jour < filter.minPrice ||
            car.tarifs.jour > filter.maxPrice)) {
      return false;
    }

    if (location.isNotEmpty &&
        !car.localisation.ville.toLowerCase().contains(location) &&
        !car.localisation.canton.toLowerCase().contains(location)) {
      return false;
    }

    if (car.note.moyenne < filter.minRating) return false;

    if (ignore != FilterFacet.seating &&
        filter.seatingCapacities.isNotEmpty &&
        !filter.seatingCapacities.any((seats) => matchesSeats(car, seats))) {
      return false;
    }

    if (ignore != FilterFacet.fuel &&
        filter.fuelTypes.isNotEmpty &&
        !filter.fuelTypes.any((fuel) => matchesFuel(car, fuel))) {
      return false;
    }

    final dates = filter.selectedDates;
    if (filter.rentalType == 'Day' &&
        dates.length > 1 &&
        dates[0] != null &&
        dates[1] != null) {
      final hasConflict = car.indisponibilites.any(
        (i) => dates[0]!.isBefore(i.fin) && dates[1]!.isAfter(i.debut),
      );
      if (hasConflict) return false;
    }

    return true;
  }).toList();
}
