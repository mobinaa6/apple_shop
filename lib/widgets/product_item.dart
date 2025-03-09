import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_shop/bloc/basket/basket_bloc.dart';
import 'package:flutter_ecommerce_shop/constants/colors.dart';
import 'package:flutter_ecommerce_shop/data/model/product.dart';
import 'package:flutter_ecommerce_shop/di/di.dart';
import 'package:flutter_ecommerce_shop/screens/product_detail_Screen.dart';
import 'package:flutter_ecommerce_shop/util/extentions/double_extention.dart';
import 'package:flutter_ecommerce_shop/widgets/cached_Image.dart';
import 'package:page_transition/page_transition.dart';

class ProductItem extends StatelessWidget {
  final Product _product;
  ProductItem(
    this._product, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.topToBottom,
            alignment: Alignment.center,
            duration: Duration(milliseconds: 300),
            reverseDuration: Duration(milliseconds: 300),
            child: BlocProvider.value(
              value: locator.get<BasketBloc>(),
              child: productDetailScreen(_product),
            ),
          ),
        );
      },
      child: Container(
        height: 216,
        width: 160,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Expanded(
                  child: Container(),
                ),
                SizedBox(
                  height: 98,
                  width: 98,
                  child: CachedImage(
                    ImageUrl: _product.thumbnail,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 10,
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: Image.asset('images/active_fav_product.png'),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    left: 6,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 1),
                        child: Text(
                          '%${_product.persent!.round()}',
                          style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'SB',
                              color: Colors.white),
                        ),
                      ),
                    ))
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, right: 10),
                  child: Text(
                    '${_product.name}',
                    textAlign: TextAlign.end,
                    maxLines: 1,
                    style: const TextStyle(
                        fontFamily: 'SM', fontSize: 14, color: Colors.black),
                  ),
                ),
                Container(
                  height: 53,
                  decoration: const BoxDecoration(
                      color: CustomColors.blue,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: CustomColors.blue,
                            blurRadius: 25,
                            spreadRadius: -12,
                            offset: Offset(0.0, 15))
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Text(
                          'تومان',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'SM',
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _product.price.FormatPriceWithCommas(),
                              style: const TextStyle(
                                  fontFamily: 'SM',
                                  fontSize: 12,
                                  color: Colors.white,
                                  decoration: TextDecoration.lineThrough),
                            ),
                            Text(
                              _product.realprice.FormatPriceWithCommas(),
                              style: const TextStyle(
                                fontFamily: 'SM',
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 24,
                          child:
                              Image.asset('images/icon_right_arrow_cricle.png'),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
