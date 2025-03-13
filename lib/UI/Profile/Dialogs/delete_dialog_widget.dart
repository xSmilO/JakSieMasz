import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jak_sie_masz/Data/services/database_helper_service.dart';
import 'package:jak_sie_masz/Data/services/shared_preferences_service.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:restart_app/restart_app.dart';

class DeleteDialogWidget extends StatelessWidget {
  const DeleteDialogWidget(
      {super.key,
      required this.sharedPreferencesService,
      required this.databaseHelperService});
  final SharedPreferencesService sharedPreferencesService;
  final DatabaseHelperService databaseHelperService;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 16,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "Czy na pewno chcesz ",
                style: TextStyle(
                  color: Styles.fontColorDark,
                  fontFamily: Styles.fontFamily,
                  fontWeight: FontWeight.w500,
                  fontSize: Styles.fontSizeH3,
                ),
                children: [
                  TextSpan(
                    text: "usunąć wszystkie dane ",
                    style: TextStyle(
                      color: Styles.primaryColor500,
                    ),
                  ),
                  TextSpan(
                    text: "?",
                  ),
                ],
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
                    "NIE",
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
                    sharedPreferencesService.deleteData();
                    databaseHelperService.deleteData().then((value) =>
                        Restart.restartApp(
                            notificationTitle: "Zacznij wszystko od początku",
                            notificationBody:
                                "Prosze kliknij aby zacząć przygodę od nowa"));
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
                      EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    ),
                  ),
                  child: Text(
                    "TAK",
                    style: TextStyle(
                      fontFamily: Styles.fontFamily,
                      fontWeight: FontWeight.normal,
                      fontSize: Styles.fontSizeP,
                      color: Styles.primaryColor500,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
