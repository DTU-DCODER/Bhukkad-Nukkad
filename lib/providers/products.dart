import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product.dart';
import '../models/http_exception.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id, orElse: () => null);
  }

  int get itemsLength {
    return _items.length;
  }

  Future<void> addProduct(Product newProduct) {
    final url = Uri.parse(
        "https://flutter-shop-app-f1b23-default-rtdb.firebaseio.com/products.json");
    return http
        .post(url,
            body: json.encode({
              "title": newProduct.title,
              "price": newProduct.price,
              "description": newProduct.description,
              "imageUrl": newProduct.imageUrl,
              "isFavorite": newProduct.isFavorite,
            }))
        .then((response) {
      if (findById(json.decode(response.body)['name']) == null)
        _items.add(newProduct.withId(json.decode(response.body)['name']));
      //print(_items[items.length - 1].id);
      notifyListeners();
    }).catchError((error) {
      print(error);
      throw error;
    });
  }

  Future<void> fetchAndSetProducts() {
    final url = Uri.parse(
        "https://flutter-shop-app-f1b23-default-rtdb.firebaseio.com/products.json");
    return http.get(url).then((response) {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) return;
      extractedData.forEach((prodId, prodData) {
        if (findById(prodId) == null) {
          _items.add(Product(
            id: prodId,
            description: prodData["description"],
            imageUrl: prodData["imageUrl"],
            price: prodData["price"],
            title: prodData["title"],
            isFavorite: prodData["isFavorite"],
          ));
          notifyListeners();
        }
      });
    }).catchError((error) {
      print(error);
      throw error;
    });
  }

  Future<void> updateProduct(String productId, Product newProduct) {
    final _productIndex =
        _items.indexWhere((element) => element.id == productId);
    if (_productIndex >= 0) {
      final url = Uri.parse(
          "https://flutter-shop-app-f1b23-default-rtdb.firebaseio.com/products/$productId.json");
      return http
          .patch(url,
              body: json.encode({
                "title": newProduct.title,
                "description": newProduct.description,
                "imageUrl": newProduct.imageUrl,
                "price": newProduct.price,
              }))
          .then((_) {
        _items[_productIndex] = newProduct;
        notifyListeners();
      });
    } else {
      print("ERROR");
    }

    return Future(null);
  }

  // Future<void> deleteProduct(String productId) {
  //   print(productId);
  //   final url = Uri.parse(
  //       "https://flutter-sdhop-app-f1b23-default-rtdb.firebaseio.com/products/$productId.json");
  //   print(url.toString());
  //   return http.delete(url).then((response) {
  //     print(response.statusCode);
  //     print(response.body);
  //     if (response.statusCode >= 400) {
  //       throw HttpException("Could not delete!");
  //     }
  //     _items.removeWhere((element) => element.id == productId);

  //     notifyListeners();
  //   });
  // }
  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        'https://flutter-shop-app-f1b23-default-rtdb.firebaseio.com/products/$id.json');
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      print(response.body);
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
