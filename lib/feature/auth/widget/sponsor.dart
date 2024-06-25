import 'package:flutter/material.dart';

class SponsorWidget extends StatelessWidget {
  const SponsorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.25), width: 2),
          borderRadius: BorderRadius.circular(100),
          color: Colors.white),
      padding: const EdgeInsets.all(10),
      child: Image.asset(
        'assets/logo/sponsor.png',
        width: 200,
      ),
    );
  }
}
