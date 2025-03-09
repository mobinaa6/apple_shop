import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_shop/bloc/basket/basket_bloc.dart';
import 'package:flutter_ecommerce_shop/bloc/basket/basket_event.dart';
import 'package:flutter_ecommerce_shop/bloc/category/category_bloc.dart';
import 'package:flutter_ecommerce_shop/bloc/category/category_event.dart';
import 'package:flutter_ecommerce_shop/bloc/category/category_state.dart';
import 'package:flutter_ecommerce_shop/bloc/home/home_bloc.dart';
import 'package:flutter_ecommerce_shop/bloc/home/home_event.dart';
import 'package:flutter_ecommerce_shop/bloc/home/home_state.dart';
import 'package:flutter_ecommerce_shop/constants/colors.dart';
import 'package:flutter_ecommerce_shop/data/model/card_item.dart';
import 'package:flutter_ecommerce_shop/di/di.dart';
import 'package:flutter_ecommerce_shop/screens/card_screen.dart';
import 'package:flutter_ecommerce_shop/screens/category_screen.dart';
import 'package:flutter_ecommerce_shop/screens/home_screen.dart';
import 'package:flutter_ecommerce_shop/screens/profile_screen.dart';
import 'package:hive_flutter/adapters.dart';

class DashbordScreen extends StatefulWidget {
  int SelectedBottomNavigationIndex = 3;
  DashbordScreen({super.key});
  @override
  State<DashbordScreen> createState() => _DashbordScreenState();
}

class _DashbordScreenState extends State<DashbordScreen> {
  var box = Hive.box<BasketItem>('cardBox');
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: IndexedStack(
            index: widget.SelectedBottomNavigationIndex,
            children: getScreens(),
          ),
          bottomNavigationBar: ClipRRect(
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: ValueListenableBuilder(
                  valueListenable: box.listenable(),
                  builder: (context, value, child) {
                    return BottomNavigationBar(
                      currentIndex: widget.SelectedBottomNavigationIndex,
                      onTap: (index) {
                        setState(() {
                          widget.SelectedBottomNavigationIndex = index;
                        });
                      },
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      selectedLabelStyle: const TextStyle(
                          fontFamily: 'SB',
                          fontSize: 10,
                          color: CustomColors.blue),
                      unselectedLabelStyle: const TextStyle(
                          fontFamily: 'SB', fontSize: 10, color: Colors.black),
                      items: [
                        BottomNavigationBarItem(
                          label: 'حساب کاربری',
                          icon: Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Image.asset('images/icon_profile.png'),
                          ),
                          activeIcon: Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Container(
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: CustomColors.blue,
                                      blurRadius: 20,
                                      spreadRadius: -7,
                                      offset: Offset(0.0, 12)),
                                ],
                              ),
                              child:
                                  Image.asset('images/icon_profile_active.png'),
                            ),
                          ),
                        ),
                        BottomNavigationBarItem(
                          label: 'سبد خرید',
                          icon: Stack(
                            children: <Widget>[
                              Image.asset('images/icon_basket.png'),
                              Positioned(
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 12,
                                    minHeight: 12,
                                  ),
                                  child: Text(
                                    '${value.length}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 8,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            ],
                          ),
                          activeIcon: Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Container(
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: CustomColors.blue,
                                      blurRadius: 20,
                                      spreadRadius: -7,
                                      offset: Offset(0.0, 12)),
                                ],
                              ),
                              child:
                                  Image.asset('images/icon_basket_active.png'),
                            ),
                          ),
                        ),
                        BottomNavigationBarItem(
                          label: 'دسته بندی',
                          icon: Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Image.asset('images/icon_category.png'),
                          ),
                          activeIcon: Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Container(
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: CustomColors.blue,
                                      blurRadius: 20,
                                      spreadRadius: -7,
                                      offset: Offset(0.0, 12)),
                                ],
                              ),
                              child: Image.asset(
                                  'images/icon_category_active.png'),
                            ),
                          ),
                        ),
                        BottomNavigationBarItem(
                          label: 'خانه',
                          icon: Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Image.asset('images/icon_home.png'),
                          ),
                          activeIcon: Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Container(
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: CustomColors.blue,
                                      blurRadius: 20,
                                      spreadRadius: -7,
                                      offset: Offset(0.0, 12)),
                                ],
                              ),
                              child: Image.asset('images/icon_home_active.png'),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                )),
          ),
        ));
  }
}

List<Widget> getScreens() {
  return <Widget>[
    ProfileScreen(),
    BlocProvider<BasketBloc>(
      create: (context) {
        var bloc = locator.get<BasketBloc>();

        bloc.add(BasketFetchFromHiveEvent());
        return bloc;
      },
      child: const CardScreen(),
    ),
    BlocProvider<CategoryBloc>(
      create: (context) {
        var bloc = CategoryBloc();
        bloc.add(CategoryRequestEvent());
        return bloc;
      },
      child: const CategoryScreen(),
    ),
    Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context) {
          var bloc = HomeBLoc();
          bloc.add(HomeGetInitilzedData());
          return bloc;
        },
        child: const HomeScreen(),
      ),
    )
  ];
}
