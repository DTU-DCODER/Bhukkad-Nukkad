import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './stars.dart';

class ReviewItem extends StatelessWidget {
  final String userName;
  final int rating;
  final DateTime dateTime;
  final String description;
  ReviewItem({
    this.userName,
    this.rating,
    this.dateTime,
    this.description,
  });
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    final width = MediaQuery.of(context).size.width -
        MediaQuery.of(context).padding.left -
        MediaQuery.of(context).padding.right;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(height * 0.02),
      ),
      child: Padding(
        padding: EdgeInsets.all(height * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: Icon(Icons.perm_identity, color: Colors.white),
                  backgroundColor: Colors.black,
                ),
                SizedBox(width: width * 0.04),
                Text(
                  userName,
                  style: TextStyle(
                    fontFamily: "QuickSand",
                    fontSize: height * 0.025,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.015),
            Stars(rating.toDouble(), height * 0.8, width * 0.8,
                Theme.of(context).accentColor),
            SizedBox(height: height * 0.015),
            Text(
              " " + DateFormat("dd/MM/yyyy").format(dateTime),
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    fontSize: height * 0.015,
                  ),
            ),
            SizedBox(height: height * 0.015),
            if (description != "")
              Text(
                description,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontSize: height * 0.02,
                    ),
              )
          ],
        ),
      ),
    );
  }
}
