class ExercisesDataSetup {
  final String title;
  final String description;
  final String image;
  final String link;
  final List<String> tasks;

  ExercisesDataSetup({required this.title, required this.description, required this.image, required this.link, required this.tasks});

  factory ExercisesDataSetup.fromJson(Map<String, dynamic> json) {
    String title = "";
    String description = "";
    String image = "";
    String link = "";
    List<String> tasks = [];

    if (json.containsKey('title') && json['title'] is String) {
      title = json['title'];
    }
    if (json.containsKey('description') && json['description'] is String) {
      description = json['description'];
    }
    if (json.containsKey('image') && json['image'] is String) {
      image = json['image'];
    }
    if (json.containsKey('link') && json['link'] is String) {
      link = json['link'];
    }
    if (json.containsKey('tasks') && json['tasks'] is List) {
      tasks = List<String>.from(json['tasks']);
    }

    return ExercisesDataSetup(
      title: title,
      description: description,
      image: image,
      link: link,
      tasks: tasks
    );
  }
}