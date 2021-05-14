import 'package:flutter/material.dart';

class Meal with ChangeNotifier {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  final Map<String, int> typesPrices;
  bool isAvailable;

  Meal(
    this.id,
    this.title,
    this.price,
    this.imageUrl, {
    this.typesPrices,
    this.isAvailable = true,
  });

  void setUnavaiable() {
    isAvailable = false;
    notifyListeners();
  }

  List getKeys() {
    return typesPrices.keys.toList();
  }
}
