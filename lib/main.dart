import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/canteen_meals_screen.dart';
import './providers/canteens.dart';
import './providers/favorites.dart';
import './screens/canteen_reviews_screen.dart';
import './screens/canteens_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Map<int, Color> primarySwatchColorMap = {
    50: Color.fromRGBO(245, 143, 41, .1),
    100: Color.fromRGBO(245, 143, 41, .2),
    200: Color.fromRGBO(245, 143, 41, .3),
    300: Color.fromRGBO(245, 143, 41, .4),
    400: Color.fromRGBO(245, 143, 41, .5),
    500: Color.fromRGBO(245, 143, 41, .6),
    600: Color.fromRGBO(245, 143, 41, .7),
    700: Color.fromRGBO(245, 143, 41, .8),
    800: Color.fromRGBO(245, 143, 41, .9),
    900: Color.fromRGBO(245, 143, 41, 1),
  };
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          key: ValueKey("CanteensProvider"),
          create: (ctx) => Canteens(),
        ),
        ChangeNotifierProvider(
          key: ValueKey("FavoritesProvider"),
          create: (ctx) => Favorites(),
        )
      ],
      child: MaterialApp(
        home: CanteensScreen(),
        theme: ThemeData(
          primarySwatch: MaterialColor(0xfff58f29, primarySwatchColorMap),
          primaryColor: Color.fromRGBO(245, 143, 41, 1),
          accentColor: Color.fromRGBO(237, 37, 78, 1),
          textTheme: TextTheme(
            headline1: TextStyle(
              fontFamily: "FiraSans",
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            headline2: TextStyle(
              fontFamily: "FiraSans",
              fontSize: 32,
            ),
            bodyText1: TextStyle(
              fontFamily: "QuickSand",
              fontSize: 24,
            ),
            bodyText2: TextStyle(
              fontFamily: "SF-Pro",
              fontSize: 26,
              fontWeight: FontWeight.w300,
            ),
            subtitle1: TextStyle(
              fontFamily: "QuickSand",
              color: Colors.grey[700],
              fontSize: 16,
            ),
            subtitle2: TextStyle(
              fontFamily: "SF-Pro",
              color: Colors.grey[700],
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
          appBarTheme: AppBarTheme(
            color: Color.fromRGBO(245, 143, 41, 1),
            textTheme: TextTheme(
              headline1: TextStyle(
                color: Colors.white,
                fontFamily: "CFont",
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
        ),
        routes: {
          CanteenReviewsScreen.routeName: (ctx) => CanteenReviewsScreen(),
          CanteensScreen.routeName: (ctx) => CanteensScreen(),
          CanteenMealsScreen.routeName: (ctx) => CanteenMealsScreen(),
        },
      ),
    );
  }
}
