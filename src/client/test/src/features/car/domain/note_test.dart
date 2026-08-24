import 'package:car_rent_client/src/features/car/domain/note.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Note.fromJson pour tous les champs', () {
    final note = Note.fromJson(<String, dynamic>{'moyenne': 4.6, 'nombre': 27});

    expect(note.moyenne, 4.6);
    expect(note.nombre, 27);
  });
}
