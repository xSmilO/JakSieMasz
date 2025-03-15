import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/Profile/Dialogs/ai_name_dialog_widget.dart';
import 'package:jak_sie_masz/UI/Profile/Dialogs/profile_picture_dialog_widget.dart';
import 'package:jak_sie_masz/UI/Profile/Dialogs/username_dialog_widget.dart';
import 'package:jak_sie_masz/UI/Profile/profile_delete_button_widget.dart';
import 'package:jak_sie_masz/UI/Profile/profile_option_button_widget.dart';
import 'package:jak_sie_masz/UI/Profile/profile_options_section_widget.dart';
import 'package:jak_sie_masz/UI/Profile/profile_server_input_widget.dart';
import 'package:jak_sie_masz/UI/Profile/viewmodels/profile_viewmodel.dart';
import 'package:jak_sie_masz/UI/Shared/widgets/access_button_widget.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.viewModel});
  final ProfileViewmodel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel.loadUserData();
    Future changeUsernameDialog() => showDialog(
          context: context,
          builder: (context) => UsernameDialogWidget(
            currentUserName: viewModel.username,
            onSubmit: viewModel.changeName,
          ),
        );

    Future changeAINameDialog() => showDialog(
        context: context,
        builder: (context) => AiNameDialogWidget(
            currentAIName: viewModel.aiName, onSubmit: viewModel.changeAiName));

    return Container(
      color: Styles.primaryColor500,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 300,
                child: Center(
                  child: Consumer<ProfileViewmodel>(
                    builder: (context, value, child) {
                      return Column(
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
                              //todo change to selected
                              // "assets/avatars/dog.jpg",
                              value.avatarPath == ""
                                  ? "assets/avatars/dog.jpg"
                                  : value.avatarPath,
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
                      );
                    },
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
                              onTap: () => {changeUsernameDialog()},
                            ),
                            ProfileOptionButtonWidget(
                              title: "Zmień awatar",
                              buttonIcon: "assets/icons/arrow-right.svg",
                              titleIcon: "assets/icons/edit.svg",
                              onTap: () => {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      ProfilePictureDialogWidget(
                                    viewmodel: context.read(),
                                  ),
                                )
                              },
                            ),
                          ],
                        ),
                        ProfileOptionsSectionWidget(
                          title: "Przypomnienia",
                          buttons: [
                            ProfileOptionButtonWidget(
                              onTap: () async {
                                TimeOfDay? picked = await showTimePicker(
                                  helpText: "Godzina przypomnienia",
                                  context: context,
                                  initialTime: viewModel.selectedTime ??
                                      TimeOfDay(hour: 14, minute: 0),
                                );

                                if (picked == null) {
                                  return;
                                }

                                await viewModel.setNotificaion(picked);

                                if (context.mounted == true)
                                  toastification.show(
                                    context: context,
                                    title: Text(
                                      "Ustawiono nową godzine przypomnienia",
                                      style: TextStyle(
                                        color: Styles.fontColorDark,
                                        fontFamily: Styles.fontFamily,
                                        fontSize: Styles.fontSizeP,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    autoCloseDuration: Duration(seconds: 3),
                                  );
                              },
                              title: "Godzina oceny dnia",
                              buttonIcon: "assets/icons/arrow-right.svg",
                              titleIcon: "assets/icons/clock.svg",
                            ),
                          ],
                        ),
                        ProfileOptionsSectionWidget(
                          title: "Ustawienia AI",
                          buttons: [
                            ProfileOptionButtonWidget(
                              onTap: () {
                                changeAINameDialog();
                              },
                              title: "Zmień nazwe AI przyjaciela",
                              buttonIcon: "assets/icons/arrow-right.svg",
                              titleIcon: "assets/icons/robot.svg",
                            ),
                          ],
                        ),
                        ProfileDeleteButtonWidget(),
                        ProfileServerInputWidget(
                          viewmodel: viewModel,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          AccessButtonWidget(
            viewmodel: context.read(),
            bottom: 32,
          ),
        ],
      ),
    );
  }
}
