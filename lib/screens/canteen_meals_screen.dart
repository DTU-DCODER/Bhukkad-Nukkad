import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../DUMMY_DATA.dart';
import '../widgets/previous_order_meal_tile.dart';
import '../widgets/canteen_meal_tile.dart';
import '../providers/meal.dart';
import '../providers/canteens.dart';
import './canteen_reviews_screen.dart';

class CanteenMealsScreen extends StatelessWidget {
  static const routeName = "/canteen-meals-screen";
  Widget buildTitle(BuildContext context, String text) {
    final width = (MediaQuery.of(context).size.width -
            MediaQuery.of(context).padding.left -
            MediaQuery.of(context).padding.right) *
        0.8;
    return Padding(
      padding: EdgeInsets.only(
        left: width * 0.04,
        bottom: width * 0.03,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .headline1
              .copyWith(fontSize: width * 0.065),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final canteenId = ModalRoute.of(context).settings.arguments;
    final chosenCanteen =
        Provider.of<Canteens>(context, listen: false).findById(canteenId);
    final height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    final width = MediaQuery.of(context).size.width -
        MediaQuery.of(context).padding.left -
        MediaQuery.of(context).padding.right;
    bool previousOrdersDoNotExist = previousOrders[canteenId].length == 0;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.075),
        child: AppBar(
          title: Text(
            chosenCanteen.canteenName,
            style: Theme.of(context).appBarTheme.textTheme.headline1,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.4,
              child: Stack(
                children: <Widget>[
                  Image.network(
                    "https://d34b8fs2z18t5a.cloudfront.net/wp-content/uploads/2019/08/google-maps-alternatives-featured-image-1024x512.png",
                    height: height * 0.4,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Center(
                    child: Container(
                      height: height * 0.15,
                      width: double.infinity,
                      color: Colors.black54,
                      child: Center(
                        child: Text(
                          chosenCanteen.canteenName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Impact",
                            fontSize: height * 0.13,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: InkWell(
                      child: Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Reviews",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            CanteenReviewsScreen.routeName,
                            arguments: canteenId);
                      },
                    ),
                  ),
                ],
              ),
            ),
            buildTitle(context, "Based on your previous orders"),
            previousOrdersDoNotExist
                ? Container(
                    height: height * 0.23,
                    child: Center(
                      child: Text(
                        "No previous orders yet!",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                  )
                : ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: height * 0.32),
                    child: ListView.builder(
                      itemCount: previousOrders[canteenId].length + 1,
                      itemBuilder: (ctx, index) {
                        if (index == 0) return SizedBox(width: 15);
                        index--;
                        final int chosenMealIndex = chosenCanteen.meals
                            .indexWhere((element) =>
                                element.id ==
                                    previousOrders[canteenId][index] &&
                                element.isAvailable);
                        if (chosenMealIndex != -1) {
                          final Meal chosenMeal =
                              chosenCanteen.meals[chosenMealIndex];
                          return ChangeNotifierProvider.value(
                            key: ValueKey("PreviousMeal" +
                                canteenId.toString() +
                                chosenMeal.id),
                            value: chosenMeal,
                            child: PreviousOrderMealTile(),
                          );
                        } else
                          return SizedBox(width: 0);
                      },
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
            buildTitle(context, "Items available now"),
            Column(
              children: chosenCanteen.meals.map((chosenMeal) {
                if (chosenMeal.isAvailable)
                  return MultiProvider(
                    providers: [
                      ChangeNotifierProvider.value(
                        key: ValueKey("CanteenMeal" +
                            canteenId.toString() +
                            chosenMeal.id),
                        value: chosenMeal,
                      ),
                      ChangeNotifierProvider.value(
                        key: ValueKey(canteenId),
                        value: chosenCanteen,
                      ),
                    ],
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: CanteenMealTile(),
                    ),
                  );
                else
                  return SizedBox(height: 0);
              }).toList(),
            ),
            Divider(color: Colors.white),
            Text(
              "Brought to you by the Bhukkad Nukkad Team",
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                  fontStyle: FontStyle.italic, fontSize: height * 0.018),
            ),
            Divider(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
