import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_shop/data/model/card_item.dart';
import 'package:flutter_ecommerce_shop/widgets/cached_Image.dart';
import 'package:hive_flutter/adapters.dart';

class TestScreen extends StatelessWidget {
  TestScreen({super.key});
  List<String> list = ['mobin', 'shayan', 'karzan'];

  @override
  Widget build(BuildContext context) {
    var box = Hive.box<BasketItem>('cardBox');
    return SafeArea(
      child: Scaffold(
        body: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Container(
                  color: Colors.black,
                  child: SizedBox(
                    child: CachedImage(
                      ImageUrl: box.values.toList()[index].thumbnail,
                    ),
                  ),
                ),
                Text(box.values.toList()[index].name),
                CachedImage(ImageUrl: box.values.toList()[index].thumbnail),
                Card()
              ],
            );
          },
          itemCount: box.values.toList().length,
          pagination: SwiperPagination.dots,
          control: SwiperControl(),
        ),
      ),
    );
  }
}
