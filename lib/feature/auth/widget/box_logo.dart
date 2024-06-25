import 'package:flutter/material.dart';

class BoxLogo extends StatelessWidget {
  final String imagePath;

  const BoxLogo({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.asset(
        imagePath,
        height: 20,
      ),
    );
  }
}
