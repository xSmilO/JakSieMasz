import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/Profile/Dialogs/server_input_dialog_widget.dart';
import 'package:jak_sie_masz/UI/Profile/viewmodels/profile_viewmodel.dart';
import 'package:provider/provider.dart';

class ProfileServerInputWidget extends StatelessWidget {
  const ProfileServerInputWidget({
    super.key,
    required this.viewmodel,
  });
  final ProfileViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (context) => ServerInputDialogWidget(
          currentIpAddr: viewmodel.ipAddr,
          onSubmit: viewmodel.changeIpAddr,
        ),
      ),
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
                Consumer<ProfileViewmodel>(
                  builder: (context, value, child) {
                    return Text(
                      value.ipAddr,
                      style: TextStyle(
                        color: Styles.profileOptionsHeaderColor,
                        fontSize: 10,
                        fontWeight: FontWeight.normal,
                        fontFamily: Styles.fontFamily,
                        decoration: TextDecoration.none,
                      ),
                    );
                  },
                )
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
