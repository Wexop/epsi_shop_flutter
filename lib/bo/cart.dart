import 'package:flutter/foundation.dart';

import 'article.dart';

class Cart with ChangeNotifier {
  final _articles = <Article>[];

  List<Article> get articles => _articles;

  add(Article article) {
    _articles.add(article);
    notifyListeners();
  }

  remove(Article article) {
    _articles.remove(article);
    notifyListeners();
  }

  removeAll() {
    _articles.clear();
    notifyListeners();
  }
}
