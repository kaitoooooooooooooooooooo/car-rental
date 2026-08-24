import 'package:car_rent_client/src/utils/json_parsers.dart';
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
      debut: parseDate(json['debut']),
      fin: parseDate(json['fin']),
      motif: json['motif'] ?? '',
    );
  }

  @override
  List<Object?> get props => [debut, fin, motif];
}
