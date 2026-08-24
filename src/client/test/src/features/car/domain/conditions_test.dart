import 'package:car_rent_client/src/features/car/domain/conditions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Conditions.fromJson pour tous les champs', () {
    final conditions = Conditions.fromJson(<String, dynamic>{
      'ageMinimum': 21,
      'anneesPermisMinimum': 2,
      'kilometrageMaxParJour': 250,
      'conduiteEtrangerAutorisee': true,
      'animauxAutorises': false,
      'fumeurAutorise': false,
    });

    expect(conditions.ageMinimum, 21);
    expect(conditions.anneesPermisMinimum, 2);
    expect(conditions.kilometrageMaxParJour, 250);
    expect(conditions.conduiteEtrangerAutorisee, isTrue);
    expect(conditions.animauxAutorises, isFalse);
    expect(conditions.fumeurAutorise, isFalse);
  });
}
