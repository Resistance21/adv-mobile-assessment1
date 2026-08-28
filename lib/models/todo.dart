import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  bool isComplete;

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
