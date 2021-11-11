import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/screens/add_to_cart_screen.dart';

import '../providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _expanded ? widget.order.products.length * 20.0 + 120 : 95,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text("₹${widget.order.amount}"),
              subtitle: Text(
                DateFormat("dd/MM/yyyy hh:mm").format(widget.order.dateTime),
              ),
              trailing: IconButton(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 8),
              height: _expanded ? widget.order.products.length * 22.0 : 0,
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                children: widget.order.products
                    .map(
                      (prod) => InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              AddToCartScreen.routeName,
                              arguments: prod.id);
                        },
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                prod.title!,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                //softWrap: true,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "${prod.quantity}x ₹${prod.price}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
