import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/Home/Articles/article_button_widget.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 240,
      padding: EdgeInsets.all(16),
      clipBehavior: Clip.none,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF7CE9B4),
            offset: Offset(0, 2),
            blurRadius: 4,
            spreadRadius: -1,
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -64,
            child: Container(
              margin: EdgeInsets.only(bottom: 60),
              height: 112,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF7CE9B4),
                    offset: Offset(0, 2),
                    blurRadius: 4,
                    spreadRadius: -1,
                  ),
                ],
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                "assets/images/article-1.jpg",
                fit: BoxFit.fill,
                color: Styles.primaryColor500.withAlpha(178),
                colorBlendMode: BlendMode.srcOver,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 64),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Styles.fontColorDark,
                        fontFamily: Styles.fontFamily,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        color: Styles.fontColorDark,
                        fontFamily: Styles.fontFamily,
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
                ArticleButtonWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
