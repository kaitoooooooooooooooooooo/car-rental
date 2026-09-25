import 'package:car_rent_client/src/theme/theme.dart';
import 'package:car_rent_client/src/features/car/domain/car.dart';
import 'package:car_rent_client/src/features/car/domain/photo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CarDetailScreen extends StatefulWidget {
  const CarDetailScreen({super.key, required this.car});

  final Car car;

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  int currentPage = 0;

  List<Photo> get _photos {
    final photos = widget.car.photos.where((p) => !p.principale).toList();
    return photos.isEmpty ? widget.car.photos : photos;
  }

  Widget _buildCarousel() {
    final photos = _photos;

    if (photos.isEmpty) {
      return const SizedBox(
        height: 240,
        child: Center(
          child: Icon(
            Icons.directions_car,
            size: 100,
            color: AppColors.textSecondary,
          ),
        ),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: 240,
          child: PageView.builder(
            itemCount: photos.length,
            onPageChanged: (value) => setState(() => currentPage = value),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(12),
              child: Image.asset(photos[index].url, fit: BoxFit.contain),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            photos.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.only(right: 5),
              height: 6,
              width: currentPage == index ? 20 : 6,
              decoration: BoxDecoration(
                color: currentPage == index
                    ? AppColors.accent
                    : AppColors.textMuted,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          photos[currentPage].legende,
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(
        title,
        style: GoogleFonts.manrope(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.manrope(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 16),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: GoogleFonts.manrope(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final car = widget.car;
    final caracteristiques = car.caracteristiques;
    final tarifs = car.tarifs;
    final conditions = car.conditions;
    final localisation = car.localisation;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceLow,
        foregroundColor: AppColors.textPrimary,
        title: Text(
          '${car.marque} ${car.modele}',
          style: GoogleFonts.manrope(fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          _buildCarousel(),

          _buildSectionTitle('Véhicule'),
          _buildInfoRow('Marque', car.marque),
          _buildInfoRow('Modèle', car.modele),
          _buildInfoRow('Année', car.annee.toString()),
          _buildInfoRow('Catégorie', car.categorie),
          _buildInfoRow('Immatriculation', car.immatriculation),
          _buildInfoRow(
            'Note',
            '${car.note.moyenne} / 5 (${car.note.nombre} avis)',
          ),
          _buildInfoRow('Locations', car.nombreLocations.toString()),

          _buildSectionTitle('Description'),
          Text(
            car.description,
            style: GoogleFonts.manrope(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),

          _buildSectionTitle('Caractéristiques'),
          _buildInfoRow('Transmission', caracteristiques.transmission),
          _buildInfoRow('Carburant', caracteristiques.carburant),
          _buildInfoRow('Places', caracteristiques.places.toString()),
          _buildInfoRow('Portes', caracteristiques.portes.toString()),
          _buildInfoRow('Puissance', '${caracteristiques.puissanceCh} ch'),
          _buildInfoRow('Cylindrée', '${caracteristiques.cylindree} cm3'),
          _buildInfoRow(
            'Consommation',
            '${caracteristiques.consommationMixte} l/100 km',
          ),
          _buildInfoRow('Coffre', '${caracteristiques.coffreLitres} l'),
          _buildInfoRow('Couleur', caracteristiques.couleur),
          _buildInfoRow('Kilométrage', '${caracteristiques.kilometrage} km'),

          _buildSectionTitle('Équipements'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: car.equipements.map((equipement) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.borderSubtle),
                ),
                child: Text(
                  equipement.replaceAll('_', ' '),
                  style: GoogleFonts.manrope(
                    color: AppColors.textPrimary,
                    fontSize: 13,
                  ),
                ),
              );
            }).toList(),
          ),

          _buildSectionTitle('Tarifs'),
          _buildInfoRow('Jour', '${tarifs.devise} ${tarifs.jour}'),
          _buildInfoRow('Semaine', '${tarifs.devise} ${tarifs.semaine}'),
          _buildInfoRow('Mois', '${tarifs.devise} ${tarifs.mois}'),
          _buildInfoRow('Caution', '${tarifs.devise} ${tarifs.caution}'),
          _buildInfoRow(
            'Km inclus / jour',
            '${tarifs.kilometrageInclusParJour} km',
          ),
          _buildInfoRow(
            'Km supplémentaire',
            '${tarifs.devise} ${tarifs.prixKmSupplementaire}',
          ),

          _buildSectionTitle('Conditions'),
          _buildInfoRow('Âge minimum', '${conditions.ageMinimum} ans'),
          _buildInfoRow(
            'Permis depuis',
            '${conditions.anneesPermisMinimum} an(s)',
          ),
          _buildInfoRow(
            'Km max / jour',
            '${conditions.kilometrageMaxParJour} km',
          ),
          _buildInfoRow(
            "Conduite à l'étranger",
            conditions.conduiteEtrangerAutorisee
                ? 'Autorisée'
                : 'Non autorisée',
          ),
          _buildInfoRow(
            'Animaux',
            conditions.animauxAutorises ? 'Autorisés' : 'Non autorisés',
          ),
          _buildInfoRow(
            'Fumeur',
            conditions.fumeurAutorise ? 'Autorisé' : 'Non autorisé',
          ),

          _buildSectionTitle('Localisation'),
          _buildInfoRow(
            'Ville',
            '${localisation.ville} (${localisation.canton})',
          ),
          _buildInfoRow('Code postal', localisation.codePostal),
          _buildInfoRow('Adresse', localisation.adresse),
          _buildInfoRow('Point de retrait', localisation.pointRetrait),
        ],
      ),
    );
  }
}
