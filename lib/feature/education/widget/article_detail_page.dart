import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optiguard/feature/education/model/article.dart';
import 'package:optiguard/feature/education/provider/articles_provider.dart';
import 'package:optiguard/shared/widget/app_bar.dart';
import 'package:path/path.dart';

const double _kImageCoverSize = 0.45;
const double _kContentMinus = 0.04;

class ArticleDetailPage extends ConsumerStatefulWidget {
  const ArticleDetailPage({required this.articleId, super.key});

  final String articleId;

  @override
  ArticleDetailPageState createState() => ArticleDetailPageState();
}

class ArticleDetailPageState extends ConsumerState<ArticleDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(articleDetailNotifierProvider.notifier)
          .fetchArticleDetail(widget.articleId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.black.withOpacity(0.2)),
            ),
            child: const Icon(Icons.arrow_back_rounded),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: _widgetContent(context),
    );
  }

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

  Widget _widgetContent(BuildContext context) {
    final state = ref.watch(articleDetailNotifierProvider);

    return state.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      loaded: (article) {
        return Stack(
          children: [
            ..._bodyImageCover(context, article),
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    height: MediaQuery.of(context).size.height *
                        (_kImageCoverSize - _kContentMinus),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          article.title,
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  // Content
                  Container(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width,
                    ),
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              _formatDate(article.date),
                              style: const TextStyle(fontSize: 14),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                const Icon(Icons.remove_red_eye, size: 16),
                                const SizedBox(width: 8),
                                Text(
                                  article.view.toString(),
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          article.content,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
      error: (message) => Center(child: Text(message)),
    );
  }

  List<Widget> _bodyImageCover(BuildContext context, Article article) {
    final imageHeight = MediaQuery.of(context).size.height * _kImageCoverSize;

    return [
      Container(
        height: imageHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(article.image),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Container(
        height: imageHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(0.7),
              Colors.transparent,
            ],
          ),
        ),
      )
    ];
  }
}
