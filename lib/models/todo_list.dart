import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/services/data_source.dart';

class TodoList extends ChangeNotifier {
  final List<Todo> _todos = [];
  final DataSource dataSource = Get.find();

  UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);

  int get todoCount => _todos.length;

  Future<void> add(Todo todo) async {
    //_todos.add(todo);
    debugPrint('ADDING TO DO');
    await dataSource.add(todo);
    await refresh();
  }

  // Future<void> removeAll() async {
  //   //_todos.clear();
  //   await dataSource.da;
  //   notifyListeners();
  // }

  Future<void> delete(Todo todo) async {
    await dataSource.delete(todo);
    //_todos.removeWhere((e) => e.id == todo.id);
    await refresh();
  }

  Future<void> update(Todo todo) async {
    await dataSource.edit(todo);
    int index = _todos.indexWhere((element) => element.id == todo.id);
    _todos[index] = todo;
    await refresh();
  }

  Future<List<Todo>> refresh() async {
    _todos.clear();
    _todos.addAll(await dataSource.browse());
    notifyListeners();
    return _todos;
  }
}
