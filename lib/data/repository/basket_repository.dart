import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_shop/data/datasource/basket_datasource.dart';
import 'package:flutter_ecommerce_shop/data/model/card_item.dart';
import 'package:flutter_ecommerce_shop/di/di.dart';
import 'package:flutter_ecommerce_shop/util/api_exception.dart';

abstract class IBasketRepository {
  Future<Either<String, String>> addProductasket(BasketItem basketItem);
  Future<Either<String, List<BasketItem>>> getAllBasketItems();
  Future<Either<String, int>> finalPrice();
}

class BasketRepository extends IBasketRepository {
  final IBasketDataSource _dataSource = locator.get();

  @override
  Future<Either<String, String>> addProductasket(BasketItem basketItem) async {
    try {
      await _dataSource.addProduct(basketItem);
      return Right('محصول به سبد خرید اضافه شد');
    } catch (ex) {
      return Left('خطادر افزودن محصول بهسبد خرید');
    }
  }

  @override
  Future<Either<String, List<BasketItem>>> getAllBasketItems() async {
    try {
      var basketItems = await _dataSource.getAllBasketItems();
      return Right(basketItems);
    } catch (ex) {
      return Left('حطا در نمایش محصولات');
    }
  }

  @override
  Future<Either<String, int>> finalPrice() async {
    try {
      var result = await _dataSource.finalPrice();
      return Right(result);
    } on ApiException catch (ex) {
      return Left(ex.message!);
    }
  }
}
