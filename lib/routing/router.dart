import 'package:go_router/go_router.dart';
import 'package:jak_sie_masz/UI/Home/home_screen.dart';
import 'package:jak_sie_masz/UI/Screen1/screen1_screen.dart';
import 'package:jak_sie_masz/routing/routes.dart';

GoRouter router() =>
    GoRouter(initialLocation: Routes.home, debugLogDiagnostics: true, routes: [
      GoRoute(
          path: Routes.screen1,
          builder: (context, state) {
            return Screen1Screen();
          }),
      GoRoute(
        path: Routes.home,
        builder: (context, state) {
          return HomeScreen();
        },
      )
    ]);
