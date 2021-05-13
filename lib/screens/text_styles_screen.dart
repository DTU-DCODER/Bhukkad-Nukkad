import 'package:flutter/material.dart';

class TextStylesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bhukkad Nukkad",
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "Heading 1",
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(
              "Heading 2",
              style: Theme.of(context).textTheme.headline2,
            ),
            Text(
              "Body Text 1",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              "Body Text 2",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            Text(
              "Subtitle1",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Text(
              "Subtitle 2",
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
      ),
    );
  }
}
