import 'package:flutter/material.dart';
import 'package:jak_sie_masz/UI/Shared/widgets/navigation_item.dart';
import 'package:jak_sie_masz/routing/routes.dart';

class NavigationWidget extends StatelessWidget {
  const NavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF7CE9B4),
            offset: Offset(0, -4),
            blurRadius: 9,
            spreadRadius: -4,
          )
        ],
      ),
      height: 72,
      child: const Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          NavigationItem(
            title: "ćwiczenia",
            route: Routes.excercises,
            iconUrl: "assets/navigation_icons/excercise.svg",
          ),
          NavigationItem(
            title: "AI chat",
            route: Routes.aiChat,
            iconUrl: "assets/navigation_icons/aichat.svg",
          ),
          NavigationItem(
            title: "Start",
            route: Routes.home,
            iconUrl: "assets/navigation_icons/home.svg",
          ),
          NavigationItem(
            title: "forum",
            route: Routes.forum,
            iconUrl: "assets/navigation_icons/forum.svg",
          ),
          NavigationItem(
            title: "profil",
            route: Routes.profile,
            iconUrl: "assets/navigation_icons/profile.svg",
          ),
        ],
      ),
    );
  }
}
