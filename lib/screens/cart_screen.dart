import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Cart"),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Card(
                margin: EdgeInsets.all(15).copyWith(bottom: 0),
                child: Padding(
                  padding: EdgeInsets.all(8).copyWith(bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Total", style: TextStyle(fontSize: 20)),
                      Spacer(),
                      Chip(
                        label: Text(
                          "₹" + (cart.totalAmount).toStringAsFixed(2),
                          style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .headline1!
                                .color,
                          ),
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 10),
                      OrderButton(cart: cart)
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: ListView.builder(
                itemCount: cart.itemCount + 1,
                itemBuilder: (ctx, index) {
                  if (index == 0)
                    return SizedBox(
                      height: 10,
                    );
                  index--;
                  var currentItem = cart.items.values.toList()[index];
                  return CartItem(
                    id: currentItem.id,
                    price: currentItem.price,
                    quantity: currentItem.quantity,
                    title: currentItem.title,
                  );
                },
              ),
            )
          ],
        ));
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: _isLoading ? CircularProgressIndicator() : Text("ORDER NOW"),
      onPressed: widget.cart.totalAmount <= 0
          ? null
          : () {
              setState(() {
                _isLoading = true;
              });
              Provider.of<Orders>(context, listen: false)
                  .addOrder(widget.cart.items.values.toList(),
                      widget.cart.totalAmount)
                  .then((_) {
                widget.cart.clearCart();
                setState(() {
                  _isLoading = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Text("Order Placed!"),
                  ),
                );
              });
            },
    );
  }
}
