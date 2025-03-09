import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_shop/data/model/product.dart';
import 'package:flutter_ecommerce_shop/util/extentions/double_extention.dart';

class ItemProductSearch extends StatelessWidget {
  const ItemProductSearch(this.product, {super.key});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.blue,
        height: 120,
        width: 120,
        margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
        child: Row(
          children: [
            Image.network(
              product.thumbnail,
              height: 100,
            ),
            const SizedBox(
              width: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    product.name,
                    softWrap: false,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'dana',
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      product.price.FormatPriceWithCommas(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'dana',
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.red,
                          decorationThickness: 5),
                    ),
                    const Text(
                      ':قیمت',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'dana',
                      ),
                    ),
                  ],
                ),
                Text(
                  'با تخفیف :${product.realprice}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'dana',
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
