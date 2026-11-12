import 'package:car_rent_client/src/features/car/domain/note.dart';
import 'package:car_rent_client/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CarReviewsCard extends StatelessWidget {
  const CarReviewsCard({
    super.key,
    required this.note,
    required this.nombreLocations,
  });

  final Note note;
  final int nombreLocations;

  Widget _buildStar(int index) {
    final double starValue = index + 1;
    IconData icon;

    if (note.moyenne >= starValue) {
      icon = Icons.star_rounded;
    } else if (note.moyenne >= starValue - 0.5) {
      icon = Icons.star_half_rounded;
    } else {
      icon = Icons.star_outline_rounded;
    }

    return Icon(icon, size: 20, color: AppColors.accentLight);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        children: [
          Text(
            note.moyenne.toStringAsFixed(1),
            style: GoogleFonts.manrope(
              color: AppColors.textPrimary,
              fontSize: 36,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: List.generate(5, (index) => _buildStar(index))),
                const SizedBox(height: 4),
                Text(
                  '${note.nombre} reviews · $nombreLocations rentals',
                  style: GoogleFonts.manrope(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
