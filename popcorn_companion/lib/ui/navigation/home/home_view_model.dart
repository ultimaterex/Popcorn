



import 'package:flutter/material.dart';
import 'package:popcorn_companion/services/providers/base_view_model.dart';

class HomeViewModel extends BaseViewModel{

  int currentIndex = 0;

  // final screens = [
  //   Center()
  // ]


  void onNavigation(int index) {
    currentIndex = index;
    notifyListeners();
  }

}