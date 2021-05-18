import 'package:flutter/material.dart';

import './canteen.dart';
import '../DUMMY_DATA.dart';

class Canteens with ChangeNotifier {
  List<Canteen> _canteenList = [
    Canteen(
      id: "c1",
      canteenName: "Canteen",
      meals: canteenMealList,
      reviews: canteenReviews,
    ),
    Canteen(
      id: "c2",
      canteenName: "Mic Mac",
      meals: micMacMeals,
      reviews: micMacReviews,
    ),
    Canteen(
      id: "c3",
      canteenName: "HPMC",
      meals: hpmcMeals,
      reviews: hpmcReviews,
    ),
    Canteen(
      id: "c4",
      canteenName: "Nescafe",
      meals: nescafeMeals,
      reviews: nescafeReviews,
    ),
  ];

  List<Canteen> get canteens {
    return [..._canteenList];
  }

  Canteen findById(String id) {
    Canteen ans = _canteenList.firstWhere((element) => element.id == id);
    return ans;
  }

  void setCanteenUnavailable(String canteenId) {
    _canteenList.firstWhere((element) => element.id == canteenId).isOpen =
        false;
    notifyListeners();
  }
}
