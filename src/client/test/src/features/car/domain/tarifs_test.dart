import 'package:car_rent_client/src/features/car/domain/tarifs.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Tarifs.fromJson pour tous les champs', () {
    final tarifs = Tarifs.fromJson(<String, dynamic>{
      'devise': 'CHF',
      'jour': 85,
      'semaine': 500,
      'mois': 1700,
      'caution': 1500,
      'kilometrageInclusParJour': 200,
      'prixKmSupplementaire': 0.35,
    });

    expect(tarifs.devise, 'CHF');
    expect(tarifs.jour, 85);
    expect(tarifs.semaine, 500);
    expect(tarifs.mois, 1700);
    expect(tarifs.caution, 1500);
    expect(tarifs.kilometrageInclusParJour, 200);
    expect(tarifs.prixKmSupplementaire, 0.35);
  });
}
