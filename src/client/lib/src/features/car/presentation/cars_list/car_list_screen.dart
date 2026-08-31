// ignore_for_file: dead_null_aware_expression

import 'package:car_rent_client/src/constants/app_sizes.dart';
import 'package:car_rent_client/src/constants/colors.dart';
import 'package:car_rent_client/src/features/car/data/remote/car_service.dart';
import 'package:car_rent_client/src/features/car/presentation/cars_list/car_card.dart';
import 'package:car_rent_client/src/features/car/presentation/cars_list/rangeselector.dart';
import 'package:car_rent_client/src/features/car/presentation/cars_list/segmentedControl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class CarsListScreen extends ConsumerStatefulWidget {
  const CarsListScreen({super.key});

  @override
  ConsumerState<CarsListScreen> createState() => _CarsListScreenState();
}

enum ViewMode { day, week, month }

class _CarsListScreenState extends ConsumerState<CarsListScreen> {
  final SearchController _searchController = SearchController();

  String _searchText = '';

  // ignore: prefer_final_fields, unused_field
  int _index = 0;

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final carsListValue = ref.watch(carsListFutureProvider);
    MediaQuery.of(context).size.height;

    final Widget logo = CircleAvatar(
      backgroundColor: Colors.black,
      child: Container(
        margin: EdgeInsets.all(3),
        child: Image.asset('assets/images/app/logo.png'),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 25, 16, 24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: logo,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Rivano',
                          style: GoogleFonts.roboto(
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
                          color: Colors.black,
                          size: 45,
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.account_circle,
                          color: Colors.black,
                          size: 45,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                  child: Divider(color: Colors.grey.shade300, thickness: 1),
                ),
                Row(
                  children: [
                    Expanded(
                      child: SearchBar(
                        controller: _searchController,
                        hintText: 'Search your dream car...',
                        textStyle: WidgetStatePropertyAll(
                          GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        hintStyle: WidgetStatePropertyAll(
                          GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                        leading: const Icon(
                          Icons.search,
                          color: AppColors.icon,
                          size: 22,
                        ),
                        padding: const WidgetStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 16),
                        ),
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.grey.shade100,
                        ),
                        elevation: const WidgetStatePropertyAll(0),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        trailing: [
                          if (_searchText.isNotEmpty)
                            IconButton(
                              icon: const Icon(
                                Icons.clear,
                                color: AppColors.icon,
                                size: 20,
                              ),
                              onPressed: () {
                                _searchController.clear();
                              },
                            ),
                        ],
                      ),
                    ),
                    SizedBox(width: 30),
                    RawMaterialButton(
                      splashColor: AppColors.white,
                      onPressed: () {
                        showModalBottomSheet(
                          backgroundColor: AppColors.white,
                          context: context,
                          builder: (context) {
                            return Container(
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
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
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
                                  CarTypeToggle(
                                    onChanged: (value) {
                                      print('Sélection : $value');
                                    },
                                  ),
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
                                ],
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
                      child: Icon(
                        Icons.tune,
                        size: 26.0,
                        color: AppColors.icon,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Brands',
                      style: GoogleFonts.roboto(
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
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 30, 16, 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Best Cars',
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          'View All',
                          style: GoogleFonts.roboto(
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
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: carsListValue.when(
                        data: (cars) {
                          final filteredCars = cars.where((car) {
                            // ignore: duplicate_ignore
                            // ignore: dead_null_aware_expression, dead_code
                            final brand = car.marque.toLowerCase() ?? '';
                            // ignore: dead_code
                            final model = car.modele.toLowerCase() ?? '';
                            return brand.contains(_searchText) ||
                                model.contains(_searchText);
                          }).toList();
                          if (filteredCars.isEmpty) {
                            return const Center(
                              child: Text(
                                'Aucune voiture trouvée',
                                style: TextStyle(fontSize: 18),
                              ),
                            );
                          }
                          return GridView.builder(
                            padding: const EdgeInsets.only(bottom: 90),
                            itemCount: filteredCars.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                  childAspectRatio: 0.85,
                                ),
                            itemBuilder: (context, index) {
                              final car = filteredCars[index];
                              return CarCard(car: car, onTap: () {});
                            },
                          );
                        },
                        error: (error, _) =>
                            Center(child: Text(error.toString())),
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                    ),
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
