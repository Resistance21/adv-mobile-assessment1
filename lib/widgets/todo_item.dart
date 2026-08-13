import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';

class TodoItem extends StatefulWidget {
  final Todo todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final Function(Todo, String) onEdit;
  final VoidCallback onTap;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
    required this.onTap,
  });

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool isEditing = false;
  late TextEditingController editController;

  @override
  void initState() {
    super.initState();
    editController = TextEditingController(text: widget.todo.title);
  }

  @override
  void didUpdateWidget(TodoItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!isEditing) {
      editController.text = widget.todo.title;
    }
  }

  @override
  void dispose() {
    editController.dispose();
    super.dispose();
  }

  void saveEdit() {
    final text = editController.text.trim();
    if (text.isNotEmpty) {
      widget.onEdit(widget.todo, text);
    }
    setState(() {
      isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isEditing) {
      return ListTile(
        title: TextField(
          controller: editController,
          autofocus: true,
          onSubmitted: (_) => saveEdit(),
          decoration: const InputDecoration(hintText: 'Edit todo'),
        ),
        trailing: IconButton(
          onPressed: saveEdit,
          icon: const Icon(Icons.check),
        ),
      );
    }

    return ListTile(
      onTap: widget.onTap,
      title: Text(
        widget.todo.title,
        style: TextStyle(
          decoration: widget.todo.isComplete
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
      leading: Checkbox(
        value: widget.todo.isComplete,
        onChanged: (_) => widget.onToggle(),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => setState(() {
              isEditing = true;
            }),
          ),
          IconButton(icon: Icon(Icons.delete), onPressed: widget.onDelete),
        ],
      ),
      tileColor: widget.todo.isComplete ? Colors.green : null,
    );
  }
}
