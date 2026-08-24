import 'package:car_rent_client/src/features/car/domain/caracteristiques.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Caracteristiques.fromJson pour tous les champs', () {
    final caracteristiques = Caracteristiques.fromJson(<String, dynamic>{
      'transmission': 'automatique',
      'carburant': 'essence',
      'places': 5,
      'portes': 5,
      'puissanceCh': 150,
      'cylindree': 1498,
      'consommationMixte': 5.9,
      'coffreLitres': 380,
      'couleur': 'gris',
      'kilometrage': 31000,
    });

    expect(caracteristiques.transmission, 'automatique');
    expect(caracteristiques.carburant, 'essence');
    expect(caracteristiques.places, 5);
    expect(caracteristiques.portes, 5);
    expect(caracteristiques.puissanceCh, 150);
    expect(caracteristiques.cylindree, 1498);
    expect(caracteristiques.consommationMixte, 5.9);
    expect(caracteristiques.coffreLitres, 380);
    expect(caracteristiques.couleur, 'gris');
    expect(caracteristiques.kilometrage, 31000);
  });
}
