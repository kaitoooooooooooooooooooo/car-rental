import 'package:car_rent_client/src/features/car/domain/car.dart';
import 'package:car_rent_client/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _border = BorderSide(width: 2, color: AppColors.borderSubtle);

class FeaturedCarCard extends StatelessWidget {
  const FeaturedCarCard({super.key, required this.car, required this.onTap});

  final Car car;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final title = '${car.marque} ${car.modele}'.toUpperCase();
    final location = '${car.localisation.ville} ${car.localisation.canton}';
    final review = ' ${car.note.moyenne}  ${car.note.nombre} Reviews ';
    final price = '${car.tarifs.devise}  ${car.tarifs.jour} / Day';
    final specs =
        ' Specs : ${car.caracteristiques.places} seats ● ${car.caracteristiques.carburant} ● ${car.categorie}';

    return Card(
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: 400,
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: car.photos.isEmpty
                          ? const SizedBox(
                              height: 240,
                              child: Center(
                                child: Icon(
                                  Icons.directions_car,
                                  size: 100,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            )
                          : Image.asset(
                              car.photos.first.url,
                              fit: BoxFit.contain,
                            ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [Text(price), Text(title)],
                      ),
                    ),
                  ],
                ),
              ),
              Row(children: [Text(specs)]),
              // Row(children: [Text()]),
              const Divider(),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 20,
                    color: AppColors.accent,
                  ),
                  Text(location),
                  SizedBox(width: 16),
                  const Icon(
                    Icons.star_rounded,
                    size: 20,
                    color: AppColors.accent,
                  ),
                  Text(review),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
