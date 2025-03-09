import 'package:bloc/bloc.dart';
import 'package:flutter_ecommerce_shop/bloc/basket/basket_event.dart';
import 'package:flutter_ecommerce_shop/bloc/basket/basket_state.dart';
import 'package:flutter_ecommerce_shop/data/repository/basket_repository.dart';
import 'package:flutter_ecommerce_shop/di/di.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final IBasketRepository basketRepository = locator.get();
  BasketBloc() : super(BasketInitState()) {
    on<BasketFetchFromHiveEvent>((event, emit) async {
      var basketItemList = await basketRepository.getAllBasketItems();
      var finalprice = await basketRepository.finalPrice();
      emit(BasketDataFetchedState(basketItemList, finalprice));
    });
  }
}
