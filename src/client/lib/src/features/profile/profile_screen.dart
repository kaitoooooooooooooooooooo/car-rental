import 'package:car_rent_client/src/theme/theme.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Text(
          'SA ARRIVE BIENTOT',
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
    );
  }
}
