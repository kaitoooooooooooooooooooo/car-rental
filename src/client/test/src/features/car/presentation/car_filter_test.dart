import 'package:car_rent_client/src/features/car/presentation/filter_bottomSheet/car_filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CarFilter', () {
    late ProviderContainer container;
    late CarFilterNotifier filtre;

    setUp(() {
      container = ProviderContainer();
      filtre = container.read(carFilterProvider.notifier);
    });

    tearDown(() => container.dispose());

    test('valeurs par defaut', () {
      expect(container.read(carFilterProvider).carType, CarTypeFilter.all);
      expect(container.read(carFilterProvider).minPrice, 0);
      expect(container.read(carFilterProvider).maxPrice, double.infinity);
      expect(container.read(carFilterProvider).rentalType, 'Day');
      expect(container.read(carFilterProvider).location, '');
      expect(container.read(carFilterProvider).minRating, 0);
      expect(container.read(carFilterProvider).seatingCapacities, isEmpty);
      expect(container.read(carFilterProvider).fuelTypes, isEmpty);
    });

    test('filtre type de voiture', () {
      filtre.setCarType(CarTypeFilter.luxury);
      expect(container.read(carFilterProvider).carType, CarTypeFilter.luxury);
    });

    test('filtre prix', () {
      filtre.setPriceRange(100, 500);
      expect(container.read(carFilterProvider).minPrice, 100);
      expect(container.read(carFilterProvider).maxPrice, 500);
    });

    test('filtre type de location', () {
      filtre.setRentalType('Hour');
      expect(container.read(carFilterProvider).rentalType, 'Hour');
    });

    test('filtre dates', () {
      filtre.setSelectedDates([DateTime(2026, 9, 1), DateTime(2026, 9, 5)]);
      expect(container.read(carFilterProvider).selectedDates.length, 2);
    });

    test('filtre heures', () {
      filtre.setStartTime(const TimeOfDay(hour: 8, minute: 0));
      filtre.setEndTime(const TimeOfDay(hour: 18, minute: 30));
      expect(
        container.read(carFilterProvider).startTime,
        const TimeOfDay(hour: 8, minute: 0),
      );
      expect(
        container.read(carFilterProvider).endTime,
        const TimeOfDay(hour: 18, minute: 30),
      );
    });

    test('filtre localisation', () {
      filtre.setLocation('Lausanne');
      expect(container.read(carFilterProvider).location, 'Lausanne');
    });

    test('filtre note', () {
      filtre.setMinRating(4);
      expect(container.read(carFilterProvider).minRating, 4);
    });

    test('filtre places (ajouter puis enlever)', () {
      filtre.toggleSeating('5-6');
      expect(container.read(carFilterProvider).seatingCapacities, {'5-6'});

      filtre.toggleSeating('5-6');
      expect(container.read(carFilterProvider).seatingCapacities, isEmpty);
    });

    test('filtre carburant (ajouter puis enlever)', () {
      filtre.toggleFuel('Electric');
      expect(container.read(carFilterProvider).fuelTypes, {'Electric'});

      filtre.toggleFuel('Electric');
      expect(container.read(carFilterProvider).fuelTypes, isEmpty);
    });

    test('effacer tous les filtres', () {
      filtre.setCarType(CarTypeFilter.regular);
      filtre.setLocation('Geneve');
      filtre.toggleFuel('Diesel');

      filtre.clearAll();

      expect(container.read(carFilterProvider).carType, CarTypeFilter.all);
      expect(container.read(carFilterProvider).location, '');
      expect(container.read(carFilterProvider).fuelTypes, isEmpty);
    });
  });
}
