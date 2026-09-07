import 'package:car_rent_client/src/constants/colors.dart';
import 'package:car_rent_client/src/features/car/presentation/filter_bottomSheet/car_filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarTypeToggle extends ConsumerWidget {
  const CarTypeToggle({super.key});

  static const Map<CarTypeFilter, String> _labels = {
    CarTypeFilter.all: 'All Cars',
    CarTypeFilter.regular: 'Regular Cars',
    CarTypeFilter.luxury: 'Luxury Cars',
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(carFilterProvider).carType;
    final notifier = ref.read(carFilterProvider.notifier);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.stoke, width: 1),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _labels.entries.map((entry) {
          final bool isSelected = selected == entry.key;
          return Expanded(
            child: GestureDetector(
              onTap: () => notifier.setCarType(entry.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 14,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF000000)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(46),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    entry.value,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
