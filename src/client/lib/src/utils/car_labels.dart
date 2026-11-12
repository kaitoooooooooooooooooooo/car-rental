const Map<String, String> carLabels = {
  'essence': 'Petrol',
  'diesel': 'Diesel',
  'hybride': 'Hybrid',
  'electrique': 'Electric',
  'automatique': 'Automatic',
  'manuelle': 'Manual',
};

String carLabel(String value) => carLabels[value] ?? value;
