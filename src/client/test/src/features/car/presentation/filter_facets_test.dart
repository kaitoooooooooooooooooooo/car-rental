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
    'proprietaireId': '68a1f0000000000000000001',
    'createdAt': '2024-01-01T00:00:00.000Z',
    'updatedAt': '2024-01-01T00:00:00.000Z',
    'caracteristiques': {'places': places, 'carburant': carburant},
    'tarifs': {'jour': prix},
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

  test('pas de BMW 2 ou 8 places', () {
    final places = dispo(FilterFacet.seating)
        .map((c) => c.caracteristiques.places);
    expect(places.contains(8), false);
    expect(places.contains(2), false);
    expect(places.contains(4), true);
  });

  test('les autres filtres grisent aussi le carburant', () {
    container.read(draftFilterProvider.notifier).toggleSeating(4);
    final voitures = dispo(FilterFacet.fuel);
    expect(voitures.any((c) => matchesFuel(c, 'Petrol')), true);
    expect(voitures.any((c) => matchesFuel(c, 'Diesel')), false);
  });

  test('tranches de places : 2, 4-5, 6-7, 8+', () {
    Car places(int n) => voiture(9, 'Mercedes', n, 'diesel', 250);
    expect(matchesSeats(places(2), 2), true);
    expect(matchesSeats(places(4), 4), true);
    expect(matchesSeats(places(5), 4), true);
    expect(matchesSeats(places(6), 4), false);
    expect(matchesSeats(places(6), 6), true);
    expect(matchesSeats(places(7), 6), true);
    expect(matchesSeats(places(8), 6), false);
    expect(matchesSeats(places(9), seatsPlusThreshold), true);
  });

  test('un groupe ne se grise pas lui-meme', () {
    container.read(draftFilterProvider.notifier).toggleSeating(4);
    final places = dispo(FilterFacet.seating)
        .map((c) => c.caracteristiques.places);
    expect(places, containsAll([4, 7]));
  });
}
