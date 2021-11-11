import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/products.dart';

class AddToCartScreen extends StatefulWidget {
  static const routeName = "/add-to-cart";

  @override
  _AddToCartScreenState createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  int value = 1;
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) ScaffoldMessenger.of(context).hideCurrentSnackBar();
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final String productId =
        ModalRoute.of(context)!.settings.arguments as String;
    final cart = Provider.of<Cart>(context, listen: false);
    final products = Provider.of<Products>(context, listen: false);
    final chosenProduct = products.findById(productId);
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final width = MediaQuery.of(context).size.width -
        MediaQuery.of(context).padding.left -
        MediaQuery.of(context).padding.right;
    return Scaffold(
      key: ValueKey("ModalBottomSheetScaffold"),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: height * 0.3,
              pinned: true,
              leading: Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                title: Container(
                  color: Colors.white70,
                  width: width * 0.7,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Text(
                    chosenProduct?.title ?? '',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                background: Hero(
                  tag: chosenProduct?.id ?? '',
                  child: Image.network(
                    chosenProduct?.imageUrl ?? '',
                    width: width * 0.95,
                    height: height * 0.4,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            SliverPadding(
              padding: EdgeInsets.only(
                //top: height * 0.01,
                bottom: height * 0.02,
                left: width * 0.05,
                right: width * 0.05,
              ),
              sliver: SliverToBoxAdapter(
                child: Text(
                  chosenProduct!.title!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: width * 0.1,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                  softWrap: true,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(width * 0.07),
                  child: Text(
                    chosenProduct.description!,
                    softWrap: true,
                    style: TextStyle(fontSize: height * 0.03),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: height * 0.01)),
            SliverToBoxAdapter(
              child: Center(
                child: Text(
                  "₹" + chosenProduct.price.toString(),
                  style: TextStyle(
                    fontSize: height * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverLayoutBuilder(builder: (_, constraints) {
              return SliverToBoxAdapter(
                child: SizedBox(
                  height: max(
                      height * 0.98 -
                          constraints.precedingScrollExtent -
                          MediaQuery.of(context).padding.top,
                      0),
                ),
              );
            }),
            SliverToBoxAdapter(child: Divider()),

            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    child: Icon(
                      Icons.remove_circle_outline,
                      size: width * 0.08,
                      color: Colors.black,
                    ),
                    onTap: () {
                      if (value == 1) return;
                      setState(() {
                        value--;
                      });
                    },
                  ),
                  //SizedBox(width: 20),
                  Text(
                    value.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.07,
                    ),
                  ),
                  //SizedBox(width: 12),
                  InkWell(
                    child: Icon(
                      Icons.add_circle_outline,
                      size: width * 0.08,
                      color: Colors.black,
                    ),
                    onTap: () {
                      if (value == 15) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("You cannot order more than 15!"),
                            duration: const Duration(milliseconds: 1500),
                            width: MediaQuery.of(context).size.width - 80,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: Theme.of(context).errorColor,
                          ),
                        );
                        return;
                      }
                      setState(() {
                        value++;
                      });
                    },
                  ),
                  Container(
                    height: height * 0.07,
                    width: width * 0.5,
                    padding: EdgeInsets.all(height * 0.02),
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(height * 0.02),
                    ),
                    child: InkWell(
                      child: Text(
                        "ADD - ₹" + (chosenProduct.price! * value).toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: height * 0.02,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        cart.addItem(context, chosenProduct.id,
                            chosenProduct.price, chosenProduct.title!, value);
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
            // SliverToBoxAdapter(
            //   child: SizedBox(
            //     height: height * 0.01,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
