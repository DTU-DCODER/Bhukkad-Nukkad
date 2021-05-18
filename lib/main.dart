import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Widgets/cart_items.dart';
import 'Widgets/car_items_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => CartItemList(),
        child: MyHomepage(),
      ),
    );
  }
}

class MyHomepage extends StatelessWidget {
  const MyHomepage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Provider.of<CartItemList>(context).addIteminList();
              }),
          Consumer<CartItemList>(builder: (context, items, child) {
            return ListView.builder(
                itemCount: items.cartItems.length,
                itemBuilder: (context, index) {
                  return CartItem(
                      items.cartItems[index].productId,
                      items.cartItems[index].productName,
                      items.cartItems[index].price,
                      items.cartItems[index].imageUrl);
                });
          }),
          Padding(
            padding: EdgeInsets.only(top: 0.6 * height),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Select payment Method',
                style: TextStyle(fontSize: 20),
              ),
              textColor: Colors.white,
              color: Color(0xFFED254E),
              onPressed: () => {},
            ),
          )
        ],
      ),
    );
  }
}
