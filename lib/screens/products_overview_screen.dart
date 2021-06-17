import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import './cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../providers/products.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  bool _isInit = true;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      if (_isInit) {
        setState(() {
          _isLoading = true;
        });
        Provider.of<Products>(context).fetchAndSetProducts().then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: (Size.fromHeight(
          max<double>(screenHeight * 0.072, 40),
        )),
        child: AppBar(
          title: Text("My Shop"),
          actions: <Widget>[
            Consumer<Cart>(
              builder: (_, cart, __) => Badge(
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(CartScreen.routeName),
                ),
                cart.itemCount.toString(),
              ),
            ),
            PopupMenuButton(
              onSelected: (dynamic selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favorites) {
                    _showOnlyFavorites = true;
                  } else
                    _showOnlyFavorites = false;
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text("Only Favorites"),
                  value: FilterOptions.Favorites,
                ),
                PopupMenuItem(
                  child: Text("Show All"),
                  value: FilterOptions.All,
                ),
              ],
            ),
          ],
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Shop Now",
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: screenHeight * 0.05),
                    ),
                  ),
                ),
                Expanded(child: ProductsGrid(_showOnlyFavorites)),
              ],
            ),
      drawer: AppDrawer(),
    );
  }
}
