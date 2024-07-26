import 'package:flutter/material.dart';

class IsLoggedInProvider extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;


  int _count = 0;

  int get count => _count;

  set setIsLoggedIn (bool newIsLoggedIn) {
    _isLoggedIn = newIsLoggedIn;
    notifyListeners();
  }

  void incrementCount (int newCount) {
    _count = newCount;
    notifyListeners();
  }
}