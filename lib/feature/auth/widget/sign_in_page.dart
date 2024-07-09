import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optiguard/feature/auth/widget/box_logo.dart';
import 'package:optiguard/feature/auth/widget/logo.dart';
import 'package:optiguard/feature/auth/widget/sponsor.dart';
import 'package:optiguard/feature/auth/widget/text_input.dart';
import 'package:optiguard/shared/constants/app_theme.dart';
import 'package:optiguard/shared/route/app_router.dart';

class SignInPage extends ConsumerWidget {
  SignInPage({super.key});
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 25),
              // sponsor
              const SponsorWidget(),

              const SizedBox(height: 15),

              // logo
              const LogoWidget(),

              const SizedBox(height: 10),

              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // text
                        const Text(
                          'Masuk ke akun Anda',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // form
                        TextInput(
                          controller: _emailController,
                          labelText: 'Email',
                          hintText: 'Masukan email',
                          obscureText: false,
                        ),

                        const SizedBox(height: 14),

                        TextInput(
                          controller: _passwordController,
                          labelText: 'Password',
                          hintText: 'Masukan password',
                          obscureText: true,
                        ),

                        // button
                        const SizedBox(height: 14),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                            height: 44,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0, // Disable elevation
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () {
                                ref
                                    .read(routerProvider)
                                    .go(MainPatientRoute.path);
                              },
                              child: const Text(
                                'Masuk',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 25),

                        // other methods
                        const Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'atau masuk dengan',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        // other methods(googles)
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BoxLogo(imagePath: 'assets/logo/google-logo.webp'),
                            SizedBox(width: 10),
                            BoxLogo(imagePath: 'assets/logo/apple-logo.png')
                          ],
                        ),

                        const SizedBox(height: 15),

                        // register
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Belum punya akun?',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                log('Daftar');
                                   ref
                                    .read(routerProvider)
                                    .go(MainDoctorRoute.path);
                              },
                              child: const Text(
                                'Daftar',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
