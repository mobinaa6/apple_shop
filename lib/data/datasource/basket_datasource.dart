import 'package:dio/dio.dart';
import 'package:flutter_ecommerce_shop/util/api_exception.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/card_item.dart';

abstract class IBasketDataSource {
  Future<void> addProduct(BasketItem basketItem);
  Future<List<BasketItem>> getAllBasketItems();
  Future<int> finalPrice();
}

class BasketLoaclDataSource extends IBasketDataSource {
  var box = Hive.box<BasketItem>('cardBox');

  @override
  Future<void> addProduct(BasketItem basketItem) async {
    box.add(basketItem);
  }

  @override
  Future<List<BasketItem>> getAllBasketItems() async {
    return box.values.toList();
  }

  @override
  Future<int> finalPrice() async {
    try {
      var finalprice = await box.values.toList().fold(
          0, (previousValue, element) => previousValue + element.realprice!);
      return finalprice;
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw ApiException(0, "unknow errro");
    }
  }
}
