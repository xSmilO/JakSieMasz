import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/Profile/profile_picture_widget.dart';
import 'package:jak_sie_masz/UI/Profile/viewmodels/profile_picture_dialog_viewmodel.dart';
import 'package:provider/provider.dart';

class ProfilePictureDialogWidget extends StatelessWidget {
  ProfilePictureDialogWidget({super.key, required this.viewmodel});
  final ProfilePictureDialogViewmodel viewmodel;
  final List<String> avatars = [
    'assets/avatars/dog.jpg',
    'assets/avatars/cow.png',
    'assets/avatars/penguin.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            Text(
              "Wybierz zdjęcie profilowe",
              style: TextStyle(
                fontFamily: Styles.fontFamily,
                fontWeight: FontWeight.w500,
                fontSize: Styles.fontSizeH3,
                color: Styles.primaryColor500,
              ),
            ),
            Container(
              height: 2,
              color: Color(0xFFD9D9D9),
            ),
            Consumer<ProfilePictureDialogViewmodel>(
              builder: (context, value, child) => Wrap(
                direction: Axis.horizontal,
                spacing: 4,
                runSpacing: 4,
                // crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                children: List.generate(
                  avatars.length,
                  (index) => ProfilePictureWidget(
                    imgUrl: avatars[index],
                    id: index,
                    selectedId: value.selectedIdx,
                    onTap: viewmodel.setSelectedIdx,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8,
              children: [
                TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Styles.secondaryColor100,
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        side: BorderSide(
                          color: Styles.secondaryColor500,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    minimumSize: WidgetStatePropertyAll(
                      Size(10, 10),
                    ),
                    padding: WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    ),
                  ),
                  child: Text(
                    "cofnij",
                    style: TextStyle(
                      fontFamily: Styles.fontFamily,
                      fontWeight: FontWeight.normal,
                      fontSize: Styles.fontSizeP,
                      color: Styles.secondaryColor500,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    print("pick avatar");
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Styles.primaryColor100,
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        side: BorderSide(
                          color: Styles.primaryColor500,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    minimumSize: WidgetStatePropertyAll(
                      Size(10, 10),
                    ),
                    padding: WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                  ),
                  child: Text(
                    "wybierz",
                    style: TextStyle(
                      fontFamily: Styles.fontFamily,
                      fontWeight: FontWeight.normal,
                      fontSize: Styles.fontSizeP,
                      color: Styles.primaryColor500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
