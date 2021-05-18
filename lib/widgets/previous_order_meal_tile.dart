import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_to_cart_modal_sheet.dart';
import '../providers/meal.dart';

class PreviousOrderMealTile extends StatefulWidget {
  @override
  _PreviousOrderMealTileState createState() => _PreviousOrderMealTileState();
}

class _PreviousOrderMealTileState extends State<PreviousOrderMealTile> {
  int value = 1;
  bool pressAttention = true;
  @override
  Widget build(BuildContext context) {
    final height = (MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top -
            MediaQuery.of(context).padding.bottom) *
        0.8;
    final width = (MediaQuery.of(context).size.width -
            MediaQuery.of(context).padding.left -
            MediaQuery.of(context).padding.right) *
        0.8;
    final Meal chosenMeal = Provider.of<Meal>(context, listen: false);
    final Widget imagePrice = ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(height * 0.05),
        topRight: Radius.circular(height * 0.05),
      ),
      child: Stack(
        children: <Widget>[
          Image.network(
            chosenMeal.imageUrl,
            fit: BoxFit.cover,
            height: height * 0.23,
            width: double.infinity,
          ),
          Positioned(
            top: height * 0.012,
            left: height * 0.012,
            child: Container(
              height: height * 0.085,
              width: height * 0.085,
              child: Card(
                elevation: 5,
                shape: CircleBorder(),
                color: Colors.white,
                child: FittedBox(
                  child: Padding(
                    padding: EdgeInsets.all(height * 0.004),
                    child: Text(
                      "₹" + chosenMeal.price.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          .copyWith(fontSize: height * 0.01),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    return Container(
      width: height * 0.35,
      height: height * 0.35,
      child: Column(
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(height * 0.05),
            ),
            elevation: 5,
            child: Column(
              children: <Widget>[
                imagePrice,
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(height * 0.05),
                      bottomRight: Radius.circular(height * 0.05),
                    ),
                    color: Theme.of(context).accentColor,
                  ),
                  height: height * 0.073,
                  padding: EdgeInsets.all(height * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        child: Icon(
                          Icons.remove_circle_outline,
                          size: width * 0.076,
                          color: Colors.white,
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
                          color: Colors.white,
                          fontSize: width * 0.04,
                        ),
                      ),
                      //SizedBox(width: 12),
                      InkWell(
                        child: Icon(
                          Icons.add_circle_outline,
                          size: width * 0.076,
                          color: Colors.white,
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

                      Container(
                        constraints: BoxConstraints(minHeight: height * 0.01),
                        padding: EdgeInsets.all(height * 0.007),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: pressAttention
                                ? Colors.white
                                : Theme.of(context).accentColor,
                          ),
                          color: pressAttention
                              ? Theme.of(context).accentColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(height * 0.015),
                        ),
                        width: width * 0.13,
                        height: height * 0.04,
                        child: InkWell(
                          child: Center(
                            child: Text(
                              "ADD",
                              style: TextStyle(
                                color: pressAttention
                                    ? Colors.white
                                    : Theme.of(context).accentColor,
                                fontSize: width * 0.032,
                              ),
                            ),
                          ),
                          onTapDown: (_) => setState(() {
                            pressAttention = !pressAttention;
                          }),
                          onTap: () {
                            setState(() {
                              pressAttention = !pressAttention;
                            });
                            if (chosenMeal.typesPrices != null) {
                              showModalBottomSheet(
                                      context: context,
                                      isDismissible: true,
                                      builder: (context) => AddToCartModalSheet(
                                          value, chosenMeal))
                                  .then((returnValue) => setState(() {
                                        if (returnValue) value = 1;
                                      }));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
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
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: width * 0.055,
              top: height * 0.013,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    child: Text(
                      chosenMeal.title,
                      style: Theme.of(context).textTheme.headline1.copyWith(
                          fontSize: height * 0.034,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  if (value > 1)
                    Text(
                      "₹${chosenMeal.price * value}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: width * 0.06,
                      ),
                    ),
                  SizedBox(width: width * 0.0001),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
