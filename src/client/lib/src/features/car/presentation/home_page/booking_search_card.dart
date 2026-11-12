import 'package:car_rent_client/src/app_shell.dart';
import 'package:car_rent_client/src/features/car/presentation/filter_bottomSheet/car_filter_provider.dart';
import 'package:car_rent_client/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookingSearchCard extends ConsumerStatefulWidget {
  const BookingSearchCard({super.key});

  @override
  ConsumerState<BookingSearchCard> createState() => _BookingSearchCardState();
}

class _BookingSearchCardState extends ConsumerState<BookingSearchCard> {
  String _location = '';
  DateTimeRange? _dates;

  Future<void> _pickDates() async {
    final dates = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (dates != null) setState(() => _dates = dates);
  }

  void _search() {
    ref.read(carFilterProvider.notifier)
      ..setLocation(_location.trim())
      ..setSelectedDates(_dates == null ? [] : [_dates!.start, _dates!.end]);
    ref.read(tabIndexProvider.notifier).select(searchTab);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        spacing: 12,
        children: [
          TextField(
            onChanged: (value) => _location = value,
            decoration: _decoration('Pick-up location', Icons.my_location),
          ),
          TextField(
            decoration: _decoration(
              'Drop-off location',
              Icons.location_on_outlined,
            ),
          ),
          Row(
            spacing: 12,
            children: [
              Expanded(child: _dateField('Start date', _dates?.start)),
              Expanded(child: _dateField('End date', _dates?.end)),
            ],
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: FilledButton(
              onPressed: _search,
              child: const Text('Search'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateField(String hint, DateTime? date) {
    return GestureDetector(
      onTap: _pickDates,
      child: InputDecorator(
        isEmpty: date == null,
        decoration: _decoration(hint, Icons.calendar_today_outlined),
        child: Text(
          date == null ? '' : '${date.day}/${date.month}/${date.year}',
        ),
      ),
    );
  }

  InputDecoration _decoration(String hint, IconData icon) => InputDecoration(
    hintText: hint,
    prefixIcon: Icon(icon, size: 20),
    filled: true,
    fillColor: AppColors.surfaceLow,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  );
}
