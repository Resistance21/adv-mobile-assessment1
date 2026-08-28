import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/models/todo_list.dart';

class TodoDetailScreen extends StatefulWidget {
  final Todo todo;

  const TodoDetailScreen({super.key, required this.todo});

  @override
  State<TodoDetailScreen> createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends State<TodoDetailScreen> {
  late TextEditingController discriptionController;
  late TextEditingController titleController;

  @override
  void initState() {
    super.initState();
    discriptionController = TextEditingController(
      text: widget.todo.description,
    );

    titleController = TextEditingController(text: widget.todo.title);

    titleController.addListener(() {
      setState(
        () {},
      ); // empty setState — just triggers rebuild so AppBar updates
    });
  }

  void saveChanges() {
    widget.todo.description = discriptionController.text;
    widget.todo.title = titleController.text;
    Provider.of<TodoList>(context, listen: false).update(widget.todo);
    Navigator.pop(context, {
      // 'title': titleController.text,
      // 'description': discriptionController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titleController.text)),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              style: const TextStyle(
                color: Colors.black,
              ), // match AppBar text color
              decoration: const InputDecoration(
                border: InputBorder
                    .none, // removes the underline, looks cleaner in AppBar
                hintText: 'Todo title',
                hintStyle: TextStyle(color: Colors.black),
              ),
            ),

            TextField(
              controller: discriptionController,
              minLines: 3,
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),

            IconButton(onPressed: saveChanges, icon: const Icon(Icons.check)),
          ],
        ),
      ),
    );
  }
}
