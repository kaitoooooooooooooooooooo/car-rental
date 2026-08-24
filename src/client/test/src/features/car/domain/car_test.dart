import 'package:car_rent_client/src/features/car/domain/car.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Car.fromJson pour tous les champs', () {
    final car = Car.fromJson(<String, dynamic>{
      'id': 12,
      'marque': 'Volkswagen',
      'modele': 'Golf 8',
      'annee': 2022,
      'categorie': 'compacte',
      'statut': 'disponible',
      'proprietaireId': '65f1c2a4e3b1a2d4c5e6f7a8',
      'immatriculation': 'VD 123456',
      'description': 'Golf 8 recente, tres bien entretenue.',
      'localisation': {
        'ville': 'Lausanne',
        'canton': 'VD',
        'codePostal': '1003',
        'adresse': 'Rue de Bourg 12',
        'pointRetrait': 'Gare CFF',
      },
      'caracteristiques': {
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
      },
      'equipements': ['GPS', 'Bluetooth'],
      'tarifs': {
        'devise': 'CHF',
        'jour': 85,
        'semaine': 500,
        'mois': 1700,
        'caution': 1500,
        'kilometrageInclusParJour': 200,
        'prixKmSupplementaire': 0.35,
      },
      'conditions': {
        'ageMinimum': 21,
        'anneesPermisMinimum': 2,
        'kilometrageMaxParJour': 250,
        'conduiteEtrangerAutorisee': true,
        'animauxAutorises': false,
        'fumeurAutorise': false,
      },
      'indisponibilites': [
        {
          'debut': '2026-09-01T08:00:00Z',
          'fin': '2026-09-10T18:30:00Z',
          'motif': 'Entretien',
        },
      ],
      'photos': [
        {
          'url': 'https://cdn.example.com/golf-1.jpg',
          'legende': 'Vue avant',
          'principale': true,
          'ordre': 1,
          'asset': 'assets/images/golf-1.jpg',
        },
      ],
      'note': {'moyenne': 4.7, 'nombre': 34},
      'nombreLocations': 18,
      'createdAt': '2025-11-02T09:15:00Z',
      'updatedAt': '2026-08-01T14:45:00Z',
    });

    expect(car.id, 12);
    expect(car.marque, 'Volkswagen');
    expect(car.modele, 'Golf 8');
    expect(car.annee, 2022);
    expect(car.categorie, 'compacte');
    expect(car.statut, 'disponible');
    expect(car.proprietaireId, '65f1c2a4e3b1a2d4c5e6f7a8');
    expect(car.immatriculation, 'VD 123456');
    expect(car.description, 'Golf 8 recente, tres bien entretenue.');
    expect(car.localisation.ville, 'Lausanne');
    expect(car.caracteristiques.puissanceCh, 150);
    expect(car.equipements, ['GPS', 'Bluetooth']);
    expect(car.tarifs.jour, 85);
    expect(car.conditions.ageMinimum, 21);
    expect(car.indisponibilites, hasLength(1));
    expect(car.indisponibilites.first.motif, 'Entretien');
    expect(car.photos, hasLength(1));
    expect(car.photos.first.url, 'https://cdn.example.com/golf-1.jpg');
    expect(car.note.moyenne, 4.7);
    expect(car.nombreLocations, 18);
    expect(car.createdAt, DateTime.utc(2025, 11, 2, 9, 15));
    expect(car.updatedAt, DateTime.utc(2026, 8, 1, 14, 45));
  });
}
