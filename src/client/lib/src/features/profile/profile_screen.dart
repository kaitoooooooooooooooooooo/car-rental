import 'package:car_rent_client/src/features/profile/profile_header.dart';
import 'package:car_rent_client/src/features/profile/profile_menu.dart';
import 'package:car_rent_client/src/theme/theme.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListView(
        padding: EdgeInsets.zero,
        children: const [ProfileHeader(), ProfileMenu()],
      ),
    );
  }
}
