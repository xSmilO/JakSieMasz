class ExerciseDataModel {
  final int id;
  final String title;
  final String pathToImage;
  final String description;
  final List<String> tasks;
  final List<String> links;

  ExerciseDataModel({required this.id, required this.title, required this.pathToImage, required this.description, required this.tasks, required this.links});

  static ExerciseDataModel get empty {
    return ExerciseDataModel(
      id: -1,
      title: "",
      pathToImage: "",
      description: "",
      tasks: [],
      links: []
    );
  }
}