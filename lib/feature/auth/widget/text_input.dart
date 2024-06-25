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
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade600, width: 2)),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.grey.shade600),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade600),
        ),
      ),
    );
  }
}
