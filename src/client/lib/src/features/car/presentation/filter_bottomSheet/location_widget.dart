import 'package:car_rent_client/src/constants/colors.dart';
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
  late final SearchController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = SearchController();
    _searchController.text = ref.read(carFilterProvider).location;
    _searchController.addListener(() {
      ref.read(carFilterProvider.notifier).setLocation(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Resynchronise le champ si le filtre est modifié ailleurs (ex: Clear All).
    ref.listen<CarFilterState>(carFilterProvider, (previous, next) {
      if (next.location != _searchController.text) {
        _searchController.text = next.location;
      }
    });

    final location = ref.watch(carFilterProvider).location;

    return Expanded(
      child: SearchBar(
        controller: _searchController,
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
          color: AppColors.icon,
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
              icon: const Icon(Icons.clear, color: AppColors.icon, size: 20),
              onPressed: () => _searchController.clear(),
            ),
        ],
      ),
    );
  }
}
