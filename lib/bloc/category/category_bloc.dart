import 'package:bloc/bloc.dart';
import 'package:flutter_ecommerce_shop/bloc/category/category_event.dart';
import 'package:flutter_ecommerce_shop/bloc/category/category_state.dart';
import 'package:flutter_ecommerce_shop/data/repository/category_repository.dart';
import 'package:flutter_ecommerce_shop/di/di.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ICategoryRepository _repository = locator.get();
  CategoryBloc() : super(CategoryInitState()) {
    on<CategoryRequestEvent>((event, emit) async {
      emit(CategoryLoadingState());
      var response = await _repository.getCatgories();
      emit(CategoryRequestSuccessState(response));
    });
  }
}
