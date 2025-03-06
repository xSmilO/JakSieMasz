import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/Home/Articles/article_widget.dart';

class ArticlesSectionWidget extends StatelessWidget {
  const ArticlesSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Styles.sectionSpacing),
      child: Column(
        spacing: 72,
        children: [
          Row(
            spacing: 6,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Polecane",
                style: TextStyle(
                  color: Styles.fontColorDark,
                  fontFamily: Styles.fontFamily,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  fontSize: Styles.fontSizeH3,
                ),
              ),
              Text(
                "artykuły",
                style: TextStyle(
                  color: Styles.fontColorDark,
                  fontFamily: Styles.fontFamily,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  fontSize: Styles.fontSizeH3,
                ),
              ),
              Text(
                "o",
                style: TextStyle(
                  color: Styles.fontColorDark,
                  fontFamily: Styles.fontFamily,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  fontSize: Styles.fontSizeH3,
                ),
              ),
              Text(
                "zdrowiu",
                style: TextStyle(
                  color: Styles.primaryColor500,
                  fontFamily: Styles.fontFamily,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  fontSize: Styles.fontSizeH3,
                ),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  margin: EdgeInsets.only(top: 2),
                  color: Styles.primaryColor500,
                ),
              )
            ],
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 240,
            ),
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              children: [
                ArticleWidget(
                  title: "Problem ze stresem ?",
                  description:
                      "Naukowcy z Ameryki prkeprowadzili badania na temat radzenia sobie ze stresem.",
                ),
                SizedBox(
                  width: 16,
                ),
                ArticleWidget(
                  title: "Problem ze stresem ?",
                  description:
                      "Naukowcy z Ameryki prkeprowadzili badania na temat radzenia sobie ze stresem.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
