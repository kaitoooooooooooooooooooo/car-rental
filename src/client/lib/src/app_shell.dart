import 'package:car_rent_client/src/common_widgets/liquid_glass_tab_bar.dart';
import 'package:car_rent_client/src/features/car/presentation/cars_list/car_list_screen.dart';
import 'package:car_rent_client/src/features/car/presentation/home_page/home_page_screen.dart';
import 'package:car_rent_client/src/features/profile/profile_screen.dart';
import 'package:car_rent_client/src/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

const searchTab = 2;

final tabIndexProvider = StateProvider<int>((ref) => 0);

class AppShell extends ConsumerWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabIndex = ref.watch(tabIndexProvider);

    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: tabIndex,
        children: const [HomePageScreen(), ProfileScreen(), CarsListScreen()],
      ),
      bottomNavigationBar: LiquidGlassTabBar(
        selectedIndex: tabIndex,
        onTap: (index) => ref.read(tabIndexProvider.notifier).state = index,
        items: const [
          LiquidGlassTabItem(
            icon: CupertinoIcons.house,
            selectedIcon: CupertinoIcons.house_fill,
            label: 'Home',
          ),
          LiquidGlassTabItem(
            icon: CupertinoIcons.person,
            selectedIcon: CupertinoIcons.person_fill,
            label: 'Profile',
          ),
          LiquidGlassTabItem(
            icon: CupertinoIcons.search,
            label: 'Search',
            isSearch: true,
          ),
        ],
      ),
    );
  }
}
