import 'package:car_rent_client/src/theme/theme.dart';
import 'package:flutter/material.dart';

class RecommendedCarsCard extends StatefulWidget {
  const RecommendedCarsCard({super.key});

  @override
  State<RecommendedCarsCard> createState() => _RecommendedCarsCardState();
}

class _RecommendedCarsCardState extends State<RecommendedCarsCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 45, 16, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.borderSubtle),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            const Icon(
                              Icons.notifications_none_rounded,
                              color: AppColors.textPrimary,
                              size: 24,
                            ),
                            Positioned(
                              top: 12,
                              right: 13,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: AppColors.accent,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.surface,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
