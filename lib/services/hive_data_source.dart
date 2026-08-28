import 'package:hive_flutter/adapters.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/services/data_source.dart';
import 'package:todo_list/services/todo_adapter.dart';

class HiveDataSource implements DataSource {
  late Box<Todo> box;

  Future initalise() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TodoAdapter());
    box = await Hive.openBox<Todo>('todos');
  }

  static Future<DataSource> createAsync() async {
    HiveDataSource dataSource = HiveDataSource();
    await dataSource.initalise();
    return dataSource;
  }

  @override
  Future<bool> add(Todo model) async {
    int key = await box.add(model);
    model.id = key.toString();
    await box.put(key, model);
    return true;
  }

  @override
  Future<List<Todo>> browse() async {
    return box.values.toList();
  }

  @override
  Future<bool> delete(Todo model) async {
    await box.delete(int.parse(model.id));
    return true;
  }

  @override
  Future<bool> edit(Todo model) async {
    await box.put(int.parse(model.id), model);
    return true;
  }

  @override
  Future<Todo?> read(String id) async {
    return box.get(int.parse(id));
  }
}
