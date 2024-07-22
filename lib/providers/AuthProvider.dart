import 'package:flutter/material.dart';

class IsLoggedInProvider extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  set setIsLoggedIn (bool newIsLoggedIn) {
    _isLoggedIn = newIsLoggedIn;
    notifyListeners();
  }

  int _count = 0;

  int get count => _count;

  void incrementCount (int newCount) {
    _count = newCount;
    notifyListeners();
  }
}