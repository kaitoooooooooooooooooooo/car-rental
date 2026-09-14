import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:car_rent_client/src/constants/app_sizes.dart';
import 'package:car_rent_client/src/constants/colors.dart';
import 'package:car_rent_client/src/features/car/presentation/filter_bottomSheet/car_filter_provider.dart';
import 'package:car_rent_client/src/features/car/presentation/filter_bottomSheet/custom_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

const int _minDurationMinutes = 60;

int _toMinutes(TimeOfDay time) => time.hour * 60 + time.minute;

TimeOfDay _addMinutes(TimeOfDay time, int minutes) {
  final total = (_toMinutes(time) + minutes) % (24 * 60);
  return TimeOfDay(hour: total ~/ 60, minute: total % 60);
}

bool _hasMinDuration(TimeOfDay start, TimeOfDay end) {
  var diff = _toMinutes(end) - _toMinutes(start);
  if (diff <= 0) diff += 24 * 60;
  return diff >= _minDurationMinutes;
}

String _formatDate(DateTime? date) {
  if (date == null) return '--/--/----';
  return '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}/'
      '${date.year}';
}

String _formatTime(TimeOfDay? time) {
  if (time == null) return '--:--';
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}

class DatePicker extends ConsumerWidget {
  const DatePicker({super.key});

  Future<void> _openCalendarDialog(BuildContext context, WidgetRef ref) async {
    final currentDates = ref.read(carFilterProvider).selectedDates;

    final config = CalendarDatePicker2WithActionButtonsConfig(
      calendarType: CalendarDatePicker2Type.range,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
      selectedDayHighlightColor: AppColors.accent,
      daySplashColor: AppColors.accentSoft,
      dayTextStyle: const TextStyle(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
      selectedDayTextStyle: const TextStyle(
        color: AppColors.onAccent,
        fontWeight: FontWeight.w700,
      ),
      weekdayLabelTextStyle: const TextStyle(
        color: AppColors.textSecondary,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      centerAlignModePicker: true,
      closeDialogOnCancelTapped: true,
      firstDayOfWeek: 1,
      rangeBidirectional: true,
      selectedRangeHighlightColor: AppColors.accentSoft,
      selectedRangeDayTextStyle: const TextStyle(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w700,
      ),
    );

    final values = await showCalendarDatePicker2Dialog(
      context: context,
      config: config,
      dialogSize: const Size(325, 400),
      borderRadius: BorderRadius.circular(16),
      value: currentDates,
      dialogBackgroundColor: AppColors.surface,
    );

    if (values != null) {
      ref.read(carFilterProvider.notifier).setSelectedDates(values);
    }
  }

  Future<void> _openStartTimeDialog(BuildContext context, WidgetRef ref) async {
    final filter = ref.read(carFilterProvider);
    final time = await showCustomTimePicker(
      context,
      initialTime: filter.startTime,
    );
    if (time == null) return;

    final notifier = ref.read(carFilterProvider.notifier);
    notifier.setStartTime(time);
    if (filter.endTime != null && !_hasMinDuration(time, filter.endTime!)) {
      notifier.setEndTime(_addMinutes(time, _minDurationMinutes));
    }
  }

  Future<void> _openEndTimeDialog(BuildContext context, WidgetRef ref) async {
    final filter = ref.read(carFilterProvider);
    final defaultInitial = filter.startTime != null
        ? _addMinutes(filter.startTime!, _minDurationMinutes)
        : null;

    final time = await showCustomTimePicker(
      context,
      initialTime: filter.endTime ?? defaultInitial,
    );
    if (time == null) return;

    if (filter.startTime != null && !_hasMinDuration(filter.startTime!, time)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('La durée minimale de location est de 1 heure'),
          ),
        );
      }
      return;
    }

    ref.read(carFilterProvider.notifier).setEndTime(time);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(carFilterProvider);
    final isDayMode = filter.rentalType == 'Day';

    if (isDayMode) {
      final dates = filter.selectedDates;
      final label = (dates.isEmpty || dates.first == null)
          ? 'Choose a date'
          : '${_formatDate(dates.first)}  -  ${dates.length > 1 ? _formatDate(dates[1]) : '--/--/----'}';

      return OutlinedButton(
        onPressed: () => _openCalendarDialog(context, ref),
        style: OutlinedButton.styleFrom(
          side: BorderSide.none,
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton.icon(
          onPressed: () => _openStartTimeDialog(context, ref),
          style: OutlinedButton.styleFrom(
            side: BorderSide.none,
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          icon: const Icon(
            Icons.access_time,
            size: 16,
            color: AppColors.textSecondary,
          ),
          label: Text(
            _formatTime(filter.startTime),
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        gapW8,
        const Text('-', style: TextStyle(color: AppColors.stoke)),
        gapW8,
        OutlinedButton.icon(
          onPressed: () => _openEndTimeDialog(context, ref),
          style: OutlinedButton.styleFrom(
            side: BorderSide.none,
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          icon: const Icon(
            Icons.access_time,
            size: 16,
            color: AppColors.textSecondary,
          ),
          label: Text(
            _formatTime(filter.endTime),
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

class RentalTimeWidget extends ConsumerWidget {
  const RentalTimeWidget({super.key});

  static const List<String> options = ['Hour', 'Day'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(carFilterProvider).rentalType;
    final notifier = ref.read(carFilterProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rental Time',
          style: GoogleFonts.manrope(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        gapH8,
        Row(
          children: options.map((option) {
            final bool isSelected = selected == option;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: GestureDetector(
                  onTap: () => notifier.setRentalType(option),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 280),
                      curve: Curves.easeInOut,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.accent
                            : Colors.transparent,
                        border: Border.all(color: AppColors.stoke, width: 1),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          option,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? AppColors.onAccent
                                : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
