import 'package:car_rent_client/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  final double coverHeight = 220;
  final double profileHeight = 128;

  Widget buildCoverImage() {
    return Image.asset(
      'assets/images/app/banner.jpg',
      width: double.infinity,
      height: coverHeight,
      fit: BoxFit.cover,
    );
  }

  Widget buildProfileImage() {
    return CircleAvatar(
      radius: profileHeight / 2 + 4,
      backgroundColor: AppColors.background,
      child: CircleAvatar(
        radius: profileHeight / 2,
        backgroundImage: const AssetImage('assets/images/app/profile.jpg'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final top = coverHeight - profileHeight / 2;

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: profileHeight / 2),
              child: buildCoverImage(),
            ),
            Positioned(top: top, child: buildProfileImage()),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Tom',
          style: GoogleFonts.manrope(
            color: AppColors.textPrimary,
            fontSize: 26,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
