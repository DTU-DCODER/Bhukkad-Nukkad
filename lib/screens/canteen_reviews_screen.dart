import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../providers/canteens.dart';
import '../widgets/stars.dart';
import '../widgets/review_item.dart';

class CanteenReviewsScreen extends StatelessWidget {
  static const routeName = "/canteen-reviews-screen";
  @override
  Widget build(BuildContext context) {
    final canteenId = ModalRoute.of(context).settings.arguments;
    final chosenCanteen = Provider.of<Canteens>(context).findById(canteenId);
    final reviews = chosenCanteen.reviews.values.toList();
    final averageRating = chosenCanteen.averageRating;
    final height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    final width = MediaQuery.of(context).size.width -
        MediaQuery.of(context).padding.left -
        MediaQuery.of(context).padding.right;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          chosenCanteen.canteenName,
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.25,
              padding: EdgeInsets.symmetric(
                vertical: height * 0.025,
                horizontal: width * 0.03,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/GlowingStar.png",
                            width: width * 0.12,
                            height: height * 0.05,
                          ),
                          SizedBox(width: width * 0.03),
                          Text(
                            "Reviews",
                            style:
                                Theme.of(context).textTheme.headline1.copyWith(
                                      fontSize: height * 0.04,
                                    ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width * 0.018),
                        child:
                            Stars(averageRating, height, width, Colors.black),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width * 0.03),
                        child: Row(
                          children: [
                            Text(
                              reviews.length.toString(),
                              style: TextStyle(
                                fontSize: height * 0.02,
                                fontWeight: FontWeight.bold,
                                fontFamily: "SF-Pro",
                              ),
                            ),
                            SizedBox(
                              width: width * 0.024,
                            ),
                            Text(
                              "Reviews",
                              style: TextStyle(
                                fontSize: height * 0.02,
                                fontFamily: "SF-Pro",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    "assets/images/ThumbsUpDown.png",
                    height: height * 0.2,
                  ),
                ],
              ),
            ),
            Column(
                children: reviews
                    .map((review) => ReviewItem(
                        dateTime: review.dateTime,
                        description: review.description,
                        rating: review.rating,
                        userName: review.userName))
                    .toList())
          ],
        ),
      ),
    );
  }
}
