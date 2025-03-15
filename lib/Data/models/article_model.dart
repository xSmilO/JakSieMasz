class ArticleModel {
  final String title;
  final String description;
  final String imgUrl;
  final String url;

  ArticleModel(this.title, this.description, this.imgUrl, this.url);

  ArticleModel.fromJson(Map<String, dynamic> json)
      : title = json['title'] as String,
        description = json['description'] as String,
        imgUrl = json['img_url'] as String,
        url = json['url'] as String;
}
