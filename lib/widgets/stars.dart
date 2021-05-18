import 'package:flutter/material.dart';

class Stars extends StatelessWidget {
  final double averageRating;
  final double height; //screen height, not height of stars
  final double width; //screen width, not width of stars
  final Color color;
  Stars(this.averageRating, this.height, this.width, this.color);

  @override
  Widget build(BuildContext context) {
    print(averageRating);
    final averageRatingInt = averageRating.toInt();
    final averageRatingFrac = averageRating - averageRatingInt;
    return SizedBox(
      width: width * 0.52,
      height: height * 0.03,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (ctx, i) {
          if (i < averageRatingInt) {
            //print("test");
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(height * 0.01),
                color: color,
              ),
              margin: EdgeInsets.symmetric(horizontal: width * 0.01),
              height: height * 0.032,
              width: height * 0.032,
              child: Icon(
                Icons.star,
                color: Colors.white,
                size: height * 0.02,
              ),
            );
          } else if (i == averageRatingInt && averageRatingInt != 5) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(height * 0.01),
                color: Colors.grey[300],
              ),
              margin: EdgeInsets.symmetric(horizontal: width * 0.01),
              height: height * 0.032,
              width: height * 0.032,
              child: Stack(
                children: [
                  FractionallySizedBox(
                    widthFactor: averageRatingFrac,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(height * 0.01),
                        ),
                        color: color,
                      ),
                    ),
                  ),
                  Center(
                    child: Icon(
                      Icons.star,
                      color: Colors.white,
                      size: height * 0.02,
                    ),
                  ),
                ],
              ),
            );
          } else if (i > averageRatingInt && i < 5)
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(height * 0.01),
                color: Colors.grey[300],
              ),
              margin: EdgeInsets.symmetric(horizontal: width * 0.01),
              height: height * 0.008,
              width: height * 0.032,
              child: Icon(
                Icons.star,
                color: Colors.white,
                size: height * 0.02,
              ),
            );
          else {
            return Center(
              child: Text(
                averageRating.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: height * 0.02,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
