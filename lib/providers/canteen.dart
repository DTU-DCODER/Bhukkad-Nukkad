import 'package:flutter/material.dart';

import 'meal.dart';

class Canteen with ChangeNotifier {
  final String id;
  final String canteenName;
  final List<Meal> meals;
  bool isOpen;

  Canteen({this.id, this.canteenName, this.meals, this.isOpen = true});

  void setClosed() {
    isOpen = false;
    notifyListeners();
  }
}
