import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/favorites.dart';
import '../providers/meal.dart';
import '../widgets/add_to_cart_modal_sheet.dart';

class CanteenMealTile extends StatefulWidget {
  final String canteenId;
  CanteenMealTile(this.canteenId);
  @override
  _CanteenMealTileState createState() => _CanteenMealTileState();
}

class _CanteenMealTileState extends State<CanteenMealTile> {
  int value = 1;
  bool isFav;
  @override
  Widget build(BuildContext context) {
    final height = (MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top);
    final width = (MediaQuery.of(context).size.width -
        MediaQuery.of(context).padding.left -
        MediaQuery.of(context).padding.right);
    final chosenMeal = Provider.of<Meal>(context);

    return Container(
      height: height * 0.1465,
      child: Card(
        elevation: 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
              chosenMeal.imageUrl,
              height: double.infinity,
              width: width * 0.22,
              fit: BoxFit.cover,
            ),
            SizedBox(width: width * 0.02),
            Container(
              width: width * 0.25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    chosenMeal.title,
                    softWrap: true,
                    style: TextStyle(fontSize: width * 0.045),
                  ),
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FittedBox(
                          child: Text(
                            "₹" + chosenMeal.price.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.041,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: width * 0.03),
                        if (value > 1)
                          FittedBox(
                            child: Text(
                              "₹${chosenMeal.price * value}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: width * 0.04,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //SizedBox(width: width * 0.07),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    child: Icon(
                      Icons.keyboard_arrow_up,
                      size: height * 0.029,
                      color: Colors.black,
                    ),
                    onTap: () {
                      if (value == 15) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
                  Text(
                    value.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: height * 0.02,
                    ),
                  ),
                  InkWell(
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: height * 0.029,
                      color: Colors.black,
                    ),
                    onTap: () {
                      if (value == 1) return;
                      setState(() {
                        value--;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(height * 0.01),
              padding: EdgeInsets.all(height * 0.008),
              width: width * 0.16,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).accentColor,
                ),
                borderRadius: BorderRadius.circular(height * 0.01),
              ),
              child: InkWell(
                child: FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "ADD",
                        style: TextStyle(
                            color: Colors.black, fontSize: width * 0.043),
                      ),
                      Text(
                        "+",
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: width * 0.043),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  if (chosenMeal.typesPrices != null) {
                    showModalBottomSheet(
                        context: context,
                        isDismissible: true,
                        builder: (context) =>
                            AddToCartModalSheet(value, chosenMeal));
                    setState(() {
                      value = 1;
                    });
                  } else {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(value.toString() +
                            " " +
                            chosenMeal.title +
                            " added to cart!"),
                        duration: const Duration(milliseconds: 1500),
                        width: MediaQuery.of(context).size.width - 80,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    );
                    setState(() {
                      value = 1;
                    });
                  }
                },
              ),
            ),
            Consumer<Favorites>(
              builder: (_, favoritesData, __) {
                isFav = favoritesData.isFav(widget.canteenId, chosenMeal.id);
                return IconButton(
                  icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: Theme.of(context).accentColor,
                    size: width * 0.08,
                  ),
                  onPressed: () {
                    setState(() {
                      if (isFav)
                        favoritesData.removeItem(
                            widget.canteenId, chosenMeal.id);
                      else
                        favoritesData.addItem(widget.canteenId, chosenMeal.id);
                      isFav = !isFav;
                    });
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
