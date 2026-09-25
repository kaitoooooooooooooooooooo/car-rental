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
      ageMinimum: json['ageMinimum'] as int,
      anneesPermisMinimum: json['anneesPermisMinimum'] as int,
      kilometrageMaxParJour: json['kilometrageMaxParJour'] as int,
      conduiteEtrangerAutorisee: json['conduiteEtrangerAutorisee'] as bool,
      animauxAutorises: json['animauxAutorises'] as bool,
      fumeurAutorise: json['fumeurAutorise'] as bool,
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
