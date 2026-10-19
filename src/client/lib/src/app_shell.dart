import 'package:car_rent_client/src/common_widgets/liquid_glass_tab_bar.dart';
import 'package:car_rent_client/src/features/car/presentation/cars_list/car_list_screen.dart';
import 'package:car_rent_client/src/features/car/presentation/home_page/home_page_screen.dart';
import 'package:car_rent_client/src/features/profile/profile_screen.dart';
import 'package:car_rent_client/src/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _tabIndex,
        children: [
          HomePageScreen(onSearch: () => setState(() => _tabIndex = 2)),
          const ProfileScreen(),
          const CarsListScreen(),
        ],
      ),
      bottomNavigationBar: LiquidGlassTabBar(
        selectedIndex: _tabIndex,
        onTap: (index) => setState(() => _tabIndex = index),
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
