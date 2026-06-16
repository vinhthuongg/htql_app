
import 'package:flutter/material.dart';

class BottomnavigationProvider extends ChangeNotifier {
  int _seletedIndex = 0;
  int get seletedIndex => _seletedIndex;

  void setSeletedIndex(int index) {
    _seletedIndex = index;
    notifyListeners();
  }
}