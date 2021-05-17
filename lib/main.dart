import 'package:bhukkadnukkad/screens/signup_screen.dart';
import 'package:flutter/material.dart';

import 'screens/text_styles_screen.dart';
import './screens/login_screen.dart';

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
    return MaterialApp(
      home: SplashPage(),
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
            color: Colors.grey,
            fontSize: 16,
          ),
          subtitle2: TextStyle(
            fontFamily: "SF-Pro",
            color: Colors.grey,
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
        ),
        appBarTheme: AppBarTheme(
          color: Color.fromRGBO(245, 143, 41, 1),
          textTheme: TextTheme(
            headline1: TextStyle(
              color: Colors.white,
              fontFamily: "FiraSans",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bhukkad Nukkad",
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
      ),
      body: LoginScreen(),
    );
  }
}

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignUpScreen(),
    );
  }
}
