import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optiguard/feature/auth/widget/text_input.dart';
import 'package:optiguard/shared/constants/app_theme.dart';
import 'package:optiguard/shared/route/app_router.dart';
import 'package:optiguard/shared/widget/app_bar.dart';

class EducationPage extends ConsumerStatefulWidget {
  const EducationPage({super.key});

  @override
  EducationPageState createState() => EducationPageState();
}

class EducationPageState extends ConsumerState<EducationPage> {
  final _searchController = TextEditingController();
  List<String> filteredArticles = [];

  final List<String> articleList = [
    'Jaga Kesehatan Mata di Era Digital',
    'Pentingnya Melakukan Pemeriksaan Mata secara Berkala',
    'Kenali Gejala Awal Gangguan Mata',
    'Manfaat Makanan Sehat untuk Kesehatan Mata Anda',
    'Pentingnya Pemeriksaan Mata Rutin: Apa yang Harus Anda Ketahui?'
  ];

  @override
  void initState() {
    filteredArticles = articleList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const MainAppBar(
          title: 'Edukasi',
          route: EducationRoute.path,
        ),
        body: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const Material(
                  elevation: 0.7,
                  color: Colors.white,
                  child: TabBar(
                    tabs: [
                      Tab(text: 'Artikel'),
                      Tab(text: 'Video'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _tabArticle(),
                      _tabVideo(),
                    ],
                  ),
                )
              ],
            )));
  }

  Widget _tabVideo() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Text(
          'Belum ada video',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _tabArticle() {
    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    filteredArticles = articleList
                        .where((article) =>
                            article.toLowerCase().contains(value.toLowerCase()))
                        .toList();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Cari artikel...',
                  hintStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.normal),
                  prefixIcon: const Icon(Icons.search),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Column(
              children: List.generate(filteredArticles.length, (index) {
                return ArticleItemWidget(
                  title: filteredArticles[index],
                  date: DateTime.now()
                      .subtract(Duration(days: Random().nextInt(12))),
                  view: Random().nextInt(900) + 100,
                );
              }),
            )
          ],
        ));
  }
}

class ArticleItemWidget extends StatelessWidget {
  const ArticleItemWidget({
    super.key,
    required this.title,
    required this.date,
    required this.view,
    this.image = 'assets/images/amsler_help.png',
  });

  final String title;
  final DateTime date;
  final int view;
  final String image;

  String _formatDate(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inDays > 7) {
      return '${date.day}/${date.month}/${date.year}';
    } else if (diff.inDays > 0) {
      return '${diff.inDays} hari lalu';
    } else if (diff.inHours > 0) {
      return '${diff.inHours} jam lalu';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes} menit lalu';
    } else {
      return 'Baru saja';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Container(
              width: 84,
              height: 84,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset(image, fit: BoxFit.cover),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.timer_sharp,
                            color: Colors.grey,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formatDate(date),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 24),
                      Row(
                        children: [
                          const Icon(
                            Icons.remove_red_eye_outlined,
                            color: Colors.grey,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$view dilihat',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
