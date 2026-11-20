import 'package:car_rent_client/src/features/car/presentation/cars_list/car_card.dart';
import 'package:car_rent_client/src/features/car/presentation/favorites/favorites_provider.dart';
import 'package:car_rent_client/src/routing/app_router.dart';
import 'package:car_rent_client/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoriteCarsSection extends ConsumerWidget {
  const FavoriteCarsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteCarsValue = ref.watch(favoriteCarsProvider);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Favorite Cars',
            style: GoogleFonts.manrope(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          favoriteCarsValue.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Text(error.toString()),
            data: (cars) {
              if (cars.isEmpty) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.favorite_border,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'No favorite cars yet. Tap the heart on a car to add it here.',
                          style: GoogleFonts.manrope(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return SizedBox(
                height: 210,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: cars.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final car = cars[index];
                    return SizedBox(
                      width: 170,
                      child: CarCard(
                        car: car,
                        onTap: () => context.goNamed(
                          AppRoute.carDetail.name,
                          pathParameters: {'id': car.id},
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
