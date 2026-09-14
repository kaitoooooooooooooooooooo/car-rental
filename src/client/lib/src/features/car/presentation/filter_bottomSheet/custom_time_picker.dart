import 'package:flutter/material.dart';

Future<TimeOfDay?> showCustomTimePicker(
  BuildContext context, {
  TimeOfDay? initialTime,
}) {
  return showTimePicker(
    context: context,
    initialTime: initialTime ?? TimeOfDay.now(),
    initialEntryMode: TimePickerEntryMode.inputOnly,
    orientation: Orientation.landscape,
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(brightness: Brightness.dark),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          ),
        ),
      );
    },
  );
}
