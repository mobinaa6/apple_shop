import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_shop/bloc/categoryProduct/category_Product_bloc.dart';
import 'package:flutter_ecommerce_shop/data/model/category.dart';
import 'package:flutter_ecommerce_shop/screens/product_list_screen.dart';
import 'package:flutter_ecommerce_shop/widgets/cached_Image.dart';

class CategoryItemChip extends StatelessWidget {
  final Category category;

  const CategoryItemChip(
    this.category, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String categorycolor = 'ff${category.color}';
    int hexcolor = int.parse(categorycolor, radix: 16);
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) {
                return CategoryProductBloc();
              },
              child: ProductListScreen(category),
            );
          },
        ));
      },
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 56,
                width: 56,
                decoration: ShapeDecoration(
                  color: Color(hexcolor),
                  shadows: const [
                    BoxShadow(
                        color: Colors.blue,
                        blurRadius: 25,
                        spreadRadius: -15,
                        offset: Offset(0, 15)),
                  ],
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              SizedBox(
                  height: 20,
                  width: 20,
                  child: CachedImage(ImageUrl: category.icon!))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '${category.title}',
            style: const TextStyle(fontFamily: 'SB', fontSize: 12),
          ),
        ],
      ),
    );
  }
}
