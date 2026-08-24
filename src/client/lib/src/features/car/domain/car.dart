import 'package:car_rent_client/src/features/car/domain/caracteristiques.dart';
import 'package:car_rent_client/src/features/car/domain/conditions.dart';
import 'package:car_rent_client/src/features/car/domain/indisponibilite.dart';
import 'package:car_rent_client/src/features/car/domain/localisation.dart';
import 'package:car_rent_client/src/features/car/domain/note.dart';
import 'package:car_rent_client/src/features/car/domain/photo.dart';
import 'package:car_rent_client/src/features/car/domain/tarifs.dart';
import 'package:car_rent_client/src/utils/json_parsers.dart';
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
      id: parseInt(json['id']),
      marque: json['marque'] as String,
      modele: json['modele'] as String,
      annee: parseInt(json['annee']),
      categorie: json['categorie'] ?? '',
      statut: json['statut'] ?? '',
      proprietaireId: parseObjectId(json['proprietaireId']),
      immatriculation: json['immatriculation'] ?? '',
      description: json['description'] ?? '',
      localisation: Localisation.fromJson(json['localisation'] ?? const {}),
      caracteristiques: Caracteristiques.fromJson(
        json['caracteristiques'] ?? const {},
      ),
      equipements: List<String>.from(json['equipements'] ?? const []),
      tarifs: Tarifs.fromJson(json['tarifs'] ?? const {}),
      conditions: Conditions.fromJson(json['conditions'] ?? const {}),
      indisponibilites: ((json['indisponibilites'] ?? const []) as List)
          .map((i) => Indisponibilite.fromJson(i))
          .toList(),
      photos: ((json['photos'] ?? const []) as List)
          .map((p) => Photo.fromJson(p))
          .toList(),
      note: Note.fromJson(json['note'] ?? const {}),
      nombreLocations: parseInt(json['nombreLocations']),
      createdAt: parseDate(json['createdAt']),
      updatedAt: parseDate(json['updatedAt']),
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

