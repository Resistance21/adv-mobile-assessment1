import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:todo_list/models/todo.dart';

class TodoList extends ChangeNotifier {
  final List<Todo> _todos = [];

  UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);

  int get todoCount => _todos.length;

  void add(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void removeAll() {
    _todos.clear();
    notifyListeners();
  }

  void delete(Todo todo) {
    _todos.removeWhere((e) => e.id == todo.id);
    notifyListeners();
  }

  void update(Todo todo) {
    int index = _todos.indexWhere(
      (element) => element.title.toLowerCase() == todo.title.toLowerCase(),
    );
    _todos[index] = todo;
    notifyListeners();
  }
}
