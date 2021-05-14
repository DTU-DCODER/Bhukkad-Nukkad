import 'package:flutter/material.dart';
// import 'UserSetting.dart';
import 'UserSettings.dart';

class CurrentOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Current Orders",
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
      ),
      body: RaisedButton(
        child: Text("goto Settings"),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => User()));
        },
      ),
    );
  }
}
