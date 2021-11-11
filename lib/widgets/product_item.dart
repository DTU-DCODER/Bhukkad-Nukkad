import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/auth.dart';
import '../screens/add_to_cart_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    //final cart = Provider.of<Cart>(context, listen: false);
    return Card(
      //
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      child: InkWell(
        splashColor: Colors.white,
        onTap: () {
          Navigator.of(context)
              .pushNamed(AddToCartScreen.routeName, arguments: product.id);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Row(
            children: [
              Stack(
                children: [
                  Hero(
                    tag: product.id!,
                    child: FadeInImage(
                      image: NetworkImage(product.imageUrl!),
                      placeholder: AssetImage("assets/images/loading.gif"),
                      fit: BoxFit.cover,
                      height: 150,
                      width: 150,
                    ),
                  ),
                  Consumer<Product>(
                    builder: (ctx, product, _) => IconButton(
                      icon: Icon(
                        product.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 30,
                        color: Colors.red,
                      ),
                      onPressed: () => product.toggleFavoriteStatus(
                          authData.token, authData.userId),
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 150,
                  color: Colors.black87,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          product.title!,
                          // textAlign: TextAlign.center,
                          softWrap: true,
                          //  overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.raleway(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        product.description!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Text(
                          "₹${product.price.toString()}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            color: Colors.green[800],
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
