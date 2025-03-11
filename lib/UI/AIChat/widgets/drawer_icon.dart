import 'package:flutter/material.dart';

class DrawerIcon extends StatelessWidget {
  const DrawerIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 18,
            height: 2,
            color: Colors.black,
          ),
          const SizedBox(height: 4),
          Container(
            width: 14,
            height: 2,
            color: Colors.black,
          ),
          const SizedBox(height: 4),
          Container(
            width: 10,
            height: 2,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
