import 'package:car_rent_client/src/constants/app_sizes.dart';
import 'package:car_rent_client/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RentalBooking extends StatefulWidget {
  const RentalBooking({super.key});

  @override
  State<RentalBooking> createState() => _RentalBookingState();
}

class _RentalBookingState extends State<RentalBooking> {
  String rentalType = 'Day';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RentalTimeWidget(
          onChanged: (value) => setState(() => rentalType = value),
        ),
        gapH16,
        DatePicker(rentalType: rentalType),
      ],
    );
  }
}

class DatePicker extends StatefulWidget {
  const DatePicker({super.key, this.rentalType = 'Weekly'});

  /// 'Hour' ou 'Day' -> un seul sélecteur (juste une date)
  /// 'Weekly' ou 'Monthly' -> deux sélecteurs (début + fin)
  final String rentalType;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? startDate;
  DateTime? endDate;

  bool get _showEndDate =>
      widget.rentalType == 'Weekly' || widget.rentalType == 'Monthly';

  @override
  void didUpdateWidget(covariant DatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    // si on repasse en mode "une seule date", on efface la date de fin
    if (oldWidget.rentalType != widget.rentalType && !_showEndDate) {
      endDate = null;
    }
  }

  Future<void> _selectDate({required bool isStart}) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: isStart
          ? (startDate ?? DateTime.now())
          : (endDate ?? startDate ?? DateTime.now()),
      firstDate: isStart ? DateTime.now() : (startDate ?? DateTime.now()),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (date == null) return;

    setState(() {
      if (isStart) {
        startDate = date;
        if (endDate != null && endDate!.isBefore(date)) endDate = null;
      } else {
        endDate = date;
      }
    });
  }

  String _format(DateTime? date) {
    if (date == null) return '--/--/----';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton(
          onPressed: () => _selectDate(isStart: true),
          child: Text(_format(startDate)),
        ),
        if (_showEndDate) ...[
          const SizedBox(width: 8),
          OutlinedButton(
            onPressed: () => _selectDate(isStart: false),
            child: Text(_format(endDate)),
          ),
        ],
      ],
    );
  }
}

class RentalTimeWidget extends StatefulWidget {
  const RentalTimeWidget({super.key, this.onChanged});

  final ValueChanged<String>? onChanged;

  @override
  State<RentalTimeWidget> createState() => _RentalTimeWidgetState();
}

class _RentalTimeWidgetState extends State<RentalTimeWidget> {
  final List<String> options = const ['Hour', 'Day', 'Weekly', 'Monthly'];

  String selected = 'Day';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rental Time',
          style: GoogleFonts.roboto(
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
                  onTap: () {
                    setState(() => selected = option);
                    widget.onChanged?.call(option);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 280),
                      curve: Curves.easeInOut,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF000000)
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
                                ? Colors.white
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
