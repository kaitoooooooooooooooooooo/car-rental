import 'package:car_rent_client/src/app_shell.dart';
import 'package:car_rent_client/src/theme/theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Car Rental',
      theme: primaryTheme,
      home: const AppShell(),
    );
  }
}
