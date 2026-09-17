import 'package:car_rent_client/src/features/car/data/remote/car_service.dart';
import 'package:car_rent_client/src/features/car/domain/car.dart';
import 'package:car_rent_client/src/features/car/presentation/cars_list/cars_results.dart';
import 'package:car_rent_client/src/features/car/presentation/filter_bottomSheet/car_filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'affiche un message quand aucune voiture ne correspond à la recherche',
    (tester) async {
      final porsche = Car.fromJson({
        'id': 1,
        'marque': 'Porsche',
        'modele': '911',
        'annee': 2023,
        'proprietaireId': '68a1f0000000000000000001',
        'createdAt': '2024-01-01T00:00:00.000Z',
        'updatedAt': '2024-01-01T00:00:00.000Z',
      });

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            carsListFutureProvider.overrideWith((ref) async => [porsche]),
            searchQueryProvider.overrideWith((ref) => 'Ferrari'),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: Column(children: [Expanded(child: CarsResults())]),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(NoCarsFound.title), findsOneWidget);
      expect(find.textContaining('Ferrari'), findsOneWidget);
    },
  );
}
