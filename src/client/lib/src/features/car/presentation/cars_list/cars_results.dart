import 'package:car_rent_client/src/constants/colors.dart';
import 'package:car_rent_client/src/features/car/presentation/cars_list/car_card.dart';
import 'package:car_rent_client/src/features/car/presentation/filter_bottomSheet/car_filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarsResults extends ConsumerWidget {
  const CarsResults({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredCarsValue = ref.watch(filteredCarsProvider);
    final query = ref.watch(searchQueryProvider).trim();

    return filteredCarsValue.when(
      data: (cars) {
        if (cars.isEmpty) {
          return NoCarsFound(query: query);
        }
        return GridView.builder(
          padding: const EdgeInsets.only(bottom: 90),
          itemCount: cars.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (context, index) {
            final car = cars[index];
            return CarCard(car: car, onTap: () {});
          },
        );
      },
      error: (error, _) => Center(child: Text(error.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class NoCarsFound extends StatelessWidget {
  const NoCarsFound({super.key, this.query = ''});

  static const String title = 'Aucune voiture pour votre recherche';

  final String query;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final subtitle = query.isEmpty
        ? 'Essayez de modifier vos filtres.'
        : 'Aucun résultat pour « $query ». '
              'Essayez un autre mot-clé ou modifiez vos filtres.';

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.search_off_rounded,
              size: 48,
              color: AppColors.textMuted,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
