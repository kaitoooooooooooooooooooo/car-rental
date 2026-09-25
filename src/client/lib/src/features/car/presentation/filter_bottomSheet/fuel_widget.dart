import 'package:car_rent_client/src/features/car/presentation/filter_bottomSheet/car_filter_provider.dart';
import 'package:car_rent_client/src/features/car/presentation/filter_bottomSheet/option_chips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FuelWidget extends ConsumerWidget {
  const FuelWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(draftFilterProvider).fuelTypes;
    final notifier = ref.read(draftFilterProvider.notifier);
    final availableCars = ref.watch(
      draftCarsIgnoringProvider(FilterFacet.fuel),
    );
    final options = fuelValues.keys.toList();

    return OptionChips(
      title: 'Fuel Type',
      options: options,
      selected: selected,
      available: options
          .where(
            (fuel) =>
                availableCars == null ||
                availableCars.any((car) => matchesFuel(car, fuel)),
          )
          .toSet(),
      onTap: notifier.toggleFuel,
    );
  }
}
