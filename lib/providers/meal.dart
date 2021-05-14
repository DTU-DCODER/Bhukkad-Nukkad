import 'package:flutter/material.dart';

class Meal with ChangeNotifier {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  bool isAvailable;

  Meal(
    this.id,
    this.title,
    this.price,
    this.imageUrl, {
    this.isAvailable = true,
  });

  void setUnavaiable() {
    isAvailable = false;
    notifyListeners();
  }
}
