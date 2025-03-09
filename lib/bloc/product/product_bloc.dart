import 'package:bloc/bloc.dart';
import 'package:flutter_ecommerce_shop/bloc/product/product_event.dart';
import 'package:flutter_ecommerce_shop/bloc/product/product_state.dart';
import 'package:flutter_ecommerce_shop/data/repository/basket_repository.dart';
import 'package:flutter_ecommerce_shop/data/repository/product_detail_repository.dart';
import 'package:flutter_ecommerce_shop/di/di.dart';

import '../../data/model/card_item.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IDetailProductRepository _repository = locator.get();
  final IBasketRepository basketRepository = locator.get();

  ProductBloc() : super(ProductInitState()) {
    on<ProductinitializeEvent>((event, emit) async {
      emit(ProductLoadingState());
      final ProductImages = await _repository.getGallery(event.ProductId);
      final ProductVariant =
          await _repository.getProductVariants(event.ProductId);
      final ProductCategory =
          await _repository.getProductCategory(event.productCategoryId);
      final ProductPropertiess =
          await _repository.getProductProperties(event.ProductId);
      var commentList = await _repository.getComments(event.ProductId);

      emit(ProductDetailRequestSuccessState(ProductImages, ProductVariant,
          ProductCategory, ProductPropertiess, commentList));
    });
    on<ProductAddToBasketEvent>((event, emit) {
      var basketItem = BasketItem(
        event.product.id,
        event.product.collectionId,
        event.product.thumbnail,
        event.product.discount_price,
        event.product.price,
        event.product.name,
        event.product.categoryId,
      );
      basketRepository.addProductasket(basketItem);
    });
  }
}
