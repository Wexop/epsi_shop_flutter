import 'package:flutter/foundation.dart';

import 'article.dart';

class Cart with ChangeNotifier {
  final _articles = <Article>[];

  List<Article> get articles => _articles;

  add(Article article) {
    if (_articles.contains(article)) {
      _articles[articles.indexOf(article)].quantite++;
    } else {
      article.quantite = 1;
      _articles.add(article);
    }

    notifyListeners();
  }

  remove(Article article) {
    if (_articles.contains(article)) {
      _articles[articles.indexOf(article)].quantite--;
      if (_articles[articles.indexOf(article)].quantite < 1) {
        remove(_articles.removeAt(articles.indexOf(article)));
      }
    }
    notifyListeners();
  }

  removeAll() {
    _articles.clear();
    notifyListeners();
  }

  getItemsNumber() {
    num count = 0;
    _articles.forEach((element) {
      count += element.quantite;
    });

    return count;
  }
}
