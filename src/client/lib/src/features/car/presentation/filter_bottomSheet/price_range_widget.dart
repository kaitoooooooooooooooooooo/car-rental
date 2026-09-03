import 'package:car_rent_client/src/constants/app_sizes.dart';
import 'package:car_rent_client/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'package:car_rent_client/src/features/car/data/remote/car_service.dart';

class RangeSelector extends ConsumerStatefulWidget {
  const RangeSelector({super.key});

  @override
  ConsumerState<RangeSelector> createState() => _RangeSelectorState();
}

class _RangeSelectorState extends ConsumerState<RangeSelector> {
  SfRangeValues _values = const SfRangeValues(0, 1000);

  @override
  Widget build(BuildContext context) {
    final carsListValue = ref.watch(carsListFutureProvider);

    return carsListValue.when(
      loading: () => const Center(child: CircularProgressIndicator()),

      error: (error, stackTrace) => Center(
        child: Text(
          'Erreur : $error',
          style: const TextStyle(color: Colors.red),
        ),
      ),

      data: (cars) {
        if (cars.isEmpty) {
          return const Center(child: Text('Aucune donnée disponible'));
        }

        final prices = cars
            .map((car) => car.tarifs.jour)
            // ignore: unnecessary_null_comparison
            .where((price) => price != null)
            .map((price) => (price as num).toDouble())
            .toList();

        if (prices.isEmpty) {
          return const Center(child: Text('Aucun prix disponible'));
        }

        final minPrice = prices.reduce((a, b) => a < b ? a : b);

        final maxPrice = prices.reduce((a, b) => a > b ? a : b);

        final Map<double, int> priceCount = {};

        for (final price in prices) {
          priceCount[price] = (priceCount[price] ?? 0) + 1;
        }

        final chartData = priceCount.entries
            .map((entry) => ChartData(x: entry.key, y: entry.value.toDouble()))
            .toList();

        chartData.sort((a, b) => a.x.compareTo(b.x));

        return Column(
          children: [
            SfRangeSelector(
              min: minPrice,
              max: maxPrice,
              activeColor: AppColors.textPrimary,
              initialValues: SfRangeValues(minPrice, maxPrice),
              interval: ((maxPrice - minPrice) / 5).clamp(1, double.infinity),
              showLabels: true,
              showTicks: true,
              onChanged: (SfRangeValues values) {
                setState(() {
                  _values = values;
                });
              },
              child: SizedBox(
                height: 130,
                child: SfCartesianChart(
                  margin: EdgeInsets.zero,
                  primaryXAxis: NumericAxis(
                    minimum: minPrice,
                    maximum: maxPrice,
                    isVisible: false,
                  ),
                  primaryYAxis: NumericAxis(isVisible: false),
                  plotAreaBorderWidth: 0,
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ColumnSeries<ChartData, double>>[
                    ColumnSeries<ChartData, double>(
                      dataSource: chartData,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      color: AppColors.textPrimary,
                      width: 0.7,
                      spacing: 0.1,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      'Minimum',
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    gapH8,
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.stoke, width: 1),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 6,
                      ),
                      child: Text(
                        '${_values.start.toStringAsFixed(0)}',
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Maximum',
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    gapH8,
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.stoke, width: 1),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 6,
                      ),
                      child: Text(
                        '${_values.end.toStringAsFixed(0)}',
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class ChartData {
  ChartData({required this.x, required this.y});

  final double x;
  final double y;
}
