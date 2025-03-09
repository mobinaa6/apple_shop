import 'package:bloc/bloc.dart';
import 'package:flutter_ecommerce_shop/bloc/home/home_event.dart';
import 'package:flutter_ecommerce_shop/bloc/home/home_state.dart';
import 'package:flutter_ecommerce_shop/data/repository/banner_repository.dart';
import 'package:flutter_ecommerce_shop/data/repository/category_repository.dart';
import 'package:flutter_ecommerce_shop/data/repository/product_repository.dart';
import 'package:flutter_ecommerce_shop/di/di.dart';

class HomeBLoc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository _bannerRepository = locator.get();
  final ICategoryRepository _categoryRepository = locator.get();
  final IProductRepository _ProductRepository = locator.get();
  HomeBLoc() : super(HomeInitState()) {
    on<HomeGetInitilzedData>((event, emit) async {
      emit(HomeLoadingState());
      var bannerList = await _bannerRepository.getBanners();
      var categoryList = await _categoryRepository.getCatgories();
      var ProductList = await _ProductRepository.getProduct();
      var hotestProductList = await _ProductRepository.getHotest();
      var BestSellerProductList = await _ProductRepository.getBestSeller();

      emit(
        HomeRequestSuccessState(
          bannerList,
          categoryList,
          ProductList,
          hotestProductList,
          BestSellerProductList,
        ),
      );
    });
  }
}
