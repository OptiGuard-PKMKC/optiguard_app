import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black.withOpacity(0.25), width: 2),
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white),
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                'assets/logo/sponsor.png',
                width: 250,
              ),
            ),
            const SizedBox(height: 15),
            Image.asset(
              'assets/logo/vertical-color@6x.png',
              height: 300,
            ),
            const SizedBox(height: 5),
            const Text('For Your Brighter Future',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ))
          ],
        ),
      ),
    );
  }
}
