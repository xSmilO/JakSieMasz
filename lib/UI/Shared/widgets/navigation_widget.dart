import 'package:flutter/material.dart';
import 'package:jak_sie_masz/UI/Shared/widgets/navigation_item.dart';
import 'package:jak_sie_masz/UI/Shared/widgets/viewmodels/navigation_viewmodel.dart';
import 'package:jak_sie_masz/routing/routes.dart';
import 'package:provider/provider.dart';

class NavigationWidget extends StatelessWidget {
  const NavigationWidget({super.key, required this.viewModel});

  final NavigationViewmodel viewModel;

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
            color: Color(0x407CE9B4),
            offset: Offset(0, -4),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      height: 72,
      child: Consumer<NavigationViewmodel>(
        builder: (context, viewModel, child) {
          return Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NavigationItem(
                pageIdx: 0,
                callback: viewModel.setPageIdx,
                service: context.read(),
                title: "Ćwiczenia",
                route: Routes.excercises,
                iconUrl: "assets/navigation_icons/excercise.svg",
              ),
              NavigationItem(
                pageIdx: 1,
                service: context.read(),
                callback: viewModel.setPageIdx,
                title: "AI chat",
                route: Routes.aiChat,
                iconUrl: "assets/navigation_icons/aichat.svg",
              ),
              NavigationItem(
                pageIdx: 2,
                service: context.read(),
                callback: viewModel.setPageIdx,
                title: "Start",
                route: Routes.home,
                iconUrl: "assets/navigation_icons/home.svg",
              ),
              NavigationItem(
                pageIdx: 3,
                service: context.read(),
                callback: viewModel.setPageIdx,
                title: "Forum",
                route: Routes.forum,
                iconUrl: "assets/navigation_icons/forum.svg",
              ),
              NavigationItem(
                pageIdx: 4,
                service: context.read(),
                callback: viewModel.setPageIdx,
                title: "Profil",
                route: Routes.profile,
                iconUrl: "assets/navigation_icons/profile.svg",
              ),
            ],
          );
        },
      ),
    );
  }
}
