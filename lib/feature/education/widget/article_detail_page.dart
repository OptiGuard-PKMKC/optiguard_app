import 'package:flutter/material.dart';
import 'package:optiguard/feature/education/model/article.dart';

class ArticleDetailPage extends StatelessWidget {
  const ArticleDetailPage({required this.articleId, super.key});

  final String articleId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: FutureBuilder<Article>(
      //   future: fetchArticle(articleId), // Metode untuk memuat artikel dari ID
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       Article article = snapshot.data!;
      //       return Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Text('Title: ${article.title}'),
      //           Text('Content: ${article.content}'),
      //           // Tampilkan konten artikel sesuai kebutuhan
      //         ],
      //       );
      //     } else if (snapshot.hasError) {
      //       return Text('Error: ${snapshot.error}');
      //     }
      //     // Menampilkan loading atau indikator lainnya
      //     return CircularProgressIndicator();
      //   },
      // ),
    );
  }

  // Future<Article> fetchArticle(String articleId) async {
  //   await Future.delayed(const Duration(milliseconds: 200));
    
  // }
}
