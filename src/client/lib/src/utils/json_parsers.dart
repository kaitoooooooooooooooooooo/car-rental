library;

String parseObjectId(dynamic value) {
  if (value == null) return '';
  if (value is Map) return (value[r'$oid'] ?? '').toString();
  return value.toString();
}

DateTime parseDate(dynamic value) {
  if (value == null) return DateTime.fromMillisecondsSinceEpoch(0);
  if (value is Map) return DateTime.parse(value[r'$date'].toString());
  if (value is DateTime) return value;
  return DateTime.parse(value.toString());
}

double parseDouble(dynamic value) {
  if (value == null) return 0;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString()) ?? 0;
}

int parseInt(dynamic value) {
  if (value == null) return 0;
  if (value is num) return value.toInt();
  return int.tryParse(value.toString()) ?? 0;
}
