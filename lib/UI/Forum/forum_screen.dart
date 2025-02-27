import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';

class ForumScreen extends StatelessWidget {
  const ForumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
                color: Styles.primaryColor500,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF7CE9B4),
                    offset: Offset(0, 4),
                    blurRadius: 12,
                    spreadRadius: -1,
                  ),
                ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: Styles.sectionSpacing),
                  child: Text(
                    "Witaj siema",
                    style: TextStyle(
                      fontFamily: Styles.fontFamily,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
