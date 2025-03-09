import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_shop/data/datasource/category_product_datasource.dart';
import 'package:flutter_ecommerce_shop/data/model/product.dart';
import 'package:flutter_ecommerce_shop/di/di.dart';

import '../../util/api_exception.dart';

abstract class ICategoryProductrepository {
  Future<Either<String, List<Product>>> getProductsByCategoryId(
      String CategoryId);
}

class CategoryProductRepository extends ICategoryProductrepository {
  ICategoryProductDataSource _datasource = locator.get();
  @override
  Future<Either<String, List<Product>>> getProductsByCategoryId(
      String CategoryId) async {
    try {
      var response = await _datasource.getProductByCategoryId(CategoryId);
      return Right(response);
    } on ApiException catch (ex) {
      return Left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
