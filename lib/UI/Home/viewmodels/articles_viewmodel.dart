import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:jak_sie_masz/Data/article_model.dart';

class ArticlesViewmodel extends ChangeNotifier {
  List<ArticleModel> articles = [];
  ArticlesViewmodel();

  Future<void> loadData() async {
    articles = [];
    final data = await rootBundle.loadString("assets/data/articles.json");
    final jsonArr = jsonDecode(data) as List<dynamic>;

    for (int i = 0; i < jsonArr.length; ++i) {
      articles.add(ArticleModel.fromJson(jsonArr[i]));
    }

    notifyListeners();
  }
}
