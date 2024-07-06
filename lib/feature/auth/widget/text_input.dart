import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool obscureText;

  const TextInput(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.labelText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey.shade400, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.grey.shade600),
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey.shade600),
              contentPadding: const EdgeInsets.symmetric(vertical: 2),
            ),
          ),
        ),
      ),
    );
  }
}
