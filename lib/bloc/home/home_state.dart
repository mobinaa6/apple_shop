import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_shop/data/model/banner.dart';
import 'package:flutter_ecommerce_shop/data/model/category.dart';
import 'package:flutter_ecommerce_shop/data/model/product.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeRequestSuccessState extends HomeState {
  Either<String, List<BannerCampain>> BannerList;
  Either<String, List<Category>> CategoryList;
  Either<String, List<Product>> ProductList;
  Either<String, List<Product>> hotestProductList;
  Either<String, List<Product>> BestSellerProductList;

  HomeRequestSuccessState(this.BannerList, this.CategoryList, this.ProductList,
      this.hotestProductList, this.BestSellerProductList);
}
