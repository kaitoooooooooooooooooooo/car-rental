import 'package:car_rent_client/src/features/car/domain/caracteristiques.dart';
import 'package:car_rent_client/src/features/car/domain/conditions.dart';
import 'package:car_rent_client/src/features/car/domain/indisponibilite.dart';
import 'package:car_rent_client/src/features/car/domain/localisation.dart';
import 'package:car_rent_client/src/features/car/domain/note.dart';
import 'package:car_rent_client/src/features/car/domain/photo.dart';
import 'package:car_rent_client/src/features/car/domain/tarifs.dart';
import 'package:equatable/equatable.dart';

class Car extends Equatable {
  final int id;
  final String marque;
  final String modele;
  final int annee;
  final String categorie;
  final String statut;
  final String proprietaireId;
  final String immatriculation;
  final String description;
  final Localisation localisation;
  final Caracteristiques caracteristiques;
  final List<String> equipements;
  final Tarifs tarifs;
  final Conditions conditions;
  final List<Indisponibilite> indisponibilites;
  final List<Photo> photos;
  final Note note;
  final int nombreLocations;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Car({
    required this.id,
    required this.marque,
    required this.modele,
    required this.annee,
    required this.categorie,
    required this.statut,
    required this.proprietaireId,
    required this.immatriculation,
    required this.description,
    required this.localisation,
    required this.caracteristiques,
    required this.equipements,
    required this.tarifs,
    required this.conditions,
    required this.indisponibilites,
    required this.photos,
    required this.note,
    required this.nombreLocations,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'] as int,
      marque: json['marque'] as String,
      modele: json['modele'] as String,
      annee: json['annee'] as int,
      categorie: json['categorie'] as String,
      statut: json['statut'] as String,
      proprietaireId: json['proprietaireId'] as String,
      immatriculation: json['immatriculation'] as String,
      description: json['description'] as String,
      localisation: Localisation.fromJson(json['localisation']),
      caracteristiques: Caracteristiques.fromJson(json['caracteristiques']),
      equipements: List<String>.from(json['equipements']),
      tarifs: Tarifs.fromJson(json['tarifs']),
      conditions: Conditions.fromJson(json['conditions']),
      indisponibilites: (json['indisponibilites'] as List)
          .map((i) => Indisponibilite.fromJson(i))
          .toList(),
      photos: (json['photos'] as List).map((p) => Photo.fromJson(p)).toList(),
      note: Note.fromJson(json['note']),
      nombreLocations: json['nombreLocations'] as int,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  @override
  List<Object?> get props => [
    id,
    marque,
    modele,
    annee,
    categorie,
    statut,
    proprietaireId,
    immatriculation,
    description,
    localisation,
    caracteristiques,
    equipements,
    tarifs,
    conditions,
    indisponibilites,
    photos,
    note,
    nombreLocations,
    createdAt,
    updatedAt,
  ];
}
