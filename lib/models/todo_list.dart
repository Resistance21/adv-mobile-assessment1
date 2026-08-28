import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/services/data_source.dart';

class TodoList extends ChangeNotifier {
  final List<Todo> _todos = [];
  //final DataSource dataSource = Get.find();

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
    //DataSource dataSource = Get.find();
    //await dataSource.edit(todo);
    int index = _todos.indexWhere((element) => element.id == todo.id);
    _todos[index] = todo;
    notifyListeners();
  }

  Future<List<Todo>> refresh() async {
    // DataSource dataSource = Get.find();
    // _todos.clear();
    // _todos.addAll(await dataSource.browse());
    // return _todos;
    return _todos;
  }
}
