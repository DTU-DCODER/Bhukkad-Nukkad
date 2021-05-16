import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final Widget child;
  final String value;

  Badge(this.child, this.value);

  Widget labelBuilder(BuildContext context) => CircleAvatar(
        backgroundColor: Theme.of(context).accentColor,
        minRadius: 5,
        maxRadius: (MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top) *
            0.013,
        child: FittedBox(
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10),
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    if (value == "0") {
      return Center(child: child);
    } else {
      print("Hello");
      return Stack(
        alignment: Alignment.center,
        children: [
          child,
          Positioned(
            top: 1,
            right: 1,
            child: labelBuilder(context),
          ),
        ],
      );
    }
  }
}
