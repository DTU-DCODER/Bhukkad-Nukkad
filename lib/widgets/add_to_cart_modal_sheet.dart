import 'package:flutter/material.dart';

import '../providers/meal.dart';

class AddToCartModalSheet extends StatefulWidget {
  int value;
  final Meal chosenMeal;
  AddToCartModalSheet(this.value, this.chosenMeal);
  @override
  _AddToCartModalSheetState createState() => _AddToCartModalSheetState();
}

class _AddToCartModalSheetState extends State<AddToCartModalSheet> {
  var _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final width = MediaQuery.of(context).size.width -
        MediaQuery.of(context).padding.left -
        MediaQuery.of(context).padding.right;
    //final   chosenMeal = Provider.of<Meal>(context);
    final List<String> keys = widget.chosenMeal.getKeys();
    return Scaffold(
      key: ValueKey("ModalBottomSheetScaffold"),
      body: Container(
        height: height * 0.7,
        padding: EdgeInsets.all(height * 0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.chosenMeal.title,
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  .copyWith(fontSize: height * 0.045),
            ),
            Divider(),
            Text(
              "Select any one option: ",
              style: TextStyle(fontSize: height * 0.03),
            ),
            SizedBox(height: height * 0.01),
            Container(
              height: height * 0.32,
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
                              fontSize: height * 0.029,
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
                    size: height * 0.05,
                    color: Colors.black,
                  ),
                  onTap: () {
                    if (widget.value == 1) return;
                    setState(() {
                      widget.value--;
                    });
                  },
                ),
                //SizedBox(width: 20),
                Text(
                  widget.value.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: height * 0.04,
                  ),
                ),
                //SizedBox(width: 12),
                InkWell(
                  child: Icon(
                    Icons.add_circle_outline,
                    size: height * 0.05,
                    color: Colors.black,
                  ),
                  onTap: () {
                    setState(() {
                      widget.value++;
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
                                  widget.value)
                              .toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: height * 0.02,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(widget.value.toString() +
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
