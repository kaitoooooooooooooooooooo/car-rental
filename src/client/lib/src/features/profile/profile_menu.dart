import 'package:car_rent_client/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(
        title,
        style: GoogleFonts.manrope(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget buildTile(IconData icon, String label) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: AppColors.textPrimary,
              child: Icon(icon, size: 22, color: AppColors.surfaceLow),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.manrope(
                  color: AppColors.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionTitle('General'),
          buildTile(Icons.favorite_border, 'Favorite Cars'),
          buildTile(Icons.history, 'Previous Rent'),
          buildTile(Icons.notifications_none, 'Notification'),
          buildTile(Icons.handshake_outlined, 'Connected to Rivano Partnerships'),
          buildSectionTitle('Support'),
          buildTile(Icons.settings_outlined, 'Appearance Settings'),
          buildTile(Icons.translate, 'Languages'),
          buildTile(Icons.person_add_alt, 'Invite Friends'),
          buildTile(Icons.headset_mic_outlined, 'Help Support'),
          buildTile(Icons.logout, 'Log out'),
        ],
      ),
    );
  }
}
