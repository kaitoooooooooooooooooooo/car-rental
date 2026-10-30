import 'package:car_rent_client/src/features/car/data/remote/car_service.dart';
import 'package:car_rent_client/src/features/car/presentation/car_details/car_feature_card.dart';
import 'package:car_rent_client/src/features/car/presentation/car_details/car_photo_carousel.dart';
import 'package:car_rent_client/src/features/car/presentation/car_details/car_reviews_card.dart';
import 'package:car_rent_client/src/features/car/presentation/car_details/rental_plan_tile.dart';
import 'package:car_rent_client/src/theme/theme.dart';
import 'package:car_rent_client/src/features/car/domain/car.dart';
import 'package:car_rent_client/src/features/car/domain/photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CarDetailScreen extends ConsumerWidget {
  const CarDetailScreen({super.key, required this.carId});

  final String carId;

  List<Photo> _photosOf(Car car) {
    final photos = car.photos.where((p) => !p.principale).toList();
    return photos.isEmpty ? car.photos : photos;
  }

  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 12),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.manrope(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.manrope(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showConditions(BuildContext context, Car car) {
    final conditions = car.conditions;

    showModalBottomSheet(
      backgroundColor: AppColors.surfaceLow,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Rental conditions'),
              _buildInfoRow('Minimum age', '${conditions.ageMinimum} years'),
              _buildInfoRow(
                'Licence held for',
                '${conditions.anneesPermisMinimum} year(s)',
              ),
              _buildInfoRow(
                'Max km / day',
                '${conditions.kilometrageMaxParJour} km',
              ),
              _buildInfoRow(
                'Driving abroad',
                conditions.conduiteEtrangerAutorisee
                    ? 'Allowed'
                    : 'Not allowed',
              ),
              _buildInfoRow(
                'Pets',
                conditions.animauxAutorises ? 'Allowed' : 'Not allowed',
              ),
              _buildInfoRow(
                'Smoking',
                conditions.fumeurAutorise ? 'Allowed' : 'Not allowed',
              ),
              _buildInfoRow(
                'Deposit',
                '${car.tarifs.devise} ${car.tarifs.caution}',
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carsListValue = ref.watch(carsListFutureProvider);

    return carsListValue.when(
      data: (cars) =>
          _buildDetail(context, cars.firstWhere((car) => car.id == carId)),
      error: (error, stackTrace) => Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: Text(error.toString())),
      ),
      loading: () => const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildDetail(BuildContext context, Car car) {
    final caracteristiques = car.caracteristiques;
    final tarifs = car.tarifs;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Stack(
            children: [
              CarPhotoCarousel(photos: _photosOf(car)),
              Positioned(
                top: MediaQuery.of(context).padding.top + 8,
                left: 16,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.surface,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(
                      Icons.chevron_left,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${car.marque} ${car.modele}',
                        style: GoogleFonts.manrope(
                          color: AppColors.textPrimary,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '${tarifs.devise} ${tarifs.jour}',
                            style: GoogleFonts.manrope(
                              color: AppColors.textPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextSpan(
                            text: '/day',
                            style: GoogleFonts.manrope(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Text(
                  '${car.annee} Model',
                  style: GoogleFonts.manrope(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),

                GestureDetector(
                  onTap: () => _showConditions(context, car),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.accentSoft,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          size: 18,
                          color: AppColors.textPrimary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Check rental conditions before using the car',
                            style: GoogleFonts.manrope(
                              color: AppColors.textPrimary,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          size: 18,
                          color: AppColors.textPrimary,
                        ),
                      ],
                    ),
                  ),
                ),

                _buildSectionTitle('Car Features'),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 2.8,
                  children: [
                    CarFeatureCard(
                      icon: Icons.event_seat_outlined,
                      label: 'Capacity',
                      value: '${caracteristiques.places} Seats',
                    ),
                    CarFeatureCard(
                      icon: Icons.speed_outlined,
                      label: 'Engine Out',
                      value: '${caracteristiques.puissanceCh} HP',
                    ),
                    CarFeatureCard(
                      icon: Icons.local_gas_station_outlined,
                      label: 'Fuel',
                      value: _capitalize(caracteristiques.carburant),
                    ),
                    CarFeatureCard(
                      icon: Icons.settings_outlined,
                      label: 'Gearbox',
                      value: _capitalize(caracteristiques.transmission),
                    ),
                    CarFeatureCard(
                      icon: Icons.water_drop_outlined,
                      label: 'Consumption',
                      value: '${caracteristiques.consommationMixte} L/100',
                    ),
                    CarFeatureCard(
                      icon: Icons.luggage_outlined,
                      label: 'Trunk',
                      value: '${caracteristiques.coffreLitres} L',
                    ),
                  ],
                ),

                _buildSectionTitle('Rental Plan'),
                RentalPlanTile(
                  title: 'Daily Plan',
                  price: '${tarifs.devise} ${tarifs.jour}/day',
                ),
                const SizedBox(height: 10),
                RentalPlanTile(
                  title: 'Weekly Plan',
                  price: '${tarifs.devise} ${tarifs.semaine}/week',
                ),
                const SizedBox(height: 10),
                RentalPlanTile(
                  title: 'Monthly Plan',
                  price: '${tarifs.devise} ${tarifs.mois}/month',
                ),

                _buildSectionTitle('Reviews'),
                CarReviewsCard(
                  note: car.note,
                  nombreLocations: car.nombreLocations,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: AppColors.onAccent,
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              'Book Now',
              style: GoogleFonts.manrope(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
