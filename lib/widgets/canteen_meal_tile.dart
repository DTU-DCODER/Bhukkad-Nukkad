import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/favorites.dart';

class CanteenMealTile extends StatefulWidget {
  final String canteenId;
  final String id;
  final String title;
  final double price;
  final String imageUrl;

  CanteenMealTile({
    @required this.canteenId,
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.imageUrl,
    //@required this.isFav,
  });
  @override
  _CanteenMealTileState createState() => _CanteenMealTileState();
}

class _CanteenMealTileState extends State<CanteenMealTile> {
  int value = 1;
  bool isFav;
  @override
  Widget build(BuildContext context) {
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final width = MediaQuery.of(context).size.width -
        MediaQuery.of(context).padding.left -
        MediaQuery.of(context).padding.right;
    final favoritesData = Provider.of<Favorites>(context);
    isFav = favoritesData.isFav(widget.canteenId, widget.id);
    return Container(
      padding: EdgeInsets.only(bottom: height * 0.01),
      height: height * 0.1465,
      child: Card(
        elevation: 5,
        child: Row(
          children: [
            Image.network(
              widget.imageUrl,
              height: double.infinity,
              width: width * 0.22,
              fit: BoxFit.cover,
            ),
            SizedBox(width: width * 0.02),
            Container(
              width: width * 0.255,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.title,
                    softWrap: true,
                    style: TextStyle(fontSize: height * 0.023),
                  ),
                  FittedBox(
                    child: Text(
                      "₹" + widget.price.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: height * 0.02,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            //SizedBox(width: width * 0.07),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  child: Icon(
                    Icons.keyboard_arrow_up,
                    size: height * 0.029,
                    color: Colors.black,
                  ),
                  onTap: () {
                    setState(() {
                      value++;
                    });
                  },
                ),
                Text(
                  value.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: height * 0.02,
                  ),
                ),
                InkWell(
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: height * 0.029,
                    color: Colors.black,
                  ),
                  onTap: () {
                    if (value == 1) return;
                    setState(() {
                      value--;
                    });
                  },
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(height * 0.01),
              padding: EdgeInsets.all(height * 0.008),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).accentColor,
                ),
                borderRadius: BorderRadius.circular(height * 0.01),
              ),
              child: InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "ADD",
                      style: TextStyle(
                          color: Colors.black, fontSize: height * 0.025),
                    ),
                    Text(
                      "+",
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: height * 0.025),
                    ),
                  ],
                ),
                onTap: () {},
              ),
            ),
            IconButton(
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: Theme.of(context).accentColor,
                size: height * 0.04,
              ),
              onPressed: () {
                setState(() {
                  if (isFav)
                    favoritesData.removeItem(widget.canteenId, widget.id);
                  else
                    favoritesData.addItem(widget.canteenId, widget.id);
                  isFav = !isFav;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
