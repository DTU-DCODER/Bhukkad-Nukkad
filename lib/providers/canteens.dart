import 'package:flutter/material.dart';

import './canteen.dart';
import '../DUMMY_DATA.dart';

class Canteens with ChangeNotifier {
  List<Canteen> _canteenList = [
    Canteen(id: "c1", canteenName: "Canteen", meals: canteenMealList), //13
    Canteen(id: "c2", canteenName: "Mic Mac", meals: micMacMeals), //10
    Canteen(id: "c3", canteenName: "HPMC", meals: hpmcMeals), //13
    Canteen(id: "c4", canteenName: "Nescafe", meals: nescafeMeals), //12
  ];

  List<Canteen> get canteens {
    return [..._canteenList];
  }

  Canteen findById(String id) {
    return _canteenList.firstWhere((element) => element.id == id);
  }

  void setCanteenUnavailable(String canteenId) {
    _canteenList.firstWhere((element) => element.id == canteenId).isOpen =
        false;
    notifyListeners();
  }
}
