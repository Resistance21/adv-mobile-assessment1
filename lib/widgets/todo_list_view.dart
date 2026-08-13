import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/widgets/todo_item.dart';

class TodoListView extends StatelessWidget {
  final List<Todo> todoList;
  final Function(Todo) toggle;
  final Function(Todo) delete;
  final Function(Todo, String) edit;
  final Function(Todo) onTap;

  const TodoListView({
    super.key,
    required this.todoList,
    required this.toggle,
    required this.delete,
    required this.edit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          final todo = todoList[index];
          return TodoItem(
            key: ValueKey(todo.id),
            todo: todo,
            onToggle: () => toggle(todo),
            onDelete: () => delete(todo),
            onEdit: edit,
            onTap: () => onTap(todo),
          );
        },
      ),
    );
  }
}
