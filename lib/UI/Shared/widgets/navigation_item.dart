import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jak_sie_masz/Styles/styles.dart';

class NavigationItem extends StatefulWidget {
  final String title;
  final String route;
  final String iconUrl;
  const NavigationItem(
      {super.key,
      required this.title,
      required this.route,
      required this.iconUrl});

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
              color: Styles.primaryColor500,
            ),
            Text(
              widget.title,
              style: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
