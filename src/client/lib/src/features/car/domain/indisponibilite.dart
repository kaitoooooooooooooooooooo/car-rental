import 'package:equatable/equatable.dart';

class Indisponibilite extends Equatable {
  final DateTime debut;
  final DateTime fin;
  final String motif;

  const Indisponibilite({
    required this.debut,
    required this.fin,
    required this.motif,
  });

  factory Indisponibilite.fromJson(Map<String, dynamic> json) {
    return Indisponibilite(
      debut: DateTime.parse(json['debut']),
      fin: DateTime.parse(json['fin']),
      motif: json['motif'] as String,
    );
  }

  @override
  List<Object?> get props => [debut, fin, motif];
}
