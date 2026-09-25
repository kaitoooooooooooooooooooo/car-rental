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
      transmission: json['transmission'] as String,
      carburant: json['carburant'] as String,
      places: json['places'] as int,
      portes: json['portes'] as int,
      puissanceCh: json['puissanceCh'] as int,
      cylindree: json['cylindree'] as int,
      consommationMixte: (json['consommationMixte'] as num).toDouble(),
      coffreLitres: json['coffreLitres'] as int,
      couleur: json['couleur'] as String,
      kilometrage: json['kilometrage'] as int,
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
