import 'package:flutter/material.dart';

import './meal.dart';

class Review {
  final String userName;
  final DateTime dateTime;
  final int rating;
  final String description;

  Review({
    this.userName,
    this.dateTime,
    this.rating,
    this.description,
  });
}

class Canteen with ChangeNotifier {
  final String id;
  final String canteenName;
  final List<Meal> meals;
  bool isOpen;
  Map<String, Review> reviews;
  Canteen({
    @required this.id,
    @required this.canteenName,
    @required this.meals,
    this.isOpen = true,
    @required this.reviews,
  });

  void setMealUnavailable(String mealId) {
    meals.firstWhere((element) => element.id == mealId).isAvailable = false;
    notifyListeners();
  }

  Meal findMealById(String mealId) {
    return meals.firstWhere((element) => element.id == mealId);
  }

  void addReview(String userId, String userName, DateTime dateTime, int rating,
      String description) {
    if (reviews.containsKey(userId)) {
      reviews.update(
        userId,
        (review) => Review(
          userName: review.userName,
          dateTime: dateTime,
          rating: rating,
          description: description,
        ),
      );
    } else {
      reviews.putIfAbsent(
        userId,
        () => Review(
          userName: userName,
          dateTime: dateTime,
          rating: rating,
          description: description,
        ),
      );
    }
    notifyListeners();
  }

  double get averageRating {
    if (reviews == null) {
      print("NULL");
      return 0;
    }
    double sum = 0;
    int total = reviews.length;
    List<Review> reviewList = reviews.values.toList();
    for (int i = 0; i < total; i++) {
      sum += reviewList[i].rating;
    }
    return (sum / total);
  }
}
