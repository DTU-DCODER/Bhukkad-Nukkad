import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/products.dart';

class AddToCartModalSheet extends StatefulWidget {
  final String productId;
  AddToCartModalSheet(this.productId);
  @override
  _AddToCartModalSheetState createState() => _AddToCartModalSheetState();
}

class _AddToCartModalSheetState extends State<AddToCartModalSheet> {
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
    final cart = Provider.of<Cart>(context, listen: false);
    final products = Provider.of<Products>(context, listen: false);
    final chosenProduct = products.findById(widget.productId);
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final width = MediaQuery.of(context).size.width -
        MediaQuery.of(context).padding.left -
        MediaQuery.of(context).padding.right;
    return Scaffold(
      key: ValueKey("ModalBottomSheetScaffold"),
      body: Container(
        height: height * 0.7,
        padding: EdgeInsets.symmetric(vertical: height * 0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(width * 0.001),
              child: Text(
                chosenProduct!.title!,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: width * 0.08,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                softWrap: true,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  //horizontal: width * 0.02,
                  vertical: height * 0.04,
                ),
                child: Row(
                  children: <Widget>[
                    Image.network(
                      chosenProduct.imageUrl!,
                      width: width * 0.4,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: width * 0.04,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: width * 0.54,
                          child: Text(
                            chosenProduct.description!,
                            softWrap: true,
                            style: TextStyle(fontSize: height * 0.016),
                          ),
                        ),
                        SizedBox(height: height * 0.05),
                        Text(
                          "₹" + chosenProduct.price.toString(),
                          style: TextStyle(
                            fontSize: height * 0.02,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            SizedBox(height: height * 0.01),
            Row(
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
            )
          ],
        ),
      ),
    );
  }
}
