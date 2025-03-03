import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jak_sie_masz/UI/AIChat/aichat_screen.dart';
import 'package:jak_sie_masz/UI/Exercises/exercises_screen.dart';
import 'package:jak_sie_masz/UI/Forum/forum_screen.dart';
import 'package:jak_sie_masz/UI/Home/home_screen.dart';
import 'package:jak_sie_masz/UI/Profile/profile_screen.dart';
import 'package:jak_sie_masz/UI/Shared/Layout_widget.dart';
import 'package:jak_sie_masz/routing/routes.dart';
import 'package:provider/provider.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

GoRouter router() => GoRouter(
      initialLocation: Routes.profile,
      debugLogDiagnostics: true,
      navigatorKey: _rootNavigatorKey,
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
                  builder: (context, state) => AIChatScreen(),
                ),
              ],
            )
          ],
        )
      ],
    );
