import 'package:flutter/material.dart';
import 'package:optiguard/shared/constants/app_theme.dart';
import 'package:optiguard/shared/widget/app_bar.dart';

class FundusHelpPage extends StatefulWidget {
  const FundusHelpPage({super.key});

  @override
  _FundusHelpPageState createState() => _FundusHelpPageState();
}

class _FundusHelpPageState extends State<FundusHelpPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  final List<Widget> tutorialList = [
    TutorialPage(
      color: AppColors.green,
      title: 'Cara menggunakan Adaptor OptiGuard',
      desc:
          'Adaptor OptiGuard terdiri dari 3 bagian utama, yaitu gagang, holder smartphone, dan lensa. Ikuti langkah-langkah berikut untuk merakit adaptor dan menggunakannya untuk mengambil gambar fundus.',
      imagePath: 'assets/images/tutorial_01.jpg',
    ),
    TutorialPage(
      color: AppColors.blue,
      title: 'Masukkan slider pada gagang utama',
      desc:
          'Bagian slider dengan sisi tinggi dimasukkan ke dalam gagang utama. Pastikan slider terpasang dengan baik.',
      imagePath: 'assets/images/tutorial_02.jpg',
    ),
    TutorialPage(
      color: AppColors.blue,
      title: 'Memasang holder lensa',
      desc:
          'Masukkan lensa pada salah satu sisi holder lensa hingga terdengar bunyi klik.',
      imagePath: 'assets/images/tutorial_03.jpg',
    ),
    TutorialPage(
      color: AppColors.blue,
      title: 'Memasang holder lensa penutup',
      desc:
          'Pasang holder lensa penutup pada sisi holder lensa yang lain hingga terdengar bunyi klik.',
      imagePath: 'assets/images/tutorial_04.jpg',
    ),
    TutorialPage(
      color: AppColors.blue,
      title: 'Memasang holder lensa pada slider lensa',
      desc:
          'Masukkan holder lensa dari ujung slider lensa. Pastikan sisi cembung lensa menghadap ke arah kamera smartphone.',
      imagePath: 'assets/images/tutorial_05.jpg',
    ),
    TutorialPage(
      color: AppColors.blue,
      title: 'Menyambungkan gagang utama dengan slider lensa',
      desc:
          'Masukkan gagang utama ke dalam lubang slider lensa. Pasang baut untuk mengeratkan sambungan, pastikan baut terpasang dengan baik.',
      imagePath: 'assets/images/tutorial_06.jpg',
    ),
    TutorialPage(
      color: AppColors.blue,
      title: 'Memasang holder smartphone pada slider',
      desc:
          'Pasang holder smartphone dari arah kiri slider. Sesuaikan posisi holder smartphone dengan kamera smartphone.',
      imagePath: 'assets/images/tutorial_07.jpg',
    ),
    TutorialPage(
      color: AppColors.green,
      title: 'Anda berhasil merakit Adaptor OptiGuard!',
      desc:
          'Pasang smartphone Anda pada holder smartphone. Pastikan kamera smartphone tepat lurus mengarah ke lensa.',
      imagePath: 'assets/images/tutorial_08.jpg',
    ),
    TutorialPage(
      color: AppColors.blue,
      title: 'Sesuaikan posisi smartphone',
      desc:
          'Adaptor dapat digeser ke samping, atas, bawah, depan, dan belakang. Sesuaikan posisi smartphone sekitar 15 cm - 20 cm dari lensa.',
      imagePath: 'assets/images/tutorial_09.jpg',
    ),
    TutorialPage(
      color: AppColors.green,
      title: 'Mengambil gambar fundus',
      desc:
          'Pastikan ruangan gelap dan kamera smartphone stabil. Arahkan lensa ke mata pasien, sesuaikan jarak lensa sekitar 3 cm dari mata hingga mendapat gambar fundus yang baik seperti contoh di atas. Tekan tombol shutter pada layar untuk mengambil gambar.',
      imagePath: 'assets/images/tutorial_10.jpg',
      isLast: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: 'Cara Penggunaan',
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: Colors.transparent,
        iconColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: tutorialList,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(tutorialList.length, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                height: 8.0,
                width: _currentPage == index ? 12.0 : 8.0,
                decoration: BoxDecoration(
                  color: _currentPage == index ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(4.0),
                ),
              );
            }),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class TutorialPage extends StatelessWidget {
  final Color color;
  final String title;
  final String desc;
  final String imagePath;
  final bool? isLast;

  const TutorialPage({
    required this.color,
    required this.title,
    required this.desc,
    required this.imagePath,
    this.isLast,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 100),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            )),
        child: Column(
          children: [
            Container(
                width: 260,
                height: 260,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(imagePath, fit: BoxFit.cover)),
            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  desc,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            if (isLast != null && isLast!)
              Container(
                margin: const EdgeInsets.only(top: 72),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text(
                    'Saya Mengerti',
                    style: TextStyle(
                      color: AppColors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ));
  }
}
