import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_shop/data/model/product.dart';

abstract class CategoryProductstate {}

class CategoryProductInitstate extends CategoryProductstate {}

class CategoryProductLoadingState extends CategoryProductstate {}

class CategoryProductRequestSuccessState extends CategoryProductstate {
  Either<String, List<Product>> ProductListByCategoryId;
  CategoryProductRequestSuccessState(this.ProductListByCategoryId);
}
