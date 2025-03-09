import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_shop/data/model/category.dart';
import 'package:flutter_ecommerce_shop/data/model/comment.dart';
import 'package:flutter_ecommerce_shop/data/model/product_image.dart';
import 'package:flutter_ecommerce_shop/data/model/product_properties.dart';
import 'package:flutter_ecommerce_shop/data/model/product_variant.dart';

abstract class ProductState {}

class ProductInitState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductDetailRequestSuccessState extends ProductState {
  Either<String, List<ProductImage>> ProductImageList;
  Either<String, List<Productvariant>> ProductVariant;
  Either<String, Category> ProductCategory;
  Either<String, List<Property>> productProperties;
  Either<String, List<Comment>> commentList;

  ProductDetailRequestSuccessState(this.ProductImageList, this.ProductVariant,
      this.ProductCategory, this.productProperties, this.commentList);
}
