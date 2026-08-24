import 'package:car_rent_client/src/utils/json_parsers.dart';
import 'package:equatable/equatable.dart';

class Caracteristiques extends Equatable {
  final String transmission;
  final String carburant;
  final int places;
  final int portes;
  final int puissanceCh;
  final int cylindree;
  final double consommationMixte;
  final int coffreLitres;
  final String couleur;
  final int kilometrage;

  const Caracteristiques({
    required this.transmission,
    required this.carburant,
    required this.places,
    required this.portes,
    required this.puissanceCh,
    required this.cylindree,
    required this.consommationMixte,
    required this.coffreLitres,
    required this.couleur,
    required this.kilometrage,
  });

  factory Caracteristiques.fromJson(Map<String, dynamic> json) {
    return Caracteristiques(
      transmission: json['transmission'] ?? '',
      carburant: json['carburant'] ?? '',
      places: parseInt(json['places']),
      portes: parseInt(json['portes']),
      puissanceCh: parseInt(json['puissanceCh']),
      cylindree: parseInt(json['cylindree']),
      consommationMixte: parseDouble(json['consommationMixte']),
      coffreLitres: parseInt(json['coffreLitres']),
      couleur: json['couleur'] ?? '',
      kilometrage: parseInt(json['kilometrage']),
    );
  }

  @override
  List<Object?> get props => [
    transmission,
    carburant,
    places,
    portes,
    puissanceCh,
    cylindree,
    consommationMixte,
    coffreLitres,
    couleur,
    kilometrage,
  ];
}
