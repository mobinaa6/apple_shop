import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_shop/constants/colors.dart';
import 'package:flutter_ecommerce_shop/widgets/cached_Image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../data/model/banner.dart';

class BannerSlider extends StatefulWidget {
  BannerSlider(this.bannerList, {super.key});
  List<BannerCampain> bannerList;

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  int currnetPage = 0;
  var controller = PageController(viewportFraction: 0.9, initialPage: 0);

  @override
  void initState() {
    // Timer _timer = Timer.periodic(Duration(seconds: 10), (timer) {
    //   if (currnetPage < 3) {
    //     currnetPage++;
    //   } else {
    //     currnetPage = 0;
    //   }
    //   controller.animateToPage(currnetPage,
    //       duration: Duration(seconds: 1), curve: Curves.easeIn);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 177,
          child: PageView.builder(
            controller: controller,
            itemCount: widget.bannerList.length,
            itemBuilder: (context, index) {
              return Container(
                  margin: EdgeInsets.symmetric(horizontal: 6),
                  child: CachedImage(
                    ImageUrl: widget.bannerList[index].thumbnail!,
                    radius: 15,
                  ));
            },
          ),
        ),
        Positioned(
          bottom: 12,
          child: SmoothPageIndicator(
            controller: controller,
            count: 3,
            effect: const ExpandingDotsEffect(
              expansionFactor: 5,
              dotHeight: 10,
              dotWidth: 10,
              dotColor: Colors.white,
              activeDotColor: CustomColors.blueIndicator,
            ),
          ),
        )
      ],
    );
  }
}
