// ignore: file_names
import 'package:car_rent_client/src/constants/app_sizes.dart';
import 'package:car_rent_client/src/constants/colors.dart';
import 'package:car_rent_client/src/features/car/presentation/filter_bottomSheet/Siting_widget.dart';
import 'package:car_rent_client/src/features/car/presentation/filter_bottomSheet/car_filter_provider.dart';
import 'package:car_rent_client/src/features/car/presentation/filter_bottomSheet/fuel_widget.dart';
import 'package:car_rent_client/src/features/car/presentation/filter_bottomSheet/location_widget.dart';
import 'package:car_rent_client/src/features/car/presentation/filter_bottomSheet/price_range_widget.dart';
import 'package:car_rent_client/src/features/car/presentation/filter_bottomSheet/rental_time_widget.dart';
import 'package:car_rent_client/src/features/car/presentation/filter_bottomSheet/stars_widget.dart';
import 'package:car_rent_client/src/features/car/presentation/filter_bottomSheet/type_cars_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterBottomsheet extends ConsumerWidget {
  const FilterBottomsheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RawMaterialButton(
      splashColor: AppColors.accentSoft,
      onPressed: () {
        showModalBottomSheet(
          backgroundColor: AppColors.surfaceLow,
          context: context,
          isScrollControlled: true,
          builder: (context) {
            final mediaQuery = MediaQuery.of(context);
            return Padding(
              padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: mediaQuery.size.height * 0.9,
                ),
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 20,
                      right: 20,
                      bottom: 10,
                    ),
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                hoverColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                icon: const Icon(
                                  Icons.clear,
                                  color: AppColors.buttons,
                                  size: 20,
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                            Text(
                              'Filters',
                              style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                          child: Divider(
                            color: AppColors.borderSubtle,
                            thickness: 1,
                          ),
                        ),
                        gapH8,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Types of Cars',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        gapH8,
                        const CarTypeToggle(),
                        gapH16,
                        SizedBox(
                          height: 20,
                          child: Divider(
                            color: AppColors.borderSubtle,
                            thickness: 1,
                          ),
                        ),
                        gapH8,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Price range',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        const RangeSelector(),
                        gapH16,
                        SizedBox(
                          height: 20,
                          child: Divider(
                            color: AppColors.borderSubtle,
                            thickness: 1,
                          ),
                        ),
                        gapH8,
                        const RentalTimeWidget(),
                        gapH28,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Pick up and Drop Date',
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const DatePicker(),
                          ],
                        ),
                        gapH28,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Car location',
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        gapH16,
                        const Row(children: [LocationWidget()]),
                        gapH16,
                        SizedBox(
                          height: 20,
                          child: Divider(
                            color: AppColors.borderSubtle,
                            thickness: 1,
                          ),
                        ),
                        gapH16,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Rating',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        gapH8,
                        Consumer(
                          builder: (context, ref, _) {
                            final rating = ref
                                .watch(carFilterProvider)
                                .minRating;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Choose the minimum rate',
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                StarRatingWidget(
                                  rating: rating,
                                  onRatingChanged: (r) => ref
                                      .read(carFilterProvider.notifier)
                                      .setMinRating(r),
                                ),
                              ],
                            );
                          },
                        ),
                        gapH28,
                        const SitingWidget(),
                        gapH28,
                        const FuelWidget(),
                        gapH28,
                        SizedBox(
                          height: 20,
                          child: Divider(
                            color: AppColors.borderSubtle,
                            thickness: 1,
                          ),
                        ),
                        gapH8,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () => ref
                                  .read(carFilterProvider.notifier)
                                  .clearAll(),
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.textPrimary,
                                overlayColor: AppColors.textPrimary,
                              ),
                              child: Text(
                                'Clear All',
                                style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                            Consumer(
                              builder: (context, ref, _) {
                                final filteredCars = ref.watch(
                                  filteredCarsProvider,
                                );
                                final label = filteredCars.when(
                                  data: (cars) => 'Show ${cars.length} Cars',
                                  loading: () => 'Show Cars',
                                  error: (_, __) => 'Show Cars',
                                );
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.accent,
                                    foregroundColor: AppColors.onAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      label,
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.onAccent,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      elevation: 2.0,
      fillColor: AppColors.surface,
      padding: EdgeInsets.all(15.0),
      shape: CircleBorder(),
      constraints: BoxConstraints(minWidth: 0.0),
      child: Icon(Icons.tune, size: 26.0, color: AppColors.icon),
    );
  }
}
