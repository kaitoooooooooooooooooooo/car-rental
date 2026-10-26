import 'package:car_rent_client/src/theme/theme.dart';
import 'package:car_rent_client/src/features/car/presentation/cars_list/brand_card.dart';
import 'package:car_rent_client/src/features/car/presentation/cars_list/cars_results.dart';
import 'package:car_rent_client/src/features/car/presentation/filter_bottomSheet/car_filter_provider.dart';
import 'package:car_rent_client/src/features/car/presentation/filter_bottomSheet/filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class CarsListScreen extends ConsumerStatefulWidget {
  const CarsListScreen({super.key});

  @override
  ConsumerState<CarsListScreen> createState() => _CarsListScreenState();
}

class _CarsListScreenState extends ConsumerState<CarsListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchText = ref.watch(searchQueryProvider);

    final Widget logo = CircleAvatar(
      backgroundColor: AppColors.surface,
      child: Container(
        margin: EdgeInsets.all(3),
        child: Image.asset('assets/images/app/logo.png'),
      ),
    );

    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 45, 16, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(padding: const EdgeInsets.all(10), child: logo),
                        SizedBox(width: 4),
                        Text(
                          'Rivano',
                          style: GoogleFonts.manrope(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.circle_notifications,
                          color: AppColors.textPrimary,
                          size: 45,
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.account_circle,
                          color: AppColors.textPrimary,
                          size: 45,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                  child: Divider(color: AppColors.onAccent, thickness: 1),
                ),
                Row(
                  children: [
                    Expanded(
                      child: SearchBar(
                        controller: _searchController,
                        onChanged: (value) => ref
                            .read(searchQueryProvider.notifier)
                            .setQuery(value),
                        hintText: 'Search your dream car...',
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
                          Icons.search,
                          color: AppColors.textSecondary,
                          size: 22,
                        ),
                        padding: const WidgetStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 16),
                        ),
                        backgroundColor: WidgetStatePropertyAll(
                          AppColors.surface,
                        ),
                        elevation: const WidgetStatePropertyAll(0),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: BorderSide(color: AppColors.stoke),
                          ),
                        ),
                        trailing: [
                          if (searchText.isNotEmpty)
                            IconButton(
                              icon: const Icon(
                                Icons.clear,
                                color: AppColors.textSecondary,
                                size: 20,
                              ),
                              onPressed: () {
                                _searchController.clear();
                                ref
                                    .read(searchQueryProvider.notifier)
                                    .setQuery('');
                              },
                            ),
                        ],
                      ),
                    ),
                    SizedBox(width: 30),
                    const FilterBottomsheet(),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Brands',
                      style: GoogleFonts.manrope(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          BrandCard(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceLow,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Best Cars',
                          style: GoogleFonts.manrope(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          'View All',
                          style: GoogleFonts.manrope(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Available',
                      style: GoogleFonts.manrope(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.accent,
                      ),
                    ),
                    SizedBox(height: 20),
                    const Expanded(child: CarsResults()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
