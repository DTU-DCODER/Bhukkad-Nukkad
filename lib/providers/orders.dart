import 'package:flutter/material.dart';

import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.amount,
    @required this.id,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double amount) {
    _orders.insert(
      0,
      OrderItem(
        id: "o" + (_orders.length + 1).toString(),
        amount: amount,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    print("Order added");
    print(_orders.toString());
    notifyListeners();
  }
}
