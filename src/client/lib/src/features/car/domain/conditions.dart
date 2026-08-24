import 'package:car_rent_client/src/utils/json_parsers.dart';
import 'package:equatable/equatable.dart';

class Conditions extends Equatable {
  final int ageMinimum;
  final int anneesPermisMinimum;
  final int kilometrageMaxParJour;
  final bool conduiteEtrangerAutorisee;
  final bool animauxAutorises;
  final bool fumeurAutorise;

  const Conditions({
    required this.ageMinimum,
    required this.anneesPermisMinimum,
    required this.kilometrageMaxParJour,
    required this.conduiteEtrangerAutorisee,
    required this.animauxAutorises,
    required this.fumeurAutorise,
  });

  factory Conditions.fromJson(Map<String, dynamic> json) {
    return Conditions(
      ageMinimum: parseInt(json['ageMinimum']),
      anneesPermisMinimum: parseInt(json['anneesPermisMinimum']),
      kilometrageMaxParJour: parseInt(json['kilometrageMaxParJour']),
      conduiteEtrangerAutorisee: json['conduiteEtrangerAutorisee'] ?? false,
      animauxAutorises: json['animauxAutorises'] ?? false,
      fumeurAutorise: json['fumeurAutorise'] ?? false,
    );
  }

  @override
  List<Object?> get props => [
    ageMinimum,
    anneesPermisMinimum,
    kilometrageMaxParJour,
    conduiteEtrangerAutorisee,
    animauxAutorises,
    fumeurAutorise,
  ];
}
