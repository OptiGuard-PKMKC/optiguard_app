import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:optiguard/feature/auth/widget/box_logo.dart';
import 'package:optiguard/feature/auth/widget/logo.dart';
import 'package:optiguard/feature/auth/widget/role_selection_page.dart';
import 'package:optiguard/feature/auth/widget/sponsor.dart';
import 'package:optiguard/feature/auth/widget/text_input.dart';
import 'package:optiguard/shared/route/app_router.dart';

class RegisterContPage extends StatelessWidget {
  RegisterContPage({super.key});

  final birthController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> genderOptions = ['laki-laki', 'perempuan'];

    return Scaffold(
      backgroundColor: Colors.blue.shade400,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 25),
                // sponsor
                const SponsorWidget(),

                const SizedBox(height: 15),

                // logo
                const LogoWidget(),

                const SizedBox(height: 10),

                // Remaining height container
                Container(
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
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align text to the left
                    children: [
                      // text
                      const Center(
                        // Center the text
                        child: Text(
                          'Isi Data Diri Anda',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // form
                      DatePicker(
                        controller: birthController,
                        labeltext: 'Tanggal Lahir',
                        hintText: 'Masukan tanggal lahir',
                        obscureText: false,
                      ),

                      const SizedBox(height: 15),

                      // form
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Jenis Kelamin',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            )),
                      ),
                      RadioGender(genderOptions: genderOptions),

                      const SizedBox(height: 15),

                      TextInput(
                        controller: cityController,
                        labelText: 'Kota/Kabupaten',
                        hintText: 'Masukan kota/kabupaten',
                        obscureText: false,
                      ),

                      const SizedBox(height: 15),

                      TextInput(
                        controller: addressController,
                        labelText: 'Alamat',
                        hintText: 'Masukan alamat',
                        obscureText: false,
                      ),

                      const SizedBox(height: 15),

                      // button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox(
                          height: 35,
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RoleSelection(),
                                ),
                              );
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
                            'Sudah punya akun?',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              context.push(SignInRoute.path);
                            },
                            child: const Text(
                              'Masuk',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RadioGender extends StatefulWidget {
  final List<String> genderOptions; // List of gender options

  const RadioGender({
    super.key,
    required this.genderOptions,
  });

  @override
  State<RadioGender> createState() => _RadioGenderState();
}

class _RadioGenderState extends State<RadioGender> {
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.genderOptions.map((gender) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 25, 0),
          child: Row(
            children: [
              Radio<String>(
                value: gender,
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
                activeColor: Colors.blue,
              ),
              Text(gender,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  )),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class DatePicker extends StatelessWidget {
  final TextEditingController controller;
  final String labeltext;
  final String hintText;
  final bool obscureText;

  const DatePicker(
      {super.key,
      required this.controller,
      required this.labeltext,
      required this.hintText,
      required this.obscureText});

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (picked != null) {
      controller.text = picked.toString().split(' ')[0];
    }
  }

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
          labelText: labeltext,
          labelStyle: TextStyle(color: Colors.grey.shade600),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade600),
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        readOnly: true,
        onTap: () => selectDate(context),
      ),
    );
  }
}
