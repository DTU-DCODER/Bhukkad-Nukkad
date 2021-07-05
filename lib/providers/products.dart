import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product.dart';
import '../models/http_exception.dart';

class Products with ChangeNotifier {
  List<Product?> _items = [];

  List<Product?> get items {
    return [..._items];
  }

  List<Product?> get favoriteItems {
    return _items.where((element) => element!.isFavorite).toList();
  }

  Product? findById(String? id) {
    return _items.firstWhere((element) => element!.id == id,
        orElse: () => null);
  }

  int get itemsLength {
    return _items.length;
  }

  final String? authToken;
  final String? userId;
  Products(this.authToken, this.userId, this._items);

  Future<void> addProduct(Product newProduct) {
    final url = Uri.parse(
        "https://flutter-shop-app-f1b23-default-rtdb.firebaseio.com/products.json?auth=$authToken");
    return http
        .post(url,
            body: json.encode({
              "title": newProduct.title,
              "price": newProduct.price,
              "description": newProduct.description,
              "imageUrl": newProduct.imageUrl,
              "creatorId": userId,
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

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    _items = [];
    final filterString =
        filterByUser ? '&orderBy="creatorId"&equalTo="$userId"' : '';
    var url = Uri.parse(
        'https://flutter-shop-app-f1b23-default-rtdb.firebaseio.com/products.json?auth=$authToken$filterString');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>?;
      if (extractedData == null) {
        return;
      }
      url = Uri.parse(
          'https://flutter-update.firebaseio.com/userFavorites/$userId.json?auth=$authToken');
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      final List<Product?> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          isFavorite:
              favoriteData == null ? false : favoriteData[prodId] ?? false,
          imageUrl: prodData['imageUrl'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<void> updateProduct(String? productId, Product newProduct) {
    final _productIndex =
        _items.indexWhere((element) => element!.id == productId);
    if (_productIndex >= 0) {
      final url = Uri.parse(
          "https://flutter-shop-app-f1b23-default-rtdb.firebaseio.com/products/$productId.json?auth=$authToken");
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

    return Future.value(null);
  }

  Future<void> deleteProduct(String? id) async {
    final url = Uri.parse(
        'https://flutter-shop-app-f1b23-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');
    final existingProductIndex = _items.indexWhere((prod) => prod!.id == id);
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
