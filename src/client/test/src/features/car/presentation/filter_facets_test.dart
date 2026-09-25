import 'package:car_rent_client/src/features/car/data/remote/car_service.dart';
import 'package:car_rent_client/src/features/car/domain/car.dart';
import 'package:car_rent_client/src/features/car/presentation/filter_bottomSheet/car_filter_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Car voiture(int id, String marque, int places, String carburant, int prix) {
  return Car.fromJson({
    'id': id,
    'marque': marque,
    'modele': 'Modele $id',
    'annee': 2023,
    'categorie': 'sport',
    'statut': 'valide',
    'proprietaireId': '68a1f0000000000000000001',
    'immatriculation': 'VD 123 456',
    'description': 'Voiture de test',
    'localisation': {
      'ville': 'Lausanne',
      'canton': 'VD',
      'codePostal': '1003',
      'adresse': 'Rue de Bourg 12',
      'pointRetrait': 'Gare CFF',
    },
    'caracteristiques': {
      'transmission': 'automatique',
      'carburant': carburant,
      'places': places,
      'portes': 4,
      'puissanceCh': 300,
      'cylindree': 2998,
      'consommationMixte': 8,
      'coffreLitres': 400,
      'couleur': 'noir',
      'kilometrage': 10000,
    },
    'equipements': ['gps'],
    'tarifs': {
      'devise': 'CHF',
      'jour': prix,
      'semaine': prix * 6,
      'mois': prix * 20,
      'caution': 3000,
      'kilometrageInclusParJour': 200,
      'prixKmSupplementaire': 1,
    },
    'conditions': {
      'ageMinimum': 25,
      'anneesPermisMinimum': 3,
      'kilometrageMaxParJour': 300,
      'conduiteEtrangerAutorisee': false,
      'animauxAutorises': false,
      'fumeurAutorise': false,
    },
    'indisponibilites': [],
    'photos': [],
    'note': {'moyenne': 4, 'nombre': 10},
    'nombreLocations': 5,
    'createdAt': '2024-01-01T00:00:00.000Z',
    'updatedAt': '2024-01-01T00:00:00.000Z',
  });
}

void main() {
  late ProviderContainer container;

  setUp(() async {
    container = ProviderContainer(
      overrides: [
        carsListFutureProvider.overrideWith(
          (ref) async => [
            voiture(1, 'BMW', 4, 'essence', 300),
            voiture(2, 'BMW', 7, 'diesel', 450),
            voiture(3, 'Ferrari', 2, 'essence', 2000),
          ],
        ),
      ],
    );
    await container.read(carsListFutureProvider.future);
    container.read(draftFilterProvider.notifier).toggleBrand('BMW');
  });

  tearDown(() => container.dispose());

  List<Car> dispo(FilterFacet facet) =>
      container.read(draftCarsIgnoringProvider(facet))!;

  test('la marque limite le graphique des prix', () {
    final prix = dispo(FilterFacet.price).map((c) => c.tarifs.jour).toList();
    expect(prix, unorderedEquals([300, 450]));
  });

  test('pas de BMW luxe : Luxury est indisponible', () {
    final voitures = dispo(FilterFacet.carType);
    expect(voitures.any((c) => matchesCarType(c, CarTypeFilter.luxury)), false);
    expect(voitures.any((c) => matchesCarType(c, CarTypeFilter.regular)), true);
  });

  test('pas de BMW 2 places ni 5-6 places', () {
    final voitures = dispo(FilterFacet.seating);
    expect(voitures.any((c) => matchesSeats(c, '2')), false);
    expect(voitures.any((c) => matchesSeats(c, '5-6')), false);
    expect(voitures.any((c) => matchesSeats(c, '4')), true);
    expect(voitures.any((c) => matchesSeats(c, '7+')), true);
  });

  test('les autres filtres grisent aussi le carburant', () {
    container.read(draftFilterProvider.notifier).toggleSeating('4');
    final voitures = dispo(FilterFacet.fuel);
    expect(voitures.any((c) => matchesFuel(c, 'Petrol')), true);
    expect(voitures.any((c) => matchesFuel(c, 'Diesel')), false);
  });

  test('tranches de places : 2, 4, 5-6, 7+', () {
    expect(seatingLabel(2), '2');
    expect(seatingLabel(4), '4');
    expect(seatingLabel(5), '5-6');
    expect(seatingLabel(6), '5-6');
    expect(seatingLabel(7), '7+');
    expect(seatingLabel(9), '7+');
  });

  test('un groupe ne se grise pas lui-meme', () {
    container.read(draftFilterProvider.notifier).toggleSeating('4');
    final places = dispo(FilterFacet.seating)
        .map((c) => c.caracteristiques.places);
    expect(places, containsAll([4, 7]));
  });
}
