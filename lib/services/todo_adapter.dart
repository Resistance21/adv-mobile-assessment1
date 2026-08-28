import 'package:hive/hive.dart';
import 'package:todo_list/models/todo.dart';

class TodoAdapter extends TypeAdapter<Todo> {
  @override
  Todo read(BinaryReader reader) {
    return Todo(
      id: reader.read(),
      title: reader.read(),
      description: reader.read(),
      isComplete: reader.read(),
    );
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, Todo obj) {
    writer.write(obj.id);
    writer.write(obj.title);
    writer.write(obj.description);
    writer.write(obj.isComplete);
  }
}
