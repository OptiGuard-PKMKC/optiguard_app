import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:optiguard/feature/chat/widget/chat_room_page.dart';
import 'package:optiguard/feature/fundus_record/widget/fundus_list_option.dart';
import 'package:optiguard/feature/patient/model/patient.dart';
import 'package:optiguard/feature/patient/widget/patient_detail_page.dart';
import 'package:optiguard/shared/constants/app_theme.dart';
import 'package:optiguard/shared/widget/app_bar.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({super.key});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: MainAppBar(
        title: 'Pasien Saya',
        route: '/patient',
      ),
      body: _widgetContent(context),
    );
  }

  Widget _widgetContent(BuildContext context) {
    final List<Patient> patients = [
      Patient(
        id: 'qqhkda',
        name: 'Tiara Sabrina',
        age: '20',
        gender: 'Perempuan',
        image: 'assets/avatar_example.png',
      ),
      Patient(
        id: 'qqhkda',
        name: 'Rizky Ramadhan',
        age: '20',
        gender: 'Laki-laki',
      )
    ];

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        for (final patient in patients) PatientItem(patient: patient),
      ]),
    );
  }
}

class PatientItem extends StatelessWidget {
  const PatientItem({
    super.key,
    required this.patient,
  });

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PatientDetailPage(
                      patientId: '',
                    )));
          },
          child: Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              child: Row(
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        patient.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          patient.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 16,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '${patient.age} tahun',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(
                              Icons.tag_faces,
                              size: 16,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 4),
                            Text(
                              patient.gender,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Option icon
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.more_horiz_rounded),
                    ),
                    onPressed: () {
                      // Show option menu
                      // Define your options
                      final List<BottomSheetOption> options = [
                        BottomSheetOption(
                          title: 'Pesan',
                          icon: const Icon(Icons.chat_rounded),
                          onTap: () {
                            print('Option 1 selected');
                            // Add your custom logic here for Option 1
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ChatRoomPage()));
                          },
                        ),
                        BottomSheetOption(
                          title: 'Arsipkan',
                          icon: const Icon(Icons.archive_rounded),
                          onTap: () {
                            print('Option 2 selected');
                            // Add your custom logic here for Option 2
                          },
                        ),
                        // Add more options as needed
                      ];

                      // Show the bottom sheet
                      buildBottomSheetOption(context, options);
                    },
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
