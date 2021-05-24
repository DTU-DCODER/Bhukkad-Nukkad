import 'package:flutter/material.dart';

import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: "p1",
      title: "Red T Shirt",
      description: "A red shirt - it is pretty red!",
      price: 600,
      imageUrl:
          "https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg",
    ),
    Product(
      id: "p2",
      title: "Black Trousers",
      description: "A nice pair of black trousers.",
      price: 1800,
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg",
    ),
    Product(
      id: "p3",
      title: "Yellow Scarf",
      description: "Warm and cozy - exactly what you need for the winter.",
      price: 500,
      imageUrl:
          "https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg",
    ),
    Product(
      id: "p4",
      title: "A Pan",
      description: "Prepare any meal you want.",
      price: 1200,
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg",
    ),
    Product(
      id: "p5",
      title: "Black T Shirt",
      description: "A black T shirt - it is pretty black!",
      price: 500,
      imageUrl:
          "https://images-na.ssl-images-amazon.com/images/I/51CQBseiZgL._AC_UY879_.jpg",
    ),
    Product(
      id: "p6",
      title: "Brown Trousers",
      description: "A nice pair of trousers.",
      price: 800,
      imageUrl:
          "https://m.media-amazon.com/images/I/61ZPFCApdpL._AC_UL480_FMwebp_QL65_.jpg",
    ),
    Product(
      id: "p7",
      title: "True Wireless Earphones",
      description:
          "These splash- and sweat-resistant in-ear headphones give you great sound and up to 18 hours play time",
      price: 2500,
      imageUrl:
          "https://images-na.ssl-images-amazon.com/images/I/51VncB7MjsL._AC_SL1000_.jpg",
    ),
    Product(
      id: "p8",
      title: "USB to AUX",
      description:
          "Enables you to connect your existing phone or gaming headset with one 3.5mm aux trrs plug (integrated audio out & mic in) to your pc or ps4 through a usb interface.",
      price: 625,
      imageUrl:
          "https://images-eu.ssl-images-amazon.com/images/I/51d2Wfyj9gL.__AC_SX300_SY300_QL70_FMwebp_.jpg",
    ),
    Product(
      id: "p9",
      title: "Apple Juice",
      description: "It contains pure apple juice and no added caffeine",
      price: 10,
      imageUrl:
          "https://images-na.ssl-images-amazon.com/images/I/71iWCEn0VJL._AC_SL1500_.jpg",
    ),
    Product(
      id: "p10",
      title: "Laptop Bag",
      description: "Nike Laptop Bag",
      price: 2200,
      imageUrl:
          "https://m.media-amazon.com/images/I/7150+ZEIolL._AC_UL480_FMwebp_QL65_.jpg",
    ),
    Product(
      id: "p11",
      title: "Sports Shoes",
      description: "Sports Shoes -- perfect for all sports and running",
      price: 1100,
      imageUrl:
          "https://m.media-amazon.com/images/I/81b9Eh286BL._AC_UL480_FMwebp_QL65_.jpg",
    ),
    Product(
      id: "p12",
      title: "Hershey's Kisses",
      description: "The perfect bite-size milk chocolate snack",
      price: 625,
      imageUrl:
          "https://m.media-amazon.com/images/I/71QsL7zoz6L._AC_AA360_.jpg",
    ),
  ];

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

  void addProduct(Product newProduct) {
    if (findById(newProduct.id) != null) return;
    _items.add(newProduct);
    notifyListeners();
  }

  void updateProduct(String productId, Product newProduct) {
    final _productIndex =
        _items.indexWhere((element) => element.id == productId);
    if (_productIndex >= 0) {
      _items[_productIndex] = newProduct;
    } else
      print("ERROR");
    notifyListeners();
  }

  void deleteProduct(String productId) {
    _items.removeWhere((element) => element.id == productId);
    notifyListeners();
  }
}
