import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  final String productId;
  final String productName;
  final double price;
  final String imageUrl;
  CartItem(
    @required this.productId,
    @required this.productName,
    @required this.price,
    @required this.imageUrl,
  );

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int quantity = 1;
  double cost = 0;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Card(
      child: Row(
        children: <Widget>[
          Container(
            width: 100,
            child: Image.network(widget.imageUrl),
          ),
          SizedBox(
            width: 0.05 * width,
          ),
          Container(
              padding: EdgeInsets.all(20), child: Text(widget.productName)),
          SizedBox(
            width: 0.01 * width,
          ),
          Row(
            children: <Widget>[
              quantity != 0
                  ? new IconButton(
                      icon: new Icon(Icons.remove),
                      onPressed: () =>
                          setState(() => {cost -= widget.price, quantity--}),
                    )
                  : new Container(),
              new Text(quantity.toString()),
              new IconButton(
                  icon: new Icon(Icons.add),
                  onPressed: () =>
                      setState(() => {cost += widget.price, quantity++}))
            ],
          ),
          SizedBox(
            width: 0.05 * width,
          ),
          Text("Rs." + (widget.price * quantity).toString()),
        ],
      ),
    );
  }
}
