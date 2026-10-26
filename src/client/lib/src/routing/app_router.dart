import 'package:car_rent_client/src/app_shell.dart';
import 'package:car_rent_client/src/features/car/presentation/car_details/car_detail_screen.dart';
import 'package:go_router/go_router.dart';

enum AppRoute { home, carDetail }

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
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
