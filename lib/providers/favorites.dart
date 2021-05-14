import 'package:flutter/material.dart';

class Favorites with ChangeNotifier {
  Map<String, List<String>> favoriteOrders = {
    "c1": ["m1", "m3", "m12"],
    "c2": ["m2", "m5"],
    "c3": ["m1", "m2", "m4", "m13"],
    "c4": [],
  };

  void addItem(String canteenId, String mealId) {
    if (favoriteOrders.containsKey(canteenId)) {
      favoriteOrders[canteenId].add(mealId);
    } else
      favoriteOrders.putIfAbsent(canteenId, () => [mealId]);

    notifyListeners();
  }

  void removeItem(String canteenId, String mealId) {
    favoriteOrders[canteenId].remove(mealId);
    notifyListeners();
  }

  bool isFav(String canteenId, String mealId) {
    return favoriteOrders.containsKey(canteenId) &&
        favoriteOrders[canteenId].contains(mealId);
  }
}
