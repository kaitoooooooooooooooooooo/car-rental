import 'package:car_rent_client/src/features/car/presentation/filter_bottomSheet/car_filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CarFilter', () {
    late CarFilterNotifier filtre;

    setUp(() {
      filtre = CarFilterNotifier();
    });

    test('valeurs par defaut', () {
      expect(filtre.state.carType, CarTypeFilter.all);
      expect(filtre.state.minPrice, 0);
      expect(filtre.state.maxPrice, double.infinity);
      expect(filtre.state.rentalType, 'Day');
      expect(filtre.state.location, '');
      expect(filtre.state.minRating, 0);
      expect(filtre.state.seatingCapacities, isEmpty);
      expect(filtre.state.fuelTypes, isEmpty);
    });

    test('filtre type de voiture', () {
      filtre.setCarType(CarTypeFilter.luxury);
      expect(filtre.state.carType, CarTypeFilter.luxury);
    });

    test('filtre prix', () {
      filtre.setPriceRange(100, 500);
      expect(filtre.state.minPrice, 100);
      expect(filtre.state.maxPrice, 500);
    });

    test('filtre type de location', () {
      filtre.setRentalType('Hour');
      expect(filtre.state.rentalType, 'Hour');
    });

    test('filtre dates', () {
      filtre.setSelectedDates([DateTime(2026, 9, 1), DateTime(2026, 9, 5)]);
      expect(filtre.state.selectedDates.length, 2);
    });

    test('filtre heures', () {
      filtre.setStartTime(const TimeOfDay(hour: 8, minute: 0));
      filtre.setEndTime(const TimeOfDay(hour: 18, minute: 30));
      expect(filtre.state.startTime, const TimeOfDay(hour: 8, minute: 0));
      expect(filtre.state.endTime, const TimeOfDay(hour: 18, minute: 30));
    });

    test('filtre localisation', () {
      filtre.setLocation('Lausanne');
      expect(filtre.state.location, 'Lausanne');
    });

    test('filtre note', () {
      filtre.setMinRating(4);
      expect(filtre.state.minRating, 4);
    });

    test('filtre places (ajouter puis enlever)', () {
      filtre.toggleSeating('5-6');
      expect(filtre.state.seatingCapacities, {'5-6'});

      filtre.toggleSeating('5-6');
      expect(filtre.state.seatingCapacities, isEmpty);
    });

    test('filtre carburant (ajouter puis enlever)', () {
      filtre.toggleFuel('Electric');
      expect(filtre.state.fuelTypes, {'Electric'});

      filtre.toggleFuel('Electric');
      expect(filtre.state.fuelTypes, isEmpty);
    });

    test('effacer tous les filtres', () {
      filtre.setCarType(CarTypeFilter.regular);
      filtre.setLocation('Geneve');
      filtre.toggleFuel('Diesel');

      filtre.clearAll();

      expect(filtre.state.carType, CarTypeFilter.all);
      expect(filtre.state.location, '');
      expect(filtre.state.fuelTypes, isEmpty);
    });
  });
}
