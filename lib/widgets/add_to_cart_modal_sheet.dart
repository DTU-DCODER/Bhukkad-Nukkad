import 'package:flutter/material.dart';

import '../providers/meal.dart';

class AddToCartModalSheet extends StatefulWidget {
  final int value;
  final Meal chosenMeal;
  AddToCartModalSheet(this.value, this.chosenMeal);
  @override
  _AddToCartModalSheetState createState() => _AddToCartModalSheetState(value);
}

class _AddToCartModalSheetState extends State<AddToCartModalSheet> {
  int value;
  _AddToCartModalSheetState(this.value);
  var _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final height = (MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top);
    final width = (MediaQuery.of(context).size.width -
        MediaQuery.of(context).padding.left -
        MediaQuery.of(context).padding.right);
    //final   chosenMeal = Provider.of<Meal>(context);
    final List<String> keys = widget.chosenMeal.getKeys();
    return Scaffold(
      key: ValueKey("ModalBottomSheetScaffold"),
      body: Container(
        height: height * 0.7,
        padding: EdgeInsets.all(height * 0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.chosenMeal.title,
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  .copyWith(fontSize: width * 0.09),
            ),
            Divider(),
            Text(
              "Select any one option: ",
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(fontSize: width * 0.04),
            ),
            SizedBox(height: height * 0.01),
            Container(
              height: height * 0.3,
              padding: EdgeInsets.all(height * 0.01),
              child: ListView.builder(
                itemCount: widget.chosenMeal.typesPrices.length,
                itemBuilder: (ctx, index) {
                  String currentType = keys[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        currentType,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: width * 0.055,
                            ),
                      ),
                      Row(
                        children: [
                          Text(
                            "₹" +
                                widget.chosenMeal.typesPrices[currentType]
                                    .toString(),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(fontSize: height * 0.018),
                          ),
                          IconButton(
                            icon: Icon(
                              (_selectedIndex == index)
                                  ? Icons.radio_button_on
                                  : Icons.radio_button_off,
                              color: Theme.of(context).accentColor,
                              size: height * 0.029,
                            ),
                            onPressed: () {
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                          )
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
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
                      "ADD - ₹" +
                          (widget.chosenMeal.typesPrices[keys[_selectedIndex]] *
                                  value)
                              .toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: height * 0.02,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      Navigator.of(context).pop(true);
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(value.toString() +
                              " " +
                              widget.chosenMeal.title +
                              " added to cart!"),
                          duration: const Duration(milliseconds: 1500),
                          width: MediaQuery.of(context).size.width - 80,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      );
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
