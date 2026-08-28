import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/models/todo_list.dart';
import 'package:todo_list/screens/todo_detail_screen.dart';
import 'package:todo_list/widgets/todo_list_view.dart';
import '../widgets/todo_inputfield.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<TodoList>(context, listen: false).refresh();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void addTodo() {
    final text = controller.text.trim();
    if (text.isEmpty) return; // basic validation, from your original spec
    Provider.of<TodoList>(context, listen: false).add(
      Todo(
        id: DateTime.now().toString(), // quick unique-ish id for now
        title: text,
        isComplete: false,
      ),
    );
    controller.clear();
  }

  void editTodo(Todo todo, String newTitle) {
    todo.title = newTitle;
    Provider.of<TodoList>(context, listen: false).update(todo);
  }

  void handleToggle(Todo todo) {
    setState(() {
      todo.isComplete = !todo.isComplete;
    });
  }

  void deleteItem(Todo todo) {
    Provider.of<TodoList>(context, listen: false).delete(todo);
  }

  void onTap(Todo todo) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TodoDetailScreen(todo: todo)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: Column(
        children: [
          TodoInputfield(
            controller: controller,
            submit: addTodo,
            fieldHint: 'Add a Todo',
          ),
          Consumer<TodoList>(
            builder: (context, model, child) {
              return TodoListView(
                todoList: model.todos,
                toggle: handleToggle,
                delete: deleteItem,
                edit: editTodo,
                onTap: onTap,
              );
            },
          ),
        ],
      ),
    );
  }
}
