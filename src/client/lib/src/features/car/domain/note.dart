import 'package:car_rent_client/src/utils/json_parsers.dart';
import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final double moyenne;
  final int nombre;

  const Note({required this.moyenne, required this.nombre});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      moyenne: parseDouble(json['moyenne']),
      nombre: parseInt(json['nombre']),
    );
  }

  @override
  List<Object?> get props => [moyenne, nombre];
}
