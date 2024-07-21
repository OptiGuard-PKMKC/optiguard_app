import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:optiguard/feature/auth/widget/logo.dart';
import 'package:optiguard/feature/auth/widget/sponsor.dart';
import 'package:optiguard/shared/route/app_router.dart';

class RoleSelection extends StatefulWidget {
  const RoleSelection({super.key});

  @override
  State<RoleSelection> createState() => _RoleSelectionState();
}

class _RoleSelectionState extends State<RoleSelection> {
  bool _isRole1Selected = false;
  bool _isRole2Selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade400,
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
                  width: MediaQuery.of(context).size.width,
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
                  child: Column(
                    children: [
                      // text
                      const Text(
                        'Pilih Peran Anda',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),

                      const SizedBox(height: 15),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Role Doctor Button
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isRole1Selected = true;
                                  _isRole2Selected = false;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: _isRole1Selected
                                      ? Colors.blue
                                      : Colors.blueGrey.shade200,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: _isRole1Selected
                                      ? [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: const Offset(-5, 5),
                                          ),
                                        ]
                                      : [],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Dokter',
                                      style: TextStyle(
                                        color: _isRole1Selected
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    // Illustration (replace with your actual icon)
                                    Icon(
                                      Icons.person, // Replace with your icon
                                      size: 168,
                                      color: _isRole1Selected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // Role Patient Button
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isRole2Selected = true;
                                  _isRole1Selected = false;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: _isRole2Selected
                                      ? Colors.blue
                                      : Colors.blueGrey.shade200,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: _isRole2Selected
                                      ? [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: const Offset(-5, 5),
                                          ),
                                        ]
                                      : [],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Pasien',
                                      style: TextStyle(
                                        color: _isRole2Selected
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    // Illustration (replace with your actual icon)
                                    Icon(
                                      Icons.person, // Replace with your icon
                                      size: 168,
                                      color: _isRole2Selected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox(
                          height: 35,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              context.push(HomeDoctorRoute.path);
                            },
                            child: const Text(
                              'Daftar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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