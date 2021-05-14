import 'package:bhukkadnukkad/providers/favorites.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../DUMMY_DATA.dart';
import '../widgets/previous_order_meal_tile.dart';
import '../providers/meal.dart';
import '../providers/canteen.dart';
import '../providers/favorites.dart';
import '../widgets/canteen_meal_tile.dart';

class CanteenMealsScreen extends StatelessWidget {
  final canteenId = "c3";
  static const routeName = "/canteen-meals-screen";
  Widget buildTitle(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 26),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //print(previousOrders[canteenId].length);
    final Canteen chosenCanteen = canteenList.firstWhere(
      (element) => element.id == canteenId,
    );
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    bool previousOrdersDoNotExist = previousOrders[canteenId].length == 0;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.075),
        child: AppBar(
          title: Text(
            chosenCanteen.canteenName,
            style: Theme.of(context).appBarTheme.textTheme.headline1,
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
                            fontFamily: "FiraSans",
                            fontWeight: FontWeight.w900,
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
                      onTap: () {},
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
                    constraints: BoxConstraints(maxHeight: height * 0.40),
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
                          return PreviousOrderMealTile(
                            id: chosenMeal.id,
                            imageUrl: chosenMeal.imageUrl,
                            price: chosenMeal.price,
                            title: chosenMeal.title,
                          );
                        } else
                          return SizedBox(width: 0);
                      },
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
            buildTitle(context, "Items available now"),
            Container(
              height: height * 0.5,
              padding: EdgeInsets.only(left: 15, right: 15),
              child: ChangeNotifierProvider(
                create: (_) => Favorites(),
                child: ListView.builder(
                  itemCount: chosenCanteen.meals.length,
                  itemBuilder: (ctx, index) {
                    final Meal chosenMeal = chosenCanteen.meals[index];
                    if (chosenMeal.isAvailable)
                      return CanteenMealTile(
                        canteenId: canteenId,
                        id: chosenMeal.id,
                        imageUrl: chosenMeal.imageUrl,
                        price: chosenMeal.price,
                        title: chosenMeal.title,
                      );
                    else
                      return SizedBox(height: 0);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
