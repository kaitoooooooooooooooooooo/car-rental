import 'package:car_rent_client/src/constants/app_sizes.dart';
import 'package:car_rent_client/src/constants/colors.dart';
import 'package:car_rent_client/src/features/car/data/remote/car_service.dart';
import 'package:car_rent_client/src/features/car/presentation/filter_bottomSheet/car_filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

const double _lowPercentile = 0.05;
const double _highPercentile = 0.95;
const int _maxLabelIntervals = 8;
const int _bucketsPerLabel = 4;
const int _minorTicksPerLabel = 1;
const double _sliderStep = 10;
const double _minBarRatio = 0.2;
const List<double> _labelSteps = [
  10,
  20,
  25,
  50,
  100,
  200,
  250,
  500,
  1000,
  2000,
  2500,
  5000,
  10000,
];

class RangeSelector extends ConsumerWidget {
  const RangeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carsListValue = ref.watch(carsListFutureProvider);
    final filter = ref.watch(draftFilterProvider);
    final notifier = ref.read(draftFilterProvider.notifier);

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

        final prices =
            cars
                .where((car) => matchesCarType(car, filter.carType))
                .map((car) => car.tarifs.jour.toDouble())
                .toList()
              ..sort();

        if (prices.isEmpty) {
          return const Center(child: Text('Aucune voiture pour ce type'));
        }

        final scale = PriceScale.fromPrices(prices);
        final chartData = scale.buildHistogram(prices);

        final double currentStart = (filter.minPrice ?? scale.axisMin)
            .clamp(scale.axisMin, scale.axisMax)
            .toDouble();
        final double currentEnd = (filter.maxPrice ?? scale.axisMax)
            .clamp(scale.axisMin, scale.axisMax)
            .toDouble();

        final minLabel = currentStart.toStringAsFixed(0);
        final maxLabel = filter.maxPrice == null
            ? '${scale.axisMax.toStringAsFixed(0)}+'
            : currentEnd.toStringAsFixed(0);

        return Column(
          key: ValueKey('range-${filter.resetToken}-${filter.carType.name}'),
          children: [
            SfRangeSelector(
              min: scale.axisMin,
              max: scale.axisMax,
              activeColor: AppColors.accent,
              initialValues: SfRangeValues(currentStart, currentEnd),
              interval: scale.labelStep,
              stepSize: _sliderStep,
              minorTicksPerInterval: _minorTicksPerLabel,
              showLabels: true,
              showTicks: true,
              labelFormatterCallback: (dynamic value, String formattedText) {
                final number = (value as num).toDouble();
                return number >= scale.axisMax
                    ? '${number.toStringAsFixed(0)}+'
                    : number.toStringAsFixed(0);
              },
              onChanged: (SfRangeValues values) {
                final double start = (values.start as num).toDouble();
                final double end = (values.end as num).toDouble();
                notifier.setPriceRange(
                  start <= scale.axisMin ? null : start,
                  end >= scale.axisMax ? null : end,
                );
              },
              child: SizedBox(
                height: 130,
                child: SfCartesianChart(
                  margin: const EdgeInsets.only(bottom: 10),
                  primaryXAxis: NumericAxis(
                    minimum: scale.axisMin,
                    maximum: scale.axisMax,
                    isVisible: false,
                  ),
                  primaryYAxis: NumericAxis(isVisible: false, minimum: 0),
                  plotAreaBorderWidth: 0,
                  series: <ColumnSeries<ChartData, double>>[
                    ColumnSeries<ChartData, double>(
                      dataSource: chartData,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      color: AppColors.textPrimary,
                      width: 0.9,
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
                _PriceBadge(title: 'Minimum', value: minLabel),
                _PriceBadge(title: 'Maximum', value: maxLabel),
              ],
            ),
          ],
        );
      },
    );
  }
}

class PriceScale {
  const PriceScale({
    required this.axisMin,
    required this.axisMax,
    required this.labelStep,
  });

  factory PriceScale.fromPrices(List<double> sortedPrices) {
    final last = sortedPrices.length - 1;
    final low = sortedPrices[(last * _lowPercentile).round()];
    final high = sortedPrices[(last * _highPercentile).round()];
    final span = high - low;

    final labelStep = _labelSteps.firstWhere(
      (step) => span / step <= _maxLabelIntervals,
      orElse: () => _labelSteps.last,
    );

    final axisMin = (low / labelStep).floor() * labelStep;
    var axisMax = (high / labelStep).ceil() * labelStep;
    if (axisMax <= axisMin) axisMax = axisMin + labelStep;

    return PriceScale(axisMin: axisMin, axisMax: axisMax, labelStep: labelStep);
  }

  final double axisMin;
  final double axisMax;
  final double labelStep;

  double get bucketWidth => labelStep / _bucketsPerLabel;

  int get bucketCount => ((axisMax - axisMin) / bucketWidth).round();

  List<ChartData> buildHistogram(List<double> prices) {
    final counts = List<int>.filled(bucketCount, 0);
    for (final price in prices) {
      final index = ((price - axisMin) / bucketWidth).floor().clamp(
        0,
        bucketCount - 1,
      );
      counts[index]++;
    }

    final maxCount = counts.fold<int>(0, (a, b) => a > b ? a : b);
    final minVisibleHeight = maxCount * _minBarRatio;

    return List.generate(bucketCount, (i) {
      final count = counts[i];
      final height = count == 0
          ? 0.0
          : (count < minVisibleHeight ? minVisibleHeight : count.toDouble());
      return ChartData(x: axisMin + (i + 0.5) * bucketWidth, y: height);
    });
  }
}

class _PriceBadge extends StatelessWidget {
  const _PriceBadge({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.manrope(
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
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
          child: Text(
            value,
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}

class ChartData {
  ChartData({required this.x, required this.y});
  final double x;
  final double y;
}
