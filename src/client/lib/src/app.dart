import 'package:car_rent_client/src/features/car/presentation/cars_list/cars_list_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Car Rental',
      home: const CarsListScreen(),
    );
  }
}
