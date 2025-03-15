import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/Shared/widgets/viewmodels/Access_button_viewmodel.dart';
import 'package:provider/provider.dart';

class AccessButtonWidget extends StatelessWidget {
  const AccessButtonWidget(
      {super.key, required this.viewmodel, required this.bottom});

  final AccessButtonViewmodel viewmodel;
  final double bottom;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottom,
      right: 0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 8,
        children: [
          Consumer<AccessButtonViewmodel>(builder: (context, value, child) {
            return value.visible == false
                ? Container()
                : GestureDetector(
                    onTap: () {
                      print("dostepnosc");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Styles.primaryColor500,
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 4),
                            blurRadius: 8,
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      padding: EdgeInsets.all(16),
                      child: SvgPicture.asset(
                        "assets/icons/search.svg",
                        width: 24,
                        height: 24,
                      ),
                    ),
                  );
          }),
          GestureDetector(
            onTap: () {
              viewmodel.show();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Styles.primaryColor500,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 4),
                    blurRadius: 8,
                    spreadRadius: 0,
                  )
                ],
              ),
              padding: EdgeInsets.only(top: 8, bottom: 8, left: 4, right: 2),
              child: SvgPicture.asset(
                "assets/icons/access-arrow.svg",
                width: 24,
                height: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
