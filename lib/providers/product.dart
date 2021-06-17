import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String? id;
  final String? title;
  final String? description;
  final double? price;
  final String? imageUrl;
  bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite = false});

  void toggleFavoriteStatus(String? authToken, String? userId) {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url = Uri.parse(
        "https://flutter-shop-app-f1b23-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$authToken");
    http
        .put(
      url,
      body: json.encode(isFavorite),
    )
        .then((response) {
      if (response.statusCode >= 400) {
        isFavorite = oldStatus;
        notifyListeners();
      }
    }).catchError((error) {
      isFavorite = oldStatus;
      notifyListeners();
    });
  }

  Product withId(String? newId) {
    return Product(
      id: newId,
      title: title,
      description: description,
      imageUrl: imageUrl,
      price: price,
      isFavorite: isFavorite,
    );
  }
}
