import 'package:car_rent_client/src/features/car/domain/photo.dart';
import 'package:car_rent_client/src/theme/theme.dart';
import 'package:flutter/material.dart';

class CarPhotoCarousel extends StatefulWidget {
  const CarPhotoCarousel({super.key, required this.photos});

  final List<Photo> photos;

  @override
  State<CarPhotoCarousel> createState() => _CarPhotoCarouselState();
}

class _CarPhotoCarouselState extends State<CarPhotoCarousel> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final photos = widget.photos;

    if (photos.isEmpty) {
      return const SizedBox(
        height: 300,
        child: Center(
          child: Icon(
            Icons.directions_car,
            size: 100,
            color: AppColors.textSecondary,
          ),
        ),
      );
    }

    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          PageView.builder(
            itemCount: photos.length,
            onPageChanged: (value) => setState(() => currentPage = value),
            itemBuilder: (context, index) => Image.asset(
              photos[index].url,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                photos.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  height: 6,
                  width: currentPage == index ? 20 : 6,
                  decoration: BoxDecoration(
                    color: currentPage == index
                        ? AppColors.accent
                        : AppColors.accentLight,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
