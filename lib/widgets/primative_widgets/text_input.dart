import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback submit;
  final String fieldHint;

  const TextInput({
    super.key,
    required this.controller,
    required this.submit,
    required this.fieldHint,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(hintText: fieldHint),
      onSubmitted: (_) => submit(),
    );
  }
}
