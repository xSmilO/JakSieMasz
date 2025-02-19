import 'package:flutter/material.dart';
import 'package:jak_sie_masz/UI/Shared/widgets/navigation_item.dart';
import 'package:jak_sie_masz/routing/routes.dart';

class NavigationWidget extends StatelessWidget {
  const NavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white10,
      height: 72,
      child: const Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          NavigationItem(
            title: "ćwiczenia",
            route: Routes.home,
            icon: Icons.workspace_premium_outlined,
          ),
          NavigationItem(
            title: "AI chat",
            route: Routes.screen1,
            icon: Icons.access_alarm_outlined,
          ),
          NavigationItem(
            title: "Start",
            route: Routes.screen1,
            icon: Icons.home,
          ),
          NavigationItem(
            title: "forum",
            route: Routes.home,
            icon: Icons.chat,
          ),
          NavigationItem(
            title: "profil",
            route: Routes.home,
            icon: Icons.horizontal_distribute_rounded,
          ),
        ],
      ),
    );
  }
}
