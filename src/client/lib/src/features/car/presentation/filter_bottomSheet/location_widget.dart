import 'package:car_rent_client/src/theme/theme.dart';
import 'package:car_rent_client/src/features/car/presentation/filter_bottomSheet/car_filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationWidget extends ConsumerStatefulWidget {
  const LocationWidget({super.key});

  @override
  ConsumerState<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends ConsumerState<LocationWidget> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: ref.read(draftFilterProvider).location,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<CarFilterState>(draftFilterProvider, (previous, next) {
      if (next.location != _searchController.text) {
        _searchController.text = next.location;
      }
    });

    final location = ref.watch(draftFilterProvider).location;

    return Expanded(
      child: SearchBar(
        controller: _searchController,
        onChanged: (value) =>
            ref.read(draftFilterProvider.notifier).setLocation(value),
        hintText: 'Choose your location',
        textStyle: WidgetStatePropertyAll(
          GoogleFonts.manrope(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        hintStyle: WidgetStatePropertyAll(
          GoogleFonts.manrope(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
          ),
        ),
        leading: const Icon(
          Icons.location_on_outlined,
          color: AppColors.textSecondary,
          size: 22,
        ),
        padding: const WidgetStatePropertyAll<EdgeInsets>(
          EdgeInsets.symmetric(horizontal: 16),
        ),
        backgroundColor: WidgetStatePropertyAll(AppColors.surface),
        elevation: const WidgetStatePropertyAll(0),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(color: AppColors.stoke),
          ),
        ),
        trailing: [
          if (location.isNotEmpty)
            IconButton(
              icon: const Icon(
                Icons.clear,
                color: AppColors.textSecondary,
                size: 20,
              ),
              onPressed: () {
                _searchController.clear();
                ref.read(draftFilterProvider.notifier).setLocation('');
              },
            ),
        ],
      ),
    );
  }
}
