import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/Shared/widgets/navigation_widget.dart';
import 'package:provider/provider.dart';

class LayoutWidget extends StatelessWidget {
  const LayoutWidget({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Styles.bgColor,
      child: Column(
        children: [
          Expanded(
            child: navigationShell,
          ),
          NavigationWidget(
            viewModel: context.read(),
          ),
        ],
      ),
    );
  }
}
