import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget(
      {super.key,
      required this.imgUrl,
      required this.id,
      required this.onTap,
      required this.selectedId});

  final String imgUrl;
  final int id;
  final int selectedId;
  final void Function(int idx) onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
        color: selectedId == id ? Styles.primaryColor500 : Colors.transparent,
      ),
      child: GestureDetector(
        onTap: () {
          onTap(id);
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            color: Styles.bgColor,
          ),
          child: Image.asset(
            imgUrl,
            width: 64,
            height: 64,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
