import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class NavigationItem extends StatefulWidget {
  final String title;
  final String route;
  final IconData icon;
  const NavigationItem(
      {super.key,
      required this.title,
      required this.route,
      required this.icon});

  @override
  State<NavigationItem> createState() => _NavigationItemState();
}

class _NavigationItemState extends State<NavigationItem> {
  @override
  initState() {
    super.initState();
  }

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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              widget.icon,
              size: 32,
            ),
            Text(
              widget.title,
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
