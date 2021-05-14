import 'package:flutter/material.dart';
import 'CurrentOrders.dart';

class UserSettings extends StatelessWidget {
  static const Color white = Color(0xFFFFFFFF);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Settings",
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
      ),
      body: Container(
        child: Container(
          margin: const EdgeInsets.only(top: 150, bottom: 0),
          // padding: const EdgeInsets.only(top: 120),
          width: 400,
          height: 1000,
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              RaisedButton(
                color: Colors.white,
                onPressed: () => ("hello WOrld"),
                padding:
                    EdgeInsets.only(top: 15, bottom: 15, left: 40, right: 40),
                child: Text(
                  "Personal Details",
                  style: Theme.of(context).textTheme.headline3,
                ),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
              RaisedButton(
                color: Colors.white,
                onPressed: () => ("hello WOrld"),
                padding:
                    EdgeInsets.only(top: 15, bottom: 15, left: 40, right: 40),
                child: Text(
                  "Order History",
                  style: Theme.of(context).textTheme.headline3,
                ),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
              RaisedButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CurrentOrders()));
                },
                padding:
                    EdgeInsets.only(top: 15, bottom: 15, left: 40, right: 40),
                child: Text(
                  "Current Orders",
                  style: Theme.of(context).textTheme.headline3,
                ),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
              RaisedButton(
                color: Colors.white,
                onPressed: () => ("hello WOrld"),
                padding:
                    EdgeInsets.only(top: 15, bottom: 15, left: 40, right: 40),
                child: Text(
                  "About Us",
                  style: Theme.of(context).textTheme.headline3,
                ),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
              RaisedButton(
                color: Colors.white,
                onPressed: () => ("hello WOrld"),
                padding:
                    EdgeInsets.only(top: 15, bottom: 15, left: 40, right: 40),
                child: Text(
                  "Reset Password",
                  style: Theme.of(context).textTheme.headline3,
                ),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
