import 'package:car_rent_client/src/routing/app_router.dart';
import 'package:car_rent_client/src/theme/theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Rivano',
      theme: primaryTheme,
      routerConfig: goRouter,
    );
  }
}
