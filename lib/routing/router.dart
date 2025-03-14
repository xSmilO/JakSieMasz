import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jak_sie_masz/Data/services/database_helper_service.dart';
import 'package:jak_sie_masz/Data/services/shared_preferences_service.dart';
import 'package:jak_sie_masz/UI/AIChat/aichat_screen.dart';
import 'package:jak_sie_masz/UI/Exercises/exercises_screen.dart';
import 'package:jak_sie_masz/UI/FirstRate/first_rate_screen.dart';
import 'package:jak_sie_masz/UI/Forum/forum_screen.dart';
import 'package:jak_sie_masz/UI/Home/home_screen.dart';
import 'package:jak_sie_masz/UI/Profile/profile_screen.dart';
import 'package:jak_sie_masz/UI/Shared/Layout_widget.dart';
import 'package:jak_sie_masz/UI/Welcome/welcome_screen.dart';
import 'package:jak_sie_masz/routing/routes.dart';
import 'package:provider/provider.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

DatabaseHelperService databaseHelperService = DatabaseHelperService();

GoRouter router() => GoRouter(
      initialLocation: Routes.home,
      debugLogDiagnostics: true,
      navigatorKey: _rootNavigatorKey,
      redirect: (context, state) async {
        String? username =
            await SharedPreferencesService().fetchString("username");

        if (username == null) {
          return Routes.welcome;
        }

        bool isRated = await databaseHelperService.isCurrentDayRated();

        if (isRated) return null;

        return Routes.firstRate;
      },
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) => LayoutWidget(
            navigationShell: navigationShell,
          ),
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: Routes.home,
                  builder: (context, state) => HomeScreen(
                    userRepository: context.read(),
                    navViewmodel: context.read(),
                  ),
                ),
                GoRoute(
                  path: Routes.profile,
                  builder: (context, state) => ProfileScreen(
                    viewModel: context.read(),
                  ),
                ),
                GoRoute(
                  path: Routes.exercises,
                  builder: (context, state) => ExercisesScreen(),
                ),
                GoRoute(
                  path: Routes.forum,
                  builder: (context, state) => ForumScreen(),
                ),
                GoRoute(
                  path: Routes.aiChat,
                  builder: (context, state) => AIChatScreen(
                    viewModel: context.read(),
                  ),
                ),
              ],
            )
          ],
        ),
        GoRoute(
          path: Routes.welcome,
          builder: (context, state) => WelcomeScreen(
            userRepository: context.read(),
          ),
        ),
        GoRoute(
          path: Routes.firstRate,
          builder: (context, state) => FirstRateScreen(),
        )
      ],
    );
