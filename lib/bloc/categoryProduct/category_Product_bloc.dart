import 'package:bloc/bloc.dart';
import 'package:flutter_ecommerce_shop/bloc/categoryProduct/category_product_event.dart';
import 'package:flutter_ecommerce_shop/bloc/categoryProduct/category_product_state.dart';
import 'package:flutter_ecommerce_shop/data/repository/category_product_repository.dart';
import 'package:flutter_ecommerce_shop/di/di.dart';

class CategoryProductBloc
    extends Bloc<CategoryProductEvent, CategoryProductstate> {
  ICategoryProductrepository _repository = locator.get();
  CategoryProductBloc() : super(CategoryProductInitstate()) {
    on<CategoryProductInitialize>((event, emit) async {
      emit(CategoryProductLoadingState());
      var ProductListByCategoryId =
          await _repository.getProductsByCategoryId(event.CategoryId);
      emit(CategoryProductRequestSuccessState(ProductListByCategoryId));
    });
  }
}
