class ExercisesDataSetup {
  final String title;
  final String description;
  final String image;
  final String link;

  ExercisesDataSetup({required this.title, required this.description, required this.image, required this.link});

  factory ExercisesDataSetup.fromJson(Map<String, dynamic> json) {
    String title = "";
    String description = "";
    String image = "";
    String link = "";

    if (json.containsKey('title')) {
      title = json['title'];
    }
    if (json.containsKey('description')) {
      description = json['description'];
    }
    if (json.containsKey('image')) {
      image = json['image'];
    }
    if (json.containsKey('link')) {
      link = json['link'];
    }
    return ExercisesDataSetup(
      title: title,
      description: description,
      image: image,
      link: link
    );
  }
}