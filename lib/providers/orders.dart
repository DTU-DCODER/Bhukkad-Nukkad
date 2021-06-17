import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './cart.dart';

class OrderItem {
  final String? id;
  final double? amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.amount,
    required this.id,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  final String? authToken;
  final String? userId;
  Orders(this.authToken, this.userId, this._orders);

  Future<void> addOrder(List<CartItem> cartProducts, double amount) {
    final url = Uri.parse(
        "https://flutter-shop-app-f1b23-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken");
    final timeStamp = DateTime.now();
    return http
        .post(url,
            body: json.encode({
              "amount": amount,
              "dateTime": timeStamp.toIso8601String(),
              "products": cartProducts
                  .map(
                    (cp) => {
                      "id": cp.id,
                      "title": cp.title,
                      "price": cp.price,
                      "quantity": cp.quantity,
                    },
                  )
                  .toList(),
            }))
        .then((response) {
      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)["name"],
          amount: amount,
          products: cartProducts,
          dateTime: DateTime.now(),
        ),
      );
      print("Order added");
      print(_orders.toString());
      notifyListeners();
    });
  }

  Future<void> setAndFetchOrders() {
    final url = Uri.parse(
        "https://flutter-shop-app-f1b23-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken");
    return http.get(url).then(
      (response) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>?;
        print(extractedData);
        if (extractedData == null) return null;
        extractedData.forEach(
          (orderId, orderData) {
            if (_orders.indexWhere((element) => element.id == orderId) >= 0)
              return;
            _orders.add(
              OrderItem(
                  id: orderId,
                  amount: orderData["amount"],
                  dateTime: DateTime.parse(orderData["dateTime"]),
                  products: (orderData["products"] as List<dynamic>)
                      .map(
                        (e) => CartItem(
                          id: e["id"],
                          price: e["price"],
                          quantity: e["quantity"],
                          title: e["title"],
                        ),
                      )
                      .toList()),
            );
          },
        );
        _orders = _orders.reversed.toList();
        notifyListeners();
      },
    );
  }
}
