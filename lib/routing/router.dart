import 'package:go_router/go_router.dart';
import 'package:jak_sie_masz/UI/AIChat/aichat_screen.dart';
import 'package:jak_sie_masz/UI/Excercises/excercises_screen.dart';
import 'package:jak_sie_masz/UI/Forum/forum_screen.dart';
import 'package:jak_sie_masz/UI/Home/home_screen.dart';
import 'package:jak_sie_masz/UI/Profile/profile_screen.dart';
import 'package:jak_sie_masz/routing/routes.dart';

GoRouter router() =>
    GoRouter(initialLocation: Routes.home, debugLogDiagnostics: true, routes: [
      GoRoute(
          path: Routes.excercises,
          builder: (context, state) {
            return ExcercisesScreen();
          }),
      GoRoute(
          path: Routes.aiChat,
          builder: (context, state) {
            return AIChatScreen();
          }),
      GoRoute(
          path: Routes.forum,
          builder: (context, state) {
            return ForumScreen();
          }),
      GoRoute(
          path: Routes.profile,
          builder: (context, state) {
            return ProfileScreen();
          }),
      GoRoute(
        path: Routes.home,
        builder: (context, state) {
          return HomeScreen();
        },
      )
    ]);
