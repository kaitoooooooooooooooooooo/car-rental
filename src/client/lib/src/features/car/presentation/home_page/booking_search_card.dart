import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:car_rent_client/src/features/car/presentation/filter_bottomSheet/car_filter_provider.dart';
import 'package:car_rent_client/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingSearchCard extends ConsumerStatefulWidget {
  const BookingSearchCard({super.key, required this.onSearch});

  final VoidCallback onSearch;

  @override
  ConsumerState<BookingSearchCard> createState() => _BookingSearchCardState();
}

class _BookingSearchCardState extends ConsumerState<BookingSearchCard> {
  final _pickUp = TextEditingController();
  final _dropOff = TextEditingController();
  List<DateTime?> _dates = [];

  @override
  void dispose() {
    _pickUp.dispose();
    _dropOff.dispose();
    super.dispose();
  }

  Future<void> _pickDates() async {
    final values = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.range,
        firstDate: DateTime.now(),
        firstDayOfWeek: 1,
        selectedDayHighlightColor: AppColors.accent,
        selectedRangeHighlightColor: AppColors.accentSoft,
        dayTextStyle: const TextStyle(color: AppColors.textPrimary),
        weekdayLabelTextStyle: const TextStyle(color: AppColors.textSecondary),
        controlsTextStyle: const TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
      dialogSize: const Size(325, 400),
      borderRadius: BorderRadius.circular(16),
      dialogBackgroundColor: AppColors.surface,
      value: _dates,
    );
    if (values != null) setState(() => _dates = values);
  }

  void _search() {
    ref.read(carFilterProvider.notifier)
      ..setLocation(_pickUp.text.trim())
      ..setSelectedDates(_dates);
    widget.onSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceLow,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _field(_pickUp, 'Pick-up location', Icons.my_location),
          const SizedBox(height: 12),
          _field(_dropOff, 'Drop-off location', Icons.location_on_outlined),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _date('Start date', _dates.firstOrNull)),
              const SizedBox(width: 12),
              Expanded(
                child: _date('End date', _dates.length > 1 ? _dates[1] : null),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: FilledButton(
              onPressed: _search,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.accent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                'Search',
                style: GoogleFonts.manrope(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onAccent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _field(TextEditingController controller, String hint, IconData icon) {
    return TextField(
      controller: controller,
      style: _textStyle(AppColors.textPrimary),
      decoration: _decoration(hint, icon),
    );
  }

  Widget _date(String hint, DateTime? date) {
    return GestureDetector(
      onTap: _pickDates,
      child: InputDecorator(
        isEmpty: date == null,
        decoration: _decoration(hint, Icons.calendar_today_outlined),
        child: Text(
          date == null
              ? ''
              : '${date.day.toString().padLeft(2, '0')}/'
                    '${date.month.toString().padLeft(2, '0')}/${date.year}',
          style: _textStyle(AppColors.textPrimary),
        ),
      ),
    );
  }

  TextStyle _textStyle(Color color) => GoogleFonts.manrope(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: color,
  );

  InputDecoration _decoration(String hint, IconData icon) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.stoke),
    );
    return InputDecoration(
      hintText: hint,
      hintStyle: _textStyle(AppColors.textSecondary),
      prefixIcon: Icon(icon, color: AppColors.textSecondary, size: 20),
      filled: true,
      fillColor: AppColors.surface,
      border: border,
      enabledBorder: border,
      focusedBorder: border.copyWith(
        borderSide: const BorderSide(color: AppColors.accent),
      ),
    );
  }
}
