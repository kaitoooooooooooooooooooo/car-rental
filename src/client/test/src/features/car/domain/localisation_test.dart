import 'package:car_rent_client/src/features/car/domain/localisation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Localisation.fromJson pour tous les champs', () {
    final localisation = Localisation.fromJson(<String, dynamic>{
      'ville': 'Lausanne',
      'canton': 'VD',
      'codePostal': '1003',
      'adresse': 'Rue de Bourg 12',
      'pointRetrait': 'Gare CFF',
    });

    expect(localisation.ville, 'Lausanne');
    expect(localisation.canton, 'VD');
    expect(localisation.codePostal, '1003');
    expect(localisation.adresse, 'Rue de Bourg 12');
    expect(localisation.pointRetrait, 'Gare CFF');
  });
}
