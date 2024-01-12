import 'package:flutter/foundation.dart';

import 'article.dart';

class Cart with ChangeNotifier {
  final _articles = <Article>[];

  List<Article> get articles => _articles;

  findIndexById(num id) {
    int? indexFound;
    int index = 0;
    for (var element in _articles) {
      if (element.id == id) {
        indexFound = index;
      }
      index += 1;
    }

    return indexFound;
  }

  add(Article article) {
    int? index = findIndexById(article.id);
    if (index != null) {
      _articles[index].quantite++;
    } else {
      article.quantite = 1;
      _articles.add(article);
    }

    notifyListeners();
  }

  remove(Article article) {
    int? index = findIndexById(article.id);
    if (index != null) {
      _articles[index].quantite--;
      if (_articles[index].quantite < 1) {
        remove(_articles.removeAt(index));
      }
    }
    notifyListeners();
  }

  removeAll() {
    _articles.clear();
    notifyListeners();
  }

  num getItemsNumber() {
    num count = 0;
    for (var element in _articles) {
      count += element.quantite;
    }

    return count;
  }

  num getTotalPrice() {
    num price = 0;
    _articles.forEach((element) {
      price += element.prix * element.quantite;
    });

    return price;
  }
}
