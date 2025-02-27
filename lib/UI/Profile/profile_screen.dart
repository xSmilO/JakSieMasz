import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/Profile/profile_delete_button_widget.dart';
import 'package:jak_sie_masz/UI/Profile/profile_option_button_widget.dart';
import 'package:jak_sie_masz/UI/Profile/profile_options_section_widget.dart';
import 'package:jak_sie_masz/UI/Profile/profile_server_input_widget.dart';
import 'package:jak_sie_masz/UI/Profile/viewmodels/profile_viewmodel.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.viewModel});
  final ProfileViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Styles.primaryColor500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 300,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100)),
                    width: 96,
                    height: 96,
                    child: Image.asset(
                      "assets/avatars/default.jpg",
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text(
                    viewModel.username,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: Styles.fontFamily,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: Styles.fontSizeH1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x40000000),
                    offset: Offset(0, -4),
                    blurRadius: 30,
                    spreadRadius: 4,
                  )
                ],
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 48),
                child: Column(
                  spacing: 16,
                  children: [
                    ProfileOptionsSectionWidget(
                      title: "Edytuj profil",
                      buttons: [
                        ProfileOptionButtonWidget(
                          title: "Zmień nazwe",
                          border: true,
                          buttonIcon: "assets/icons/arrow-right.svg",
                          titleIcon: "assets/icons/edit.svg",
                        ),
                        ProfileOptionButtonWidget(
                          title: "Zmień awatar",
                          buttonIcon: "assets/icons/arrow-right.svg",
                          titleIcon: "assets/icons/edit.svg",
                        ),
                      ],
                    ),
                    ProfileOptionsSectionWidget(
                      title: "Przypomnienia",
                      buttons: [
                        ProfileOptionButtonWidget(
                          title: "Godzina oceny dnia",
                          buttonIcon: "assets/icons/arrow-right.svg",
                          titleIcon: "assets/icons/clock.svg",
                        ),
                      ],
                    ),
                    ProfileDeleteButtonWidget(),
                    ProfileServerInputWidget()
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
