import 'package:car_rent_client/src/constants/app_sizes.dart';
import 'package:car_rent_client/src/constants/colors.dart';
import 'package:car_rent_client/src/features/car/presentation/filter_bottomSheet/price_range_widget.dart';
import 'package:car_rent_client/src/features/car/presentation/filter_bottomSheet/rental_time_widget.dart';
import 'package:car_rent_client/src/features/car/presentation/filter_bottomSheet/type_cars_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterBottomsheet extends StatefulWidget {
  const FilterBottomsheet({super.key});

  @override
  State<FilterBottomsheet> createState() => _FilterBottomsheetState();
}

class _FilterBottomsheetState extends State<FilterBottomsheet> {
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      splashColor: AppColors.white,
      onPressed: () {
        showModalBottomSheet(
          backgroundColor: AppColors.white,
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
                            color: Colors.grey.shade300,
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
                        CarTypeToggle(onChanged: (value) {}),
                        gapH16,
                        SizedBox(
                          height: 20,
                          child: Divider(
                            color: Colors.grey.shade300,
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
                        RangeSelector(),
                        gapH16,
                        SizedBox(
                          height: 20,
                          child: Divider(
                            color: Colors.grey.shade300,
                            thickness: 1,
                          ),
                        ),
                        gapH8,
                        RentalTimeWidget(),
                        gapH8,
                        Center(child: DatePicker()),
                        gapH8,
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
      fillColor: Colors.white,
      padding: EdgeInsets.all(15.0),
      shape: CircleBorder(),
      constraints: BoxConstraints(minWidth: 0.0),
      child: Icon(Icons.tune, size: 26.0, color: AppColors.icon),
    );
  }
}
