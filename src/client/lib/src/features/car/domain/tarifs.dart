import 'package:car_rent_client/src/utils/json_parsers.dart';
import 'package:equatable/equatable.dart';

class Tarifs extends Equatable {
  final String devise;
  final int jour;
  final int semaine;
  final int mois;
  final int caution;
  final int kilometrageInclusParJour;
  final double prixKmSupplementaire;

  const Tarifs({
    required this.devise,
    required this.jour,
    required this.semaine,
    required this.mois,
    required this.caution,
    required this.kilometrageInclusParJour,
    required this.prixKmSupplementaire,
  });

  factory Tarifs.fromJson(Map<String, dynamic> json) {
    return Tarifs(
      devise: json['devise'] ?? 'CHF',
      jour: parseInt(json['jour']),
      semaine: parseInt(json['semaine']),
      mois: parseInt(json['mois']),
      caution: parseInt(json['caution']),
      kilometrageInclusParJour: parseInt(json['kilometrageInclusParJour']),
      prixKmSupplementaire: parseDouble(json['prixKmSupplementaire']),
    );
  }

  @override
  List<Object?> get props => [
    devise,
    jour,
    semaine,
    mois,
    caution,
    kilometrageInclusParJour,
    prixKmSupplementaire,
  ];
}
