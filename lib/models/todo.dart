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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'complete': isComplete,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    bool? complete = map['complete'] is bool ? map['complete'] : null;

    complete ??= map['complete'] == 1 ? true : false;

    return Todo(
      id: map['id'].toString(),
      title: map['title'],
      description: map['description'],
      isComplete: complete,
    );
  }
}
