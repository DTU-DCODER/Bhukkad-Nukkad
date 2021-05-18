import 'cart_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CartItemList extends ChangeNotifier {
  List<CartItem> cartItems = [];
  addIteminList() {
    CartItem item = CartItem("m3", "Sandwich", 25,
        "https://static.toiimg.com/thumb/54714340.cms?width=1200&height=900");
    cartItems.add(item);
    notifyListeners();
  }
}
