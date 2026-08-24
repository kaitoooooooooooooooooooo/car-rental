import 'dart:convert';

import 'package:car_rent_client/src/features/car/domain/car.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class CarService {
  static const url = 'http://127.0.0.1:3000';

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
}

final carsRepositoryProvider = Provider<CarService>((ref) {
  return CarService();
});

final carsListFutureProvider = FutureProvider<List<Car>>((ref) {
  final carsRepository = ref.watch(carsRepositoryProvider);
  return carsRepository.fetchCarsList();
});
