import 'package:flutter/material.dart';

import '../bo/article.dart';

class ArticleDetailPage extends StatelessWidget {
  Article article;

  ArticleDetailPage({super.key, required this.article});

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Center(
              child: Text(
                "Détail sur l'article",
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary),
        body: Text(article.nom));
  }
}
