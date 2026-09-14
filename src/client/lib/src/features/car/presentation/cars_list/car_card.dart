import 'package:car_rent_client/src/constants/colors.dart';
import 'package:car_rent_client/src/features/car/domain/car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class CarCard extends ConsumerWidget {
  const CarCard({super.key, required this.car, required this.onTap});

  final Car car;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photo = car.photos.isEmpty ? null : car.photos.first;
    final asset = photo?.asset;

    // ignore: dead_null_aware_expression, dead_code
    final marque = (car.marque ?? '').toUpperCase();

    // ignore: dead_null_aware_expression
    final model = (car.modele ?? '').toUpperCase();

    final title = '$marque $model'.trim();

    final location = '${car.localisation.ville} ${car.localisation.canton}'
        .trim();

    final price = '${car.tarifs.devise}  ${car.tarifs.jour} / Day';

    return Card(
      margin: EdgeInsets.zero,
      shadowColor: const Color.fromARGB(0, 255, 193, 7),
      clipBehavior: Clip.antiAlias,
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: 185,
          height: 235,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 105,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 2,
                          color: AppColors.borderSubtle,
                        ),
                        left: BorderSide(
                          width: 2,
                          color: AppColors.borderSubtle,
                        ),
                        right: BorderSide(
                          width: 2,
                          color: AppColors.borderSubtle,
                        ),
                      ),
                      color: AppColors.gradientDark,
                      gradient: const RadialGradient(
                        center: Alignment(0.0, 1.45),
                        radius: 1.4,
                        colors: [
                          AppColors.gradientYellow,
                          AppColors.gradientYellow,
                          AppColors.gradientDark,
                        ],
                        stops: [0.0, 0.10, 1.0],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: asset != null && asset.isNotEmpty
                          ? Image.asset(asset, fit: BoxFit.contain)
                          : photo != null
                          ? Image.network(photo.url, fit: BoxFit.contain)
                          : const SizedBox.shrink(),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(12, 7, 12, 7),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    border: Border(
                      bottom: BorderSide(
                        width: 2,
                        color: AppColors.borderSubtle,
                      ),
                      left: BorderSide(width: 2, color: AppColors.borderSubtle),
                      right: BorderSide(
                        width: 2,
                        color: AppColors.borderSubtle,
                      ),
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
                          textStyle: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ),

                      const SizedBox(height: 3),

                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              car.note.moyenne.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.manrope(
                                textStyle: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -0.3,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            IconData(0xf01d4, fontFamily: 'MaterialIcons'),
                            size: 18,
                            color: AppColors.accent,
                          ),
                        ],
                      ),

                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(
                            IconData(0xf193, fontFamily: 'MaterialIcons'),
                            size: 17,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              location,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.manrope(
                                textStyle: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.3,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(
                            IconData(0xf24e, fontFamily: 'MaterialIcons'),
                            size: 17,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              price,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.manrope(
                                textStyle: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.3,
                                ),
                              ),
                            ),
                          ),
                        ],
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
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.manrope(
                              textStyle: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
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
