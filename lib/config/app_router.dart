import 'package:go_router/go_router.dart';
import 'package:track_availability_by_country/screens/tracks/available_countries.dart';
import 'package:track_availability_by_country/screens/tracks/search.dart';
import '../layouts/app_layout.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const AppLayout(child: SearchPage(title: '')),
      ),
      GoRoute(
        path: '/track/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'];
          return AppLayout(child: AvailableCountries(trackId: id!));
        },
      ),
    ],
  );
}
