import 'package:car_rent_client/src/features/car/presentation/favorites/favorites_provider.dart';
import 'package:car_rent_client/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteButton extends ConsumerWidget {
  const FavoriteButton({super.key, required this.carId, this.size = 20});

  final String carId;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(
      favoritesProvider.select((favs) => favs.contains(carId)),
    );

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surfaceLow,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        iconSize: size,
        onPressed: () {
          ref.read(favoritesProvider.notifier).toggle(carId);
        },
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? AppColors.error : AppColors.textPrimary,
        ),
      ),
    );
  }
}
