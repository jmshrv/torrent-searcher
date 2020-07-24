import 'package:flutter/foundation.dart';

class SearchProvider with ChangeNotifier {
  String search;

  void updateSearch(String newSearch) {
    search = newSearch;
    notifyListeners();
  }
}
