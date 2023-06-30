import 'package:flutter/material.dart';

class BottomNavbarProvider with ChangeNotifier {
  int _idx = 0;

  int get index => _idx;

  void updateScreen(int page) {
    _idx = page;
    notifyListeners();
  }
}
