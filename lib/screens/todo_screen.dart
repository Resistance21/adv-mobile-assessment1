import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/screens/todo_detail_screen.dart';
import 'package:todo_list/widgets/todo_list_view.dart';
import '../widgets/todo_inputfield.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  Todo todo = Todo(id: '1', title: 'item 1', isComplete: false);
  List<Todo> todoList = [];
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    todoList.add(todo);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void addTodo() {
    final text = controller.text.trim();
    if (text.isEmpty) return; // basic validation, from your original spec

    setState(() {
      todoList.add(
        Todo(
          id: DateTime.now().toString(), // quick unique-ish id for now
          title: text,
          isComplete: false,
        ),
      );
      controller.clear();
    });
  }

  void editTodo(Todo todo, String newTitle) {
    setState(() {
      todo.title = newTitle;
    });
  }

  void handleToggle(Todo todo) {
    setState(() {
      todo.isComplete = !todo.isComplete;
    });
  }

  void deleteItem(Todo todo) {
    setState(() {
      todoList.remove(todo);
    });
  }

  void onTap(Todo todo) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TodoDetailScreen(todo: todo)),
    );
    if (result != null) {
      setState(() {
        todo.title = result['title'];
        todo.description = result['description'];
      });
    }
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
          TodoListView(
            todoList: todoList,
            toggle: handleToggle,
            delete: deleteItem,
            edit: editTodo,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
