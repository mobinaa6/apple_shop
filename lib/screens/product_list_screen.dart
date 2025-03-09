import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_shop/bloc/categoryProduct/category_Product_bloc.dart';
import 'package:flutter_ecommerce_shop/bloc/categoryProduct/category_product_event.dart';
import 'package:flutter_ecommerce_shop/bloc/categoryProduct/category_product_state.dart';
import 'package:flutter_ecommerce_shop/constants/colors.dart';
import 'package:flutter_ecommerce_shop/data/model/category.dart';
import 'package:flutter_ecommerce_shop/data/model/product.dart';
import 'package:flutter_ecommerce_shop/widgets/product_item.dart';

class ProductListScreen extends StatefulWidget {
  Category category;
  ProductListScreen(this.category, {super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoryProductBloc>(context)
        .add(CategoryProductInitialize(widget.category.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.backgroundScreenColor,
        body: BlocBuilder<CategoryProductBloc, CategoryProductstate>(
          builder: (context, state) {
            return SafeArea(
              child: CustomScrollView(
                slivers: [
                  if (state is CategoryProductLoadingState) ...[
                    const SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  ],
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
                            Expanded(
                              child: Text(
                                widget.category.title!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
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
                  if (state is CategoryProductRequestSuccessState) ...{
                    state.ProductListByCategoryId.fold((ExpetionMessage) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Text(ExpetionMessage),
                        ),
                      );
                    }, (ProductList) {
                      return ProductListByCategoryId(ProductList);
                    })
                  }
                ],
              ),
            );
          },
        ));
  }
}

class ProductListByCategoryId extends StatelessWidget {
  List<Product> ProductList;
  ProductListByCategoryId(
    this.ProductList, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 39),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ProductItem(ProductList[index]);
          },
          childCount: ProductList.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 2.8,
          crossAxisSpacing: 15,
          mainAxisSpacing: 22,
        ),
      ),
    );
  }
}
