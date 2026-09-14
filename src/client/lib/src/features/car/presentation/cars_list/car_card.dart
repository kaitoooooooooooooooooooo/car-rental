import 'package:car_rent_client/src/constants/app_sizes.dart';
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

    return Card(
      shadowColor: const Color.fromARGB(0, 255, 193, 7),

      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: 185,
          height: 235,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(width: 2.0, color: AppColors.borderSubtle),
                            left: BorderSide(
                              width: 2.0,
                              color: AppColors.borderSubtle,
                            ),
                            right: BorderSide(
                              width: 2.0,
                              color: AppColors.borderSubtle,
                            ),
                          ),
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.gradientDark,
                              AppColors.gradientYellow,
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: asset != null && asset.isNotEmpty
                              ? Image.asset(asset, fit: BoxFit.contain)
                              : photo != null
                              ? Image.network(photo.url, fit: BoxFit.contain)
                              : const SizedBox.shrink(),
                        ),
                      ),
                      Positioned(
                        top: 6,
                        right: 6,
                        child: RawMaterialButton(
                          splashColor: AppColors.accentSoft,
                          onPressed: () {},
                          elevation: 2.0,
                          fillColor: AppColors.surface,
                          constraints: const BoxConstraints(
                            minWidth: 0.0,
                            minHeight: 0.0,
                          ),
                          padding: const EdgeInsets.all(6.0),
                          shape: const CircleBorder(),
                          child: Icon(
                            Icons.favorite_border_outlined,
                            size: 16.0,
                            color: AppColors.icon,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    left: 15,
                    top: 10,
                    right: 15,
                    bottom: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    border: Border(
                      bottom: BorderSide(width: 2.0, color: AppColors.borderSubtle),
                      left: BorderSide(width: 2.0, color: AppColors.borderSubtle),
                      right: BorderSide(width: 2.0, color: AppColors.borderSubtle),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ('$marque $model').toUpperCase(),
                        style: GoogleFonts.manrope(
                          textStyle: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.3,
                          ),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      gapH8,
                      Row(
                        children: [
                          Text(
                            car.note.moyenne.toString(),
                            style: GoogleFonts.manrope(
                              textStyle: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.3,
                              ),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(width: 5),
                          const Icon(
                            IconData(0xf01d4, fontFamily: 'MaterialIcons'),
                            size: 20,
                            color: AppColors.accent,
                          ),
                        ],
                      ),
                      gapH4,
                      Row(
                        children: [
                          const Icon(
                            IconData(0xf193, fontFamily: 'MaterialIcons'),
                            size: 18,
                            color: AppColors.textSecondary,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "${car.localisation.ville} ${car.localisation.canton}",
                            style: GoogleFonts.manrope(
                              textStyle: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.3,
                              ),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      gapH4,
                      Row(
                        children: [
                          const Icon(
                            IconData(0xf24e, fontFamily: 'MaterialIcons'),
                            size: 18,
                            color: AppColors.textSecondary,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "${car.tarifs.devise}  ${car.tarifs.jour} / Day",
                            style: GoogleFonts.manrope(
                              textStyle: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.3,
                              ),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
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
