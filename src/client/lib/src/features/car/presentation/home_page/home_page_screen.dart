import 'package:car_rent_client/src/features/car/presentation/home_page/recommended_cars_card.dart';
import 'package:car_rent_client/src/theme/theme.dart';
import 'package:car_rent_client/src/app_shell.dart';
import 'package:car_rent_client/src/features/car/presentation/home_page/booking_search_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

const _firstName = 'Tom Tom';

class HomePageScreen extends ConsumerStatefulWidget {
  const HomePageScreen({super.key});

  @override
  ConsumerState<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends ConsumerState<HomePageScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Good morning, $_firstName',
                              style: GoogleFonts.manrope(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Find the perfect car',
                              style: GoogleFonts.manrope(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
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
                  const SizedBox(height: 24),
                  const BookingSearchCard(),

                  const SizedBox(height: 28),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Recommended cars',
                              style: GoogleFonts.manrope(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Top picks based on driver rating',
                              style: GoogleFonts.manrope(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                            ref.read(tabIndexProvider.notifier).state =
                                searchTab,
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.accent,
                        ),
                        child: Text(
                          'See all',
                          style: GoogleFonts.manrope(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
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
