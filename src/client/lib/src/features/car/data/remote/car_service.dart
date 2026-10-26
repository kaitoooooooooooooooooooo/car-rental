import 'dart:convert';

import 'package:car_rent_client/src/features/car/domain/car.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

const url = String.fromEnvironment(
  'API_URL',
  defaultValue: 'http://127.0.0.1:3000',
);

class CarService {
  Future<List<Car>> fetchCarsList() async {
    final cars = <Car>[];
    try {
      final parsedUrl = Uri.parse('$url/cars');
      final response = await http.get(parsedUrl);
      final statusCode = response.statusCode;

      if (statusCode != 200) {
        final message = 'Erreur survenue';
        throw Exception(message);
      }

      final data = jsonDecode(response.body);

      data.forEach((car) {
        cars.add(Car.fromJson(car));
      });

      return cars;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Car>> fetchFeaturedCarsList() async {
    final featuredCars = <Car>[];
    try {
      final parsedUrl = Uri.parse('$url/cars/featured');
      final response = await http.get(parsedUrl);
      final statusCode = response.statusCode;

      if (statusCode != 200) {
        final message = 'Erreur survenue';
        throw Exception(message);
      }

      final data = jsonDecode(response.body);

      data.forEach((car) {
        featuredCars.add(Car.fromJson(car));
      });

      return featuredCars;
    } catch (e) {
      rethrow;
    }
  }
}

final carsRepositoryProvider = Provider<CarService>((ref) {
  return CarService();
});

final carsListFutureProvider = FutureProvider<List<Car>>((ref) {
  final carsRepository = ref.watch(carsRepositoryProvider);
  return carsRepository.fetchCarsList();
});

final featuredCarsListFutureProvider = FutureProvider<List<Car>>((ref) {
  final featuredCarsRepository = ref.watch(carsRepositoryProvider);
  return featuredCarsRepository.fetchFeaturedCarsList();
});
