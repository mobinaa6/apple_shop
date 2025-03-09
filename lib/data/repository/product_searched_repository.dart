import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_shop/data/datasource/product_searched_datasource.dart';
import 'package:flutter_ecommerce_shop/data/model/product.dart';
import 'package:flutter_ecommerce_shop/di/di.dart';
import 'package:flutter_ecommerce_shop/util/api_exception.dart';

abstract class IProductSeachedRepository {
  Future<Either<String, List<Product>>> productSearchedList();
}

class ProductSearchedRepository extends IProductSeachedRepository {
  final IProductSearchedDataSource _dataSource = locator.get();
  @override
  Future<Either<String, List<Product>>> productSearchedList() async {
    try {
      var response = await _dataSource.getProductSeachedList();
      return Right(response);
    } on ApiException catch (ex) {
      return Left(ex.message!);
    }
  }
}
