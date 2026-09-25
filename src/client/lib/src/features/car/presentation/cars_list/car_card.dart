import 'package:car_rent_client/src/features/car/domain/car.dart';
import 'package:car_rent_client/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _border = BorderSide(width: 2, color: AppColors.borderSubtle);

class CarCard extends StatelessWidget {
  const CarCard({super.key, required this.car, required this.onTap});

  final Car car;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final title = '${car.marque} ${car.modele}'.toUpperCase();
    final location = '${car.localisation.ville} ${car.localisation.canton}';
    final price = '${car.tarifs.devise}  ${car.tarifs.jour} / Day';

    return Card(
      margin: EdgeInsets.zero,
      shadowColor: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: 185,
          height: 235,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 105,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  border: Border(top: _border, left: _border, right: _border),
                  gradient: RadialGradient(
                    center: Alignment(0.0, 1.45),
                    radius: 1.4,
                    colors: [
                      AppColors.gradientGreen,
                      AppColors.gradientGreen,
                      AppColors.gradientDark,
                    ],
                    stops: [0.0, 0.10, 1.0],
                  ),
                ),
                child: car.photos.isEmpty
                    ? null
                    : Image.asset(car.photos.first.url, fit: BoxFit.contain),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(12, 7, 12, 7),
                  decoration: const BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    border: Border(
                      bottom: _border,
                      left: _border,
                      right: _border,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.manrope(
                          color: AppColors.textPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Text(
                            car.note.moyenne.toString(),
                            style: GoogleFonts.manrope(
                              color: AppColors.textSecondary,
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.star_rounded,
                            size: 18,
                            color: AppColors.accent,
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      _InfoRow(
                        icon: Icons.location_on_outlined,
                        text: location,
                        fontWeight: FontWeight.w400,
                      ),
                      const SizedBox(height: 2),
                      _InfoRow(
                        icon: Icons.paid_outlined,
                        text: price,
                        fontWeight: FontWeight.w500,
                      ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        height: 30,
                        child: FilledButton(
                          onPressed: () {},
                          style: FilledButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          child: Text(
                            'Book now',
                            style: GoogleFonts.manrope(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.text,
    required this.fontWeight,
  });

  final IconData icon;
  final String text;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 17, color: AppColors.textSecondary),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.manrope(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontWeight: fontWeight,
              letterSpacing: -0.3,
            ),
          ),
        ),
      ],
    );
  }
}
