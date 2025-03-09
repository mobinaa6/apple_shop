import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_shop/data/model/category.dart';

abstract class CategoryState {}

class CategoryInitState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryRequestSuccessState extends CategoryState {
  Either<String, List<Category>> response;
  CategoryRequestSuccessState(this.response);
}
