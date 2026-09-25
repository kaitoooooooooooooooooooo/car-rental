import 'package:equatable/equatable.dart';

class Localisation extends Equatable {
  final String ville;
  final String canton;
  final String codePostal;
  final String adresse;
  final String pointRetrait;

  const Localisation({
    required this.ville,
    required this.canton,
    required this.codePostal,
    required this.adresse,
    required this.pointRetrait,
  });

  factory Localisation.fromJson(Map<String, dynamic> json) {
    return Localisation(
      ville: json['ville'] as String,
      canton: json['canton'] as String,
      codePostal: json['codePostal'] as String,
      adresse: json['adresse'] as String,
      pointRetrait: json['pointRetrait'] as String,
    );
  }

  @override
  List<Object?> get props => [ville, canton, codePostal, adresse, pointRetrait];
}
