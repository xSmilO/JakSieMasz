import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/Home/Articles/article_widget.dart';
import 'package:jak_sie_masz/UI/Home/viewmodels/articles_viewmodel.dart';
import 'package:provider/provider.dart';

class ArticlesSectionWidget extends StatefulWidget {
  const ArticlesSectionWidget({super.key, required this.viewmodel});
  final ArticlesViewmodel viewmodel;

  @override
  State<ArticlesSectionWidget> createState() => _ArticlesSectionWidgetState();
}

class _ArticlesSectionWidgetState extends State<ArticlesSectionWidget> {
  @override
  void initState() {
    super.initState();
    widget.viewmodel.loadData();
  }

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
            child: Consumer<ArticlesViewmodel>(
              builder: (context, value, child) {
                List<Widget> children = [];

                for (int i = 0; i < value.articles.length; ++i) {
                  children.add(
                    ArticleWidget(
                      title: value.articles[i].title,
                      description: value.articles[i].description,
                      imgUrl: value.articles[i].imgUrl,
                      url: value.articles[i].url,
                    ),
                  );

                  children.add(SizedBox(
                    width: 16,
                  ));
                }

                return ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  children: children,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
