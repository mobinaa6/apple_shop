import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_shop/bloc/category/category_bloc.dart';
import 'package:flutter_ecommerce_shop/bloc/category/category_event.dart';
import 'package:flutter_ecommerce_shop/bloc/category/category_state.dart';
import 'package:flutter_ecommerce_shop/bloc/categoryProduct/category_Product_bloc.dart';
import 'package:flutter_ecommerce_shop/constants/colors.dart';
import 'package:flutter_ecommerce_shop/data/model/category.dart';
import 'package:flutter_ecommerce_shop/screens/product_list_screen.dart';
import 'package:flutter_ecommerce_shop/widgets/cached_Image.dart';
import 'package:flutter_ecommerce_shop/widgets/loading_animatin.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Category>? list;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoryBloc>(context).add(CategoryRequestEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoadingState) {
            return const Center(
              child: Column(
                children: [
                  LoadingAnimation(),
                  Text('در حال اتصال به سرور'),
                ],
              ),
            );
          }
          return CustomScrollView(
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
                            'دسته بندی',
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
              if (state is CategoryRequestSuccessState) ...{
                state.response.fold((errroMessage) {
                  return SliverToBoxAdapter(
                    child: Text(errroMessage),
                  );
                }, (categoryList) {
                  return _ListCategory(categoryList: categoryList);
                })
              }
            ],
          );
        },
      ),
    ));
  }
}

// ignore: must_be_immutable
class _ListCategory extends StatelessWidget {
  List<Category>? categoryList;
  _ListCategory({Key? key, required this.categoryList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 44),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return BlocProvider(
                      create: (context) {
                        var bloc = CategoryProductBloc();
                        return bloc;
                      },
                      child: ProductListScreen(categoryList![index]));
                },
              ));
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedImage(
                    ImageUrl: categoryList?[index].thumbnail ?? 'test')),
          );
        }, childCount: categoryList?.length ?? 0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
      ),
    );
  }
}
