import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jak_sie_masz/Styles/styles.dart';

class ProfileDeleteButtonWidget extends StatelessWidget {
  const ProfileDeleteButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("delete user data"),
      child: Container(
        margin: EdgeInsets.only(top: 64),
        decoration: BoxDecoration(
          color: Styles.profileOptionBgColor,
          border: Border.all(
            color: Styles.profileOptoinsBorderColor,
            width: 1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Usuń wszystkie dane",
              style: TextStyle(
                color: Styles.redColor,
                fontFamily: Styles.fontFamily,
                fontWeight: FontWeight.normal,
                fontSize: 12,
                decoration: TextDecoration.none,
              ),
            ),
            SvgPicture.asset(
              "assets/icons/trash.svg",
              width: 16,
              height: 16,
              colorFilter: ColorFilter.mode(
                Styles.redColor,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
