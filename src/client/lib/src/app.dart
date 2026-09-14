import 'package:car_rent_client/src/constants/colors.dart';
import 'package:car_rent_client/src/features/car/presentation/cars_list/car_list_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Car Rental',

      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        canvasColor: AppColors.surfaceLow,
        dividerColor: AppColors.borderSubtle,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.accent,
          onPrimary: AppColors.onAccent,
          secondary: AppColors.accent,
          onSecondary: AppColors.onAccent,
          surface: AppColors.surface,
          onSurface: AppColors.textPrimary,
          onSurfaceVariant: AppColors.textSecondary,
          surfaceContainerLow: AppColors.surfaceLow,
          outline: AppColors.stoke,
          outlineVariant: AppColors.borderSubtle,
          error: AppColors.error,
          onError: AppColors.onAccent,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.accent,
          selectionColor: AppColors.accentSoft,
          selectionHandleColor: AppColors.accent,
        ),
      ),

      home: const CarsListScreen(),
    );
  }
}
