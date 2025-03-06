import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jak_sie_masz/Data/navigation_service.dart';
import 'package:jak_sie_masz/Styles/styles.dart';

class NavigationItem extends StatefulWidget {
  final int pageIdx;
  final String title;
  final String route;
  final String iconUrl;
  final Function(int idx) callback;
  final NavigationService service;

  const NavigationItem({
    super.key,
    required this.pageIdx,
    required this.title,
    required this.route,
    required this.iconUrl,
    required this.callback,
    required this.service,
  });
  @override
  State<NavigationItem> createState() => _NavigationItemState();
}

class _NavigationItemState extends State<NavigationItem> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: TextButton(
        onPressed: () {
          widget.callback(widget.pageIdx);
          context.go(widget.route);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            SvgPicture.asset(
              widget.iconUrl,
              width: 24,
              height: 24,
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                widget.service.selectedPageIdx == widget.pageIdx
                    ? Styles.primaryColor500
                    : Styles.inactiveNavItem,
                BlendMode.srcIn,
              ),
            ),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 10,
                color: widget.service.selectedPageIdx == widget.pageIdx
                    ? Styles.primaryColor500
                    : Styles.inactiveNavItem,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
