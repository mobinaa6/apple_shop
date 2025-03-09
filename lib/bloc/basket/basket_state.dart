import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_shop/data/model/card_item.dart';

abstract class BasketState {}

class BasketInitState extends BasketState {}

class BasketDataFetchedState extends BasketState {
  Either<String, List<BasketItem>> basketItemList;
  Either<String, int> finalprice;
  BasketDataFetchedState(this.basketItemList, this.finalprice);
}
