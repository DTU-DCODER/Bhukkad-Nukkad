import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';

import '../providers/products.dart';
import './product_item.dart';

class ProductsGrid extends StatefulWidget {
  final bool showFavs;
  ProductsGrid(this.showFavs);

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid>
    with SingleTickerProviderStateMixin {
  late final Products productsData;
  late List<Product?> products;
  late AnimationController _controller;
  bool _isInit = true;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _controller.forward();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      productsData = Provider.of<Products>(context);
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    products =
        widget.showFavs ? productsData.favoriteItems : productsData.items;
    return SliverFadeTransition(
      opacity: _controller,
      sliver: SliverPadding(
        padding: const EdgeInsets.all(10.0),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (ctx, index) {
              return ChangeNotifierProvider.value(
                key: Key("Product" + index.toString()),
                value: products[index]!,
                child: ProductItem(),
              );
            },
            childCount: products.length,
          ),
          // physics: ClampingScrollPhysics(),
          // padding: const EdgeInsets.all(10),
          // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          //   childAspectRatio: 1.2,
          //   crossAxisSpacing: 10,
          //   mainAxisSpacing: 10,
          //   maxCrossAxisExtent: 250,
          // ),
        ),
      ),
    );
  }
}
