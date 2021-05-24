import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get items {
    return {..._cartItems};
  }

  int get itemCount {
    return _cartItems.length;
  }

  double get totalAmount {
    double total = 0;
    _cartItems.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(BuildContext context, String productId, double price,
      String title, int quantity) {
    if (_cartItems.containsKey(productId)) {
      _cartItems[productId].quantity += quantity;
    } else {
      _cartItems.putIfAbsent(
        productId,
        () => CartItem(
          id: productId,
          title: title,
          quantity: quantity,
          price: price,
        ),
      );
    }
    notifyListeners();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(quantity.toString() + " " + title + " added to cart!"),
        action: SnackBarAction(
          label: "UNDO",
          onPressed: () {
            removeLastEntry(productId, quantity);
          },
        ),
      ),
    );
  }

  void removeItem(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void removeLastEntry(String productId, int quantity) {
    if (!_cartItems.containsKey(productId)) return;
    if (_cartItems[productId].quantity > quantity) {
      _cartItems[productId].quantity -= quantity;
    } else {
      _cartItems.remove(productId);
    }
    notifyListeners();
  }

  void clearCart() {
    _cartItems = {};
    notifyListeners();
  }
}
