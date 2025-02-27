import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/Profile/profile_option_button_widget.dart';

class ProfileOptionsSectionWidget extends StatelessWidget {
  const ProfileOptionsSectionWidget(
      {super.key, required this.buttons, required this.title});
  final String title;
  final List<ProfileOptionButtonWidget> buttons;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            title,
            style: TextStyle(
              fontFamily: Styles.fontFamily,
              fontSize: 10,
              fontWeight: FontWeight.normal,
              color: Styles.profileOptionsHeaderColor,
              decoration: TextDecoration.none,
            ),
          ),
        ),

        //buttons
        Container(
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
          ),
          child: Column(
            children: <Widget>[for (var button in buttons) button],
          ),
        ),
      ],
    );
  }
}
