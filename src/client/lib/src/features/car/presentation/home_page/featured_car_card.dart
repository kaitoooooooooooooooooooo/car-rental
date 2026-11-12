import 'package:car_rent_client/src/utils/car_labels.dart';
import 'package:car_rent_client/src/features/car/domain/car.dart';
import 'package:car_rent_client/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeaturedCarCard extends StatelessWidget {
  const FeaturedCarCard({super.key, required this.car, required this.onTap});

  final Car car;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final specs = car.caracteristiques;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 210,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              top: 40,
              bottom: 16,
              child: car.photos.isEmpty
                  ? const Icon(
                      Icons.directions_car,
                      size: 100,
                      color: AppColors.textMuted,
                    )
                  : Image.asset(car.photos.first.url, fit: BoxFit.contain),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${car.marque} ${car.modele}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.manrope(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${car.tarifs.devise} ${car.tarifs.jour} / day',
                        style: GoogleFonts.manrope(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 6,
                  children: [
                    SpecBadge(
                      icon: Icons.speed_rounded,
                      label: '${specs.puissanceCh} HP',
                    ),
                    SpecBadge(
                      icon: Icons.local_gas_station_outlined,
                      label: carLabel(specs.carburant),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLow,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  spacing: 6,
                  children: [
                    const Icon(
                      Icons.my_location_rounded,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                    Text(
                      car.localisation.ville,
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SpecBadge extends StatelessWidget {
  const SpecBadge({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceLow,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 6,
        children: [
          Icon(icon, size: 14, color: AppColors.textSecondary),
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 12,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
