import 'package:car_rent_client/src/features/car/domain/indisponibilite.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Indisponibilite.fromJson pour tous les champs', () {
    final indisponibilite = Indisponibilite.fromJson(<String, dynamic>{
      'debut': '2026-09-01T08:00:00Z',
      'fin': '2026-09-10T18:30:00Z',
      'motif': 'Entretien',
    });

    expect(indisponibilite.debut, DateTime.utc(2026, 9, 1, 8));
    expect(indisponibilite.fin, DateTime.utc(2026, 9, 10, 18, 30));
    expect(indisponibilite.motif, 'Entretien');
  });
}
