import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final double moyenne;
  final int nombre;

  const Note({required this.moyenne, required this.nombre});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      moyenne: (json['moyenne'] as num).toDouble(),
      nombre: json['nombre'] as int,
    );
  }

  @override
  List<Object?> get props => [moyenne, nombre];
}
