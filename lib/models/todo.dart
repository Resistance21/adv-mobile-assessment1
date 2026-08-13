class Todo {
  String id;
  String title;
  bool isComplete;
  String description;

  Todo({
    required this.id,
    required this.title,
    this.isComplete = false,
    this.description = '',
  });
}
