import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/services/data_source.dart';

class SqliteDataSource implements DataSource {
  late Database _database;

  Future initalise() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'todo_data.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE IF NOT EXISTS todos (id INTEGER PRIMARY KEY, title TEXT, description TEXT, complete INTEGER)',
        );
      },
    );
  }

  static Future<DataSource> createAsync() async {
    SqliteDataSource dataSource = SqliteDataSource();
    await dataSource.initalise();
    return dataSource;
  }

  @override
  Future<List<Todo>> browse() async {
    List<Map<String, dynamic>> maps = await _database.query('todos');
    return List.generate(maps.length, (index) {
      return Todo.fromMap(maps[index]);
    });
  }

  @override
  Future<bool> add(Todo model) async {
    Map<String, dynamic> editedMap = model.toMap();
    editedMap.remove('id');
    int result = await _database.insert('todos', editedMap);
    return result > 0;
  }

  @override
  Future<bool> delete(Todo model) async {
    Map<String, dynamic> todo = model.toMap();
    int result = await _database.delete(
      'todos',
      where: 'id',
      whereArgs: todo['id'],
    );
    return result > 0;
  }

  @override
  Future<bool> edit(Todo model) async {
    Map<String, dynamic> todo = model.toMap();
    int result = await _database.update(
      'todos',
      todo,
      where: 'id',
      whereArgs: todo['id'],
    );
    return result > 0;
  }

  @override
  Future<Todo?> read(String id) async {
    final todo = await _database.query('todos', where: 'id', whereArgs: [id]);
    return todo.isEmpty ? null : Todo.fromMap(todo[0]);
  }
}
