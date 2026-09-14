import 'package:car_rent_client/src/constants/app_sizes.dart';
import 'package:car_rent_client/src/constants/colors.dart';
import 'package:car_rent_client/src/features/car/data/remote/car_service.dart';
import 'package:car_rent_client/src/features/car/presentation/filter_bottomSheet/car_filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class RangeSelector extends ConsumerWidget {
  const RangeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carsListValue = ref.watch(carsListFutureProvider);
    final filter = ref.watch(carFilterProvider);
    final notifier = ref.read(carFilterProvider.notifier);

    return carsListValue.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Text(
          'Erreur : $error',
          style: const TextStyle(color: AppColors.error),
        ),
      ),
      data: (cars) {
        if (cars.isEmpty) {
          return const Center(child: Text('Aucune donnée disponible'));
        }

        final prices = cars.map((car) => car.tarifs.jour.toDouble()).toList();
        final minPrice = prices.reduce((a, b) => a < b ? a : b);
        final maxPrice = prices.reduce((a, b) => a > b ? a : b);

        final currentStart = filter.minPrice ?? minPrice;
        final currentEnd = filter.maxPrice ?? maxPrice;

        final Map<double, int> priceCount = {};
        for (final price in prices) {
          priceCount[price] = (priceCount[price] ?? 0) + 1;
        }
        final chartData =
            priceCount.entries
                .map((e) => ChartData(x: e.key, y: e.value.toDouble()))
                .toList()
              ..sort((a, b) => a.x.compareTo(b.x));

        return Column(
          key: ValueKey('range-${filter.resetToken}'),
          children: [
            SfRangeSelector(
              min: minPrice,
              max: maxPrice,
              activeColor: AppColors.accent,
              initialValues: SfRangeValues(currentStart, currentEnd),
              interval: ((maxPrice - minPrice) / 5).clamp(1, double.infinity),
              showLabels: true,
              showTicks: true,
              onChanged: (SfRangeValues values) {
                notifier.setPriceRange(values.start, values.end);
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
                        currentStart.toStringAsFixed(0),
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
                        currentEnd.toStringAsFixed(0),
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
