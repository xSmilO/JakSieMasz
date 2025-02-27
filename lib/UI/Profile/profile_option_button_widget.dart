import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jak_sie_masz/Styles/styles.dart';

class ProfileOptionButtonWidget extends StatelessWidget {
  const ProfileOptionButtonWidget(
      {super.key,
      required this.title,
      this.border,
      required this.buttonIcon,
      this.titleIcon});
  final String title;
  final String buttonIcon;
  final String? titleIcon;
  final bool? border;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("tapped option"),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: border == true
                ? BorderSide(color: Styles.profileOptoinsBorderColor, width: 1)
                : BorderSide.none,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 8,
              children: [
                titleIcon != null
                    ? SvgPicture.asset(
                        titleIcon!,
                        width: 16,
                        height: 16,
                        colorFilter: ColorFilter.mode(
                            Styles.fontColorDark, BlendMode.srcIn),
                      )
                    : Container(),
                Text(
                  title,
                  style: TextStyle(
                    color: Styles.fontColorDark,
                    fontFamily: Styles.fontFamily,
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
            SvgPicture.asset(
              buttonIcon,
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                  Styles.profileOptionsHeaderColor, BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }
}
