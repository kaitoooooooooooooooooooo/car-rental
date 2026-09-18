// ignore: file_names
import 'package:car_rent_client/src/constants/app_sizes.dart';
import 'package:car_rent_client/src/constants/colors.dart';
import 'package:car_rent_client/src/features/car/presentation/filter_bottomSheet/car_filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class SitingWidget extends ConsumerWidget {
  const SitingWidget({super.key});

  static const List<int> options = seatRanges;

  static String label(int rangeStart) {
    if (rangeStart >= seatsPlusThreshold) return '$rangeStart+';
    if (rangeStart == 2) return '2';
    return '$rangeStart-${rangeStart + 1}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(draftFilterProvider).seatingCapacities;
    final notifier = ref.read(draftFilterProvider.notifier);
    final availableCars = ref.watch(
      draftCarsIgnoringProvider(FilterFacet.seating),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Siting Capacity',
          style: GoogleFonts.manrope(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        gapH8,
        Row(
          children: options.map((option) {
            final bool isSelected = selected.contains(option);
            final bool isAvailable =
                isSelected ||
                availableCars == null ||
                availableCars.any((car) => matchesSeats(car, option));
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: GestureDetector(
                  onTap: isAvailable
                      ? () => notifier.toggleSeating(option)
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 280),
                      opacity: isAvailable ? 1 : 0.35,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 280),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.accent
                              : Colors.transparent,
                          border: Border.all(color: AppColors.stoke, width: 1),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            label(option),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? AppColors.onAccent
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
