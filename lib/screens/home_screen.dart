import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_shop/bloc/home/home_bloc.dart';
import 'package:flutter_ecommerce_shop/bloc/home/home_event.dart';
import 'package:flutter_ecommerce_shop/bloc/home/home_state.dart';
import 'package:flutter_ecommerce_shop/constants/colors.dart';
import 'package:flutter_ecommerce_shop/data/model/banner.dart';
import 'package:flutter_ecommerce_shop/data/model/category.dart';
import 'package:flutter_ecommerce_shop/data/model/product.dart';
import 'package:flutter_ecommerce_shop/data/repository/product_searched_repository.dart';
import 'package:flutter_ecommerce_shop/screens/category_icon_item_chip.dart';
import 'package:flutter_ecommerce_shop/widgets/banner_slider.dart';
import 'package:flutter_ecommerce_shop/widgets/item_product_search.dart';
import 'package:flutter_ecommerce_shop/widgets/loading_animatin.dart';
import 'package:flutter_ecommerce_shop/widgets/product_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool asdjopa = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(
                  'از اپلیکیشن خارج میشوید؟',
                  textAlign: TextAlign.end,
                ),
                actions: [
                  ElevatedButton(onPressed: () {}, child: Text('نه')),
                  ElevatedButton(
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      child: Text('اره')),
                ],
              );
            },
          );
          return asdjopa;
        },
        child: Scaffold(
            body: BlocBuilder<HomeBLoc, HomeState>(builder: (context, state) {
          return getHomeScreenContent(state, context);
        })),
      ),
    );
  }
}

Widget getHomeScreenContent(HomeState state, BuildContext context) {
  if (state is HomeLoadingState) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [LoadingAnimation(), Text('در حال اتصال به سرور')],
      ),
    );
  } else if (state is HomeRequestSuccessState) {
    return RefreshIndicator(
      color: CustomColors.blue,
      onRefresh: () async {
        context.read<HomeBLoc>().add(HomeGetInitilzedData());
      },
      child: CustomScrollView(
        slivers: [
          _getSearchBox(),
          state.BannerList.fold((exceptionMessage) {
            return SliverToBoxAdapter(
              child: Center(
                child: Text(exceptionMessage),
              ),
            );
          }, (listBanner) {
            return _getBanners(listBanner);
          }),
          const _getCategoryListTitle(),
          state.CategoryList.fold((exceptionMessage) {
            return SliverToBoxAdapter(
              child: Center(
                child: Text(exceptionMessage),
              ),
            );
          }, (categoryList) {
            return _getCategoryList(categoryList);
          }),
          const _getBestSellerTitle(),
          state.BestSellerProductList.fold((exceptionMessage) {
            return SliverToBoxAdapter(
              child: Center(
                child: Text(exceptionMessage),
              ),
            );
          }, (bestSellerProductList) {
            return _getBestSellerProduct(bestSellerProductList);
          }),
          const _getMostViewTitle(),
          state.hotestProductList.fold(
            (exceptionMessage) {
              return SliverToBoxAdapter(
                child: Center(
                  child: Text(exceptionMessage),
                ),
              );
            },
            (hotestProductList) {
              return _getMostViewProduct(hotestProductList);
            },
          ),
        ],
      ),
    );
  } else {
    return const Center(
      child: Text('خطایی در دریافت اطلاعات به وجودآمده است'),
    );
  }
}

class _getMostViewProduct extends StatelessWidget {
  List<Product> productList;
  _getMostViewProduct(
    this.productList, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 44, bottom: 24),
        child: SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ProductItem(productList[index])
                  // ProductItem(),
                  );
            },
          ),
        ),
      ),
    );
  }
}

class _getMostViewTitle extends StatelessWidget {
  const _getMostViewTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 44, right: 44, top: 32, bottom: 20),
            child: Row(
              children: [
                const Text(
                  'پر بازدید ترین ها',
                  style: TextStyle(
                      fontFamily: 'Sb', fontSize: 12, color: CustomColors.grey),
                ),
                const Spacer(),
                Image.asset('images/icon_left_category.png'),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'مشاهده همه',
                  style: TextStyle(
                    color: CustomColors.blue,
                    fontFamily: 'SB',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _getBestSellerProduct extends StatelessWidget {
  List<Product> produtList;
  _getBestSellerProduct(
    this.produtList, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 44),
        child: SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: produtList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ProductItem(produtList[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _getBestSellerTitle extends StatelessWidget {
  const _getBestSellerTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 44, right: 44, bottom: 20),
        child: Row(
          children: [
            const Text(
              'پرفروش ترین ها',
              style: TextStyle(
                  fontFamily: 'Sb', fontSize: 12, color: CustomColors.grey),
            ),
            const Spacer(),
            const Text(
              'مشاهده همه',
              style: TextStyle(
                color: CustomColors.blue,
                fontFamily: 'SB',
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Image.asset('images/icon_left_category.png'),
          ],
        ),
      ),
    );
  }
}

class _getCategoryList extends StatelessWidget {
  List<Category> listCategories;
  _getCategoryList(
    this.listCategories, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          right: 40,
        ),
        child: SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listCategories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: CategoryItemChip(listCategories[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _getCategoryListTitle extends StatelessWidget {
  const _getCategoryListTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(left: 44, right: 44, bottom: 20, top: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'دسته بندی',
              style: TextStyle(
                  fontFamily: 'Sb', fontSize: 12, color: CustomColors.grey),
            )
          ],
        ),
      ),
    );
  }
}

class _getBanners extends StatelessWidget {
  List<BannerCampain> bannerCampain;

  _getBanners(
    this.bannerCampain, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BannerSlider(bannerCampain),
    );
  }
}

class _getSearchBox extends StatefulWidget {
  _getSearchBox({
    Key? key,
  }) : super(key: key);

  @override
  State<_getSearchBox> createState() => _getSearchBoxState();
}

class _getSearchBoxState extends State<_getSearchBox> {
  List<Product> productSearched = [];
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 35, right: 35, bottom: 32, top: 15),
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
                  Image.asset('images/icon_search.png'),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextField(
                        onChanged: (value) async {
                          var repo = ProductSearchedRepository();
                          var either = await repo.productSearchedList();
                          either.fold((l) => null, (r) {
                            setState(() {
                              productSearched = r;
                            });
                          });
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Image.asset('images/icon_apple_blue.png'),
                  const SizedBox(
                    width: 16,
                  ),
                ],
              ),
            ),
          ),
          Container(
              padding: const EdgeInsets.only(top: 20),
              height: 800,
              width: 700,
              color: Colors.red,
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return productSearched.isNotEmpty
                            ? ItemProductSearch(productSearched[index])
                            : Text('محصولی وجود ندارد');
                      },
                      childCount:
                          productSearched.isEmpty ? 1 : productSearched.length,
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
