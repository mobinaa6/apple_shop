import 'package:dio/dio.dart';
import 'package:flutter_ecommerce_shop/bloc/basket/basket_bloc.dart';
import 'package:flutter_ecommerce_shop/data/datasource/authenication_datasource.dart';
import 'package:flutter_ecommerce_shop/data/datasource/banner_datasource.dart';
import 'package:flutter_ecommerce_shop/data/datasource/basket_datasource.dart';
import 'package:flutter_ecommerce_shop/data/datasource/category_dataresource.dart';
import 'package:flutter_ecommerce_shop/data/datasource/category_product_datasource.dart';
import 'package:flutter_ecommerce_shop/data/datasource/comment_datasource.dart';
import 'package:flutter_ecommerce_shop/data/datasource/product_datasource.dart';
import 'package:flutter_ecommerce_shop/data/datasource/product_detail_datasource.dart';
import 'package:flutter_ecommerce_shop/data/datasource/product_searched_datasource.dart';
import 'package:flutter_ecommerce_shop/data/repository/authentication_repository.dart';
import 'package:flutter_ecommerce_shop/data/repository/banner_repository.dart';
import 'package:flutter_ecommerce_shop/data/repository/basket_repository.dart';
import 'package:flutter_ecommerce_shop/data/repository/category_product_repository.dart';
import 'package:flutter_ecommerce_shop/data/repository/category_repository.dart';
import 'package:flutter_ecommerce_shop/data/repository/comment_repository.dart';
import 'package:flutter_ecommerce_shop/data/repository/product_detail_repository.dart';
import 'package:flutter_ecommerce_shop/data/repository/product_repository.dart';
import 'package:flutter_ecommerce_shop/util/dio_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.instance;
Future<void> getItInit() async {
  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
  locator.registerSingleton<Dio>(DioProvider.createDio());

  _initDataSource();
  _initRepositoy();
  locator.registerSingleton<BasketBloc>(BasketBloc());
}

//respoitory
void _initRepositoy() {
  locator.registerFactory<IAuthRepository>(() => AuthenticationRepository());

  locator.registerFactory<ICategoryRepository>(() => CategoryRepository());

  locator.registerFactory<IBannerRepository>(() => BannerRespository());

  locator.registerFactory<IProductRepository>(() => ProductRepository());

  locator.registerFactory<IDetailProductRepository>(
      () => DetailProductRepository());

  locator.registerFactory<ICategoryProductrepository>(
      () => CategoryProductRepository());

  locator.registerFactory<IBasketRepository>(() => BasketRepository());

  locator.registerFactory<ICommentRepository>(() => CommentRepostory());
}

//datasources
void _initDataSource() {
  locator
      .registerFactory<IauthenticationDataSource>(() => AuthenticationRemote());

  locator
      .registerFactory<ICategoryDataSource>(() => CategoryRemoteDataSource());

  locator.registerFactory<IBannerDataSource>(() => BannerRemotDataSource());

  locator.registerFactory<IProductDataSource>(() => ProductRemotDataSource());

  locator.registerFactory<IDetaiProductlDataSource>(
      () => DetailProductRemotDataSource());
  locator.registerFactory<ICategoryProductDataSource>(
      () => CategoryProductRemotDataSource());

  locator.registerFactory<IBasketDataSource>(() => BasketLoaclDataSource());
  locator.registerFactory<ICommentDataSource>(() => CommentRemotDataSource());

  locator.registerSingleton<IProductSearchedDataSource>(
      ProductSeachedRemotDataSource());
}
