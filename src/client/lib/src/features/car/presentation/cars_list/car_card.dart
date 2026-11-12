import 'package:car_rent_client/src/features/car/domain/car.dart';
import 'package:car_rent_client/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CarCard extends StatelessWidget {
  const CarCard({super.key, required this.car, required this.onTap});

  final Car car;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final title = '${car.marque} ${car.modele}';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.manrope(
                      color: AppColors.textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Icon(
                  Icons.star_rounded,
                  size: 16,
                  color: AppColors.accentLight,
                ),
                const SizedBox(width: 2),
                Text(
                  car.note.moyenne.toString(),
                  style: GoogleFonts.manrope(
                    color: AppColors.textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              spacing: 4,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 14,
                  color: AppColors.textSecondary,
                ),
                Expanded(
                  child: Text(
                    car.localisation.ville,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.manrope(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: car.photos.isEmpty
                    ? const Icon(
                        Icons.directions_car,
                        size: 60,
                        color: AppColors.textMuted,
                      )
                    : Image.asset(car.photos.first.url, fit: BoxFit.contain),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${car.tarifs.devise} ${car.tarifs.jour}',
                          style: GoogleFonts.manrope(
                            color: AppColors.textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(
                          text: ' /day',
                          style: GoogleFonts.manrope(
                            color: AppColors.textSecondary,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 34,
                  height: 34,
                  decoration: const BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_outward_rounded,
                    size: 18,
                    color: AppColors.onAccent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
