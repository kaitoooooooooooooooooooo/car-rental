import 'package:car_rent_client/src/constants/colors.dart';
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
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: brands.length,
        itemBuilder: (context, index) {
          final brand = brands[index];
          return _BrandItem(
            brand: brand,
            isSelected: brand == selectedBrand,
            onTap: () =>
                ref.read(carFilterProvider.notifier).toggleBrand(brand),
          );
        },
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

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 88,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surface,
                border: Border.all(
                  color: isSelected ? AppColors.accent : Colors.transparent,
                  width: 2,
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: _brandsWithoutIcon.contains(brand)
                  ? Center(
                      child: Text(
                        brand[0].toUpperCase(),
                        style: GoogleFonts.manrope(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    )
                  : SvgPicture.asset(
                      'assets/brands-icons/$iconName Icon Dark.svg',
                    ),
            ),
            const SizedBox(height: 8),
            Text(
              brand,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: isSelected ? AppColors.accent : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
