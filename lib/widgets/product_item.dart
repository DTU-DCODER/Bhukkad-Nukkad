import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/auth.dart';
import '../widgets/add_to_cart_modal_sheet.dart';

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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GridTile(
          child: Image.network(
            product.imageUrl!,
            fit: BoxFit.cover,
          ),
          footer: Container(
            color: Colors.black87,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Consumer<Product>(
                  builder: (ctx, product, _) => IconButton(
                    icon: Icon(product.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border),
                    onPressed: () => product.toggleFavoriteStatus(
                        authData.token, authData.userId),
                    color: Theme.of(context).accentColor,
                  ),
                ),
                Flexible(
                  child: Text(
                    product.title!,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Material(
                  shape: CircleBorder(),
                  //type: MaterialType.circle,
                  clipBehavior: Clip.none,
                  color: Colors.black87,
                  child: Container(
                    height: 45,
                    width: 45,
                    child: InkWell(
                      customBorder: CircleBorder(),
                      child: Icon(
                        Icons.shopping_cart,
                        color: Theme.of(context).accentColor,
                      ),
                      onTap: () => {
                        showModalBottomSheet(
                            context: context,
                            builder: (_) => AddToCartModalSheet(product.id!))
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
