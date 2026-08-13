import 'package:flutter/material.dart';
import 'package:todo_list/widgets/primative_widgets/text_input.dart';

class TodoInputfield extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback submit;
  final String fieldHint;

  const TodoInputfield({
    super.key,
    required this.controller,
    required this.submit,
    required this.fieldHint,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextInput(
              controller: controller,
              submit: submit,
              fieldHint: fieldHint,
            ),
          ),
          IconButton(onPressed: submit, icon: const Icon(Icons.add)),
        ],
      ),
    );
  }
}
