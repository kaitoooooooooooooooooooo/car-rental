import 'package:car_rent_client/src/theme/theme.dart';
import 'package:car_rent_client/src/features/car/data/remote/car_service.dart';
import 'package:car_rent_client/src/features/car/presentation/filter_bottomSheet/car_filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

const Map<String, String> _iconNames = {
  'Mercedes-Benz': 'MB',
  'Mercedes-Maybach': 'MB',
  'Range Rover': 'Landrover',
  'Land Rover': 'Landrover',
  'Rolls-Royce': 'Rolls Royce',
};

const Set<String> _brandsWithoutIcon = {'Abarth', 'Cupra'};

class BrandCard extends ConsumerWidget {
  const BrandCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carsValue = ref.watch(carsListFutureProvider);
    final selectedBrand = ref.watch(carFilterProvider).brand;

    final brands =
        (carsValue.value ?? [])
            .map((car) => car.marque.trim())
            .where((marque) => marque.isNotEmpty)
            .toSet()
            .toList()
          ..sort();

    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _BrandItem(
            brand: 'All',
            isSelected: selectedBrand.isEmpty,
            onTap: () {
              if (selectedBrand.isNotEmpty) {
                ref.read(carFilterProvider.notifier).toggleBrand(selectedBrand);
              }
            },
          ),
          for (final brand in brands)
            _BrandItem(
              brand: brand,
              isSelected: brand == selectedBrand,
              onTap: () =>
                  ref.read(carFilterProvider.notifier).toggleBrand(brand),
            ),
        ],
      ),
    );
  }
}

class _BrandItem extends StatelessWidget {
  const _BrandItem({
    required this.brand,
    required this.isSelected,
    required this.onTap,
  });

  final String brand;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final iconName = _iconNames[brand] ?? brand;
    final hasIcon = brand != 'All' && !_brandsWithoutIcon.contains(brand);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        margin: const EdgeInsets.only(right: 8),
        padding: EdgeInsets.symmetric(horizontal: hasIcon ? 14 : 22),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accent : AppColors.surface,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: isSelected ? AppColors.accent : AppColors.stoke,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            if (hasIcon)
              SizedBox.square(
                dimension: 20,
                child: SvgPicture.asset(
                  'assets/brands-icons/$iconName Icon Dark.svg',
                ),
              ),
            Text(
              brand,
              style: GoogleFonts.manrope(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.onAccent : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
