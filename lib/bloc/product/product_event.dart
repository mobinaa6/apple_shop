import 'package:flutter_ecommerce_shop/data/model/product.dart';

abstract class ProductEvent {}

class ProductinitializeEvent extends ProductEvent {
  String ProductId;
  String productCategoryId;

  ProductinitializeEvent(
    this.ProductId,
    this.productCategoryId,
  );
}

class ProductAddToBasketEvent extends ProductEvent {
  Product product;
  ProductAddToBasketEvent(this.product);
}
