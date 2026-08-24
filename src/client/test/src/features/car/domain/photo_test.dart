import 'package:car_rent_client/src/features/car/domain/photo.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Photo.fromJson pour tous les champs', () {
    final photo = Photo.fromJson(<String, dynamic>{
      'url': 'https://cdn.example.com/car-1.jpg',
      'legende': 'Vue avant',
      'principale': true,
      'ordre': 1,
      'asset': 'assets/images/car-1.jpg',
    });

    expect(photo.url, 'https://cdn.example.com/car-1.jpg');
    expect(photo.legende, 'Vue avant');
    expect(photo.principale, isTrue);
    expect(photo.ordre, 1);
    expect(photo.asset, 'assets/images/car-1.jpg');
  });
}
