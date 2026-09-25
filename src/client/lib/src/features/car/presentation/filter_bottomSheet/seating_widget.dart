import 'package:car_rent_client/src/features/car/presentation/filter_bottomSheet/car_filter_provider.dart';
import 'package:car_rent_client/src/features/car/presentation/filter_bottomSheet/option_chips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SeatingWidget extends ConsumerWidget {
  const SeatingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(draftFilterProvider).seatingCapacities;
    final notifier = ref.read(draftFilterProvider.notifier);
    final availableCars = ref.watch(
      draftCarsIgnoringProvider(FilterFacet.seating),
    );

    return OptionChips(
      title: 'Seating Capacity',
      options: seatingOptions,
      selected: selected,
      available: seatingOptions
          .where(
            (seats) =>
                availableCars == null ||
                availableCars.any((car) => matchesSeats(car, seats)),
          )
          .toSet(),
      onTap: notifier.toggleSeating,
    );
  }
}
