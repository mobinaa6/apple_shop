import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_shop/bloc/basket/basket_bloc.dart';
import 'package:flutter_ecommerce_shop/bloc/basket/basket_state.dart';
import 'package:flutter_ecommerce_shop/constants/colors.dart';
import 'package:flutter_ecommerce_shop/util/extentions/double_extention.dart';
import 'package:flutter_ecommerce_shop/util/extentions/string_extention.dart';
import 'package:flutter_ecommerce_shop/widgets/cached_Image.dart';
import 'package:lottie/lottie.dart';
import 'package:zarinpal/zarinpal.dart';

import '../data/model/card_item.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  PaymentRequest _paymentRequest = PaymentRequest();
  @override
  void initState() {
    super.initState();
    _paymentRequest.setIsSandBox(true);
    _paymentRequest.setAmount(2000);
    _paymentRequest.setDescription("this is for test application apple shop");
    _paymentRequest.setCallbackURL('mobindeveloperandroid://eccomersshop');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: BlocBuilder<BasketBloc, BasketState>(
      builder: (context, state) {
        return Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 35, right: 35, bottom: 32, top: 15),
                    child: Container(
                      height: 46,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 16,
                          ),
                          Image.asset('images/icon_apple_blue.png'),
                          const Expanded(
                            child: Text(
                              'سبد خرید',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'SB',
                                  fontSize: 16,
                                  color: CustomColors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (state is BasketDataFetchedState) ...{
                  state.basketItemList.fold(
                    (exception) {
                      return SliverToBoxAdapter(
                        child: Text(exception),
                      );
                    },
                    (basketItemList) {
                      return basketItemList.isEmpty
                          ? SliverToBoxAdapter(
                              child: Lottie.network(
                                  'https://assets-v2.lottiefiles.com/a/09823a3e-117d-11ee-aa74-87493bf51c06/mctSeDWKYf.zip'))
                          : SliverList(
                              delegate:
                                  SliverChildBuilderDelegate((context, index) {
                                return CardItem(basketItemList[index]);
                              }, childCount: basketItemList.length),
                            );
                    },
                  )
                },
                const SliverPadding(padding: EdgeInsets.only(bottom: 80))
              ],
            ),
            if (state is BasketDataFetchedState) ...{
              state.finalprice.fold((l) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(l),
                  ),
                );
              }, (finalPrice) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 44, right: 44, bottom: 20),
                  child: SizedBox(
                    height: 53,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        ZarinPal().startPayment(
                            _paymentRequest, (status, paymentGatewayUri) {});
                      },
                      child: Text(
                        finalPrice > 0
                            ? finalPrice.FormatPriceWithCommas()
                            : "محصولی در سبد خرید نیست",
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'SM',
                        ),
                      ),
                    ),
                  ),
                );
              })
            }
          ],
        );
      },
    )));
  }
}

class CardItem extends StatefulWidget {
  BasketItem basketItem;

  CardItem(
    this.basketItem, {
    Key? key,
  }) : super(key: key);

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 249,
      margin: const EdgeInsets.only(left: 44, right: 44, bottom: 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.basketItem.name,
                          style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'sb',
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        const Text(
                          'گارانتی فیلان 18 ماهه',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'SM',
                              color: Colors.black),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 1),
                                child: Text(
                                  '3%',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'SB',
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            const Text(
                              'تومان',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'SM',
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            Text(
                              widget.basketItem.price
                                  .FormatPriceWithCommas()
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'SM',
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Wrap(
                          spacing: 8,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: CustomColors.red,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, bottom: 2, right: 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      'حذف',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                        color: CustomColors.red,
                                        fontFamily: 'sb',
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Image.asset('images/icon_trash.png')
                                  ],
                                ),
                              ),
                            ),
                            optionsCheapColor(
                              'ابی',
                              color: '8c0681',
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: SizedBox(
                        height: 104,
                        width: 74,
                        child:
                            CachedImage(ImageUrl: widget.basketItem.thumbnail)))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DottedLine(
              lineThickness: 3,
              dashColor: CustomColors.grey.withOpacity(0.5),
              dashLength: 8,
              dashGapLength: 3,
              dashGapColor: Colors.transparent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'تومان',
                  style: TextStyle(
                      fontFamily: 'sb', fontSize: 16, color: Colors.black),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '${widget.basketItem.realprice.FormatPriceWithCommas()}',
                  style: const TextStyle(
                      fontFamily: 'sb', fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class optionsCheapColor extends StatelessWidget {
  String? color;
  String title;

  optionsCheapColor(this.title, {Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: CustomColors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 2, bottom: 2, right: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 10,
            ),
            if (color != null) ...{
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.parsToColor(),
                ),
              )
            },
            const SizedBox(
              width: 10,
            ),
            Text(
              '$title',
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  fontFamily: 'sb', fontSize: 12, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
