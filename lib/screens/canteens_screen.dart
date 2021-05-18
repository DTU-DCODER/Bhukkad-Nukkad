import 'package:bhukkadnukkad/screens/canteen_meals_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/canteens.dart';
import '../providers/canteen.dart';

class CanteensScreen extends StatelessWidget {
  static const routeName = "/canteens-screen";
  @override
  Widget build(BuildContext context) {
    final canteensData = Provider.of<Canteens>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Bhukkad Nukkad",
            style: Theme.of(context).appBarTheme.textTheme.headline1),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: canteensData.canteens.length,
          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            value: canteensData.canteens[i],
            child: ElevatedButton(
              child: Text(
                canteensData.canteens[i].canteenName,
                style: Theme.of(context).textTheme.headline1,
              ),
              onPressed: () => Navigator.of(context).pushNamed(
                  CanteenMealsScreen.routeName,
                  arguments: canteensData.canteens[i].id),
            ),
          ),
        ),
      ),
    );
  }
}
