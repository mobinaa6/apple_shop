import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_shop/data/datasource/category_dataresource.dart';
import 'package:flutter_ecommerce_shop/data/model/category.dart';
import 'package:flutter_ecommerce_shop/di/di.dart';
import 'package:flutter_ecommerce_shop/util/api_exception.dart';

abstract class ICategoryRepository {
  Future<Either<String, List<Category>>> getCatgories();
}

class CategoryRepository extends ICategoryRepository {
  final ICategoryDataSource _dataSource = locator.get();
  @override
  Future<Either<String, List<Category>>> getCatgories() async {
    try {
      var response = await _dataSource.getCategories();
      return Right(response);
    } on ApiException catch (ex) {
      return Left(ex.message ?? 'خطای محتوای متنی ندارد');
    }
  }
}
