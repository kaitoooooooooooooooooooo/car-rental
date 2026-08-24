import 'package:car_rent_client/src/constants/colors.dart';
import 'package:car_rent_client/src/features/car/data/remote/car_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CarsListScreen extends ConsumerWidget {
  const CarsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carsListValue = ref.watch(carsListFutureProvider);
    const assetName = 'assets/images/app/logo.svg';
    final Widget svg = SvgPicture.asset(assetName, semanticsLabel: 'Dart Logo');
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: Container(margin: EdgeInsets.all(10), child: svg),
        title: Text(
          'Rivano',
          style: GoogleFonts.roboto(fontSize: 30, fontWeight: FontWeight.w700),
        ),
        actions: [
          Icon(Icons.circle_notifications, color: Colors.black, size: 45.0),
          Icon(Icons.account_circle, color: Colors.black, size: 45.0),
        ],
      ),

      body: carsListValue.when(
        data: (cars) => ListView.builder(
          itemCount: cars.length,
          itemBuilder: (context, index) {
            final car = cars[index];
            final photo = car.photos.isEmpty ? null : car.photos.first;
            final asset = photo?.asset;

            return Card(
              margin: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (asset != null && asset.isNotEmpty)
                    Image.asset(asset)
                  else if (photo != null)
                    Image.network(photo.url),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(car.description),
                  ),
                ],
              ),
            );
          },
        ),
        error: (error, _) => Center(child: Text(error.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
