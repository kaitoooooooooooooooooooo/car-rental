import 'package:car_rent_client/src/app_shell.dart';
import 'package:car_rent_client/src/features/car/presentation/car_details/car_detail_screen.dart';
import 'package:car_rent_client/src/features/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

enum AppRoute { splash, home, carDetail }

bool splashShown = false;

final goRouter = GoRouter(
  initialLocation: '/splash',
  debugLogDiagnostics: true,
  redirect: (context, state) {
    if (!splashShown && state.matchedLocation != '/splash') return '/splash';
    return null;
  },
  routes: [
    GoRoute(
      path: '/splash',
      name: AppRoute.splash.name,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      builder: (context, state) => const AppShell(),
      routes: [
        GoRoute(
          path: 'car/:id',
          name: AppRoute.carDetail.name,
          builder: (context, state) {
            final carId = state.pathParameters['id']!;
            return CarDetailScreen(carId: carId);
          },
        ),
      ],
    ),
  ],
);
