import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jak_sie_masz/Styles/styles.dart';

class ProfileServerInputWidget extends StatelessWidget {
  const ProfileServerInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("change server ip"),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 8,
              children: [
                Text(
                  "Adres serwera:",
                  style: TextStyle(
                    color: Styles.profileOptionsHeaderColor,
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                    fontFamily: Styles.fontFamily,
                    decoration: TextDecoration.none,
                  ),
                ),
                Text(
                  "127.0.0.1:5000",
                  style: TextStyle(
                    color: Styles.profileOptionsHeaderColor,
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                    fontFamily: Styles.fontFamily,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
            SvgPicture.asset(
              "assets/icons/edit.svg",
              width: 12,
              height: 12,
              colorFilter: ColorFilter.mode(
                  Styles.profileOptionsHeaderColor, BlendMode.srcIn),
            )
          ],
        ),
      ),
    );
  }
}
