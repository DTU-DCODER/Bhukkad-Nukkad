import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;

  CartItem({
    @required this.id,
    @required this.price,
    @required this.quantity,
    @required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) =>
          Provider.of<Cart>(context, listen: false).removeItem(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(Icons.delete),
        alignment: Alignment.centerRight,
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        padding: EdgeInsets.only(right: 20),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: ListTile(
            leading: CircleAvatar(
              minRadius: 25,
              maxRadius: 36,
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("₹$price"),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text("₹${price * quantity}"),
            trailing: Text(quantity.toString() + "x"),
          ),
        ),
      ),
    );
  }
}
