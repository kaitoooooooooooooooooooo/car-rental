import 'package:car_rent_client/src/features/car/data/remote/car_service.dart';
import 'package:car_rent_client/src/features/car/presentation/home_page/featured_car_card.dart';
import 'package:car_rent_client/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RecommendedCarsCard extends ConsumerWidget {
  const RecommendedCarsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featuredCarsValue = ref.watch(featuredCarsListFutureProvider);

    return featuredCarsValue.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Text(error.toString()),
      data: (cars) => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: FeaturedCarCard(
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
  }
}
