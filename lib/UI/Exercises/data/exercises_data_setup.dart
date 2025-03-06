class ExercisesDataSetup {
  final String title;
  final String image;
  final String description;
  final String task_text;
  final List<String> tasks;
  final String link_text;
  final String link_1;
  final String link_2;

  ExercisesDataSetup({required this.title, required this.image, required this.description, required this.task_text, required this.tasks, required this.link_text, required this.link_1, required this.link_2});

  factory ExercisesDataSetup.fromJson(Map<String, dynamic> json) {
    String title = "";
    String image = "";
    String description = "";
    String task_text = "";
    List<String> tasks = [];
    String link_text = "";
    String link_1 = "";
    String link_2 = "";

    if (json.containsKey('title') && json['title'] is String) {
      title = json['title'];
    }
    if (json.containsKey('image') && json['image'] is String) {
      image = json['image'];
    }
    if (json.containsKey('description') && json['description'] is String) {
      description = json['description'];
    }
    if (json.containsKey('task_text') && json['task_text'] is String) {
      task_text = json['task_text'];
    }
    if (json.containsKey('tasks') && json['tasks'] is List) {
      tasks = List<String>.from(json['tasks']);
    }
    if (json.containsKey('link_text') && json['link_text'] is String) {
      link_text = json['link_text'];
    }
    if (json.containsKey('link_1') && json['link_1'] is String) {
      link_1 = json['link_1'];
    }
    if (json.containsKey('link_2') && json['link_2'] is String) {
      link_2 = json['link_2'];
    }

    return ExercisesDataSetup(
      title: title,
      image: image,
      description: description,
      task_text: task_text,
      tasks: tasks,
      link_text: link_text,
      link_1: link_1,
      link_2: link_2
    );
  }
}