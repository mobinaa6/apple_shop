import 'package:dio/dio.dart';
import 'package:flutter_ecommerce_shop/data/model/product.dart';
import 'package:flutter_ecommerce_shop/di/di.dart';
import 'package:flutter_ecommerce_shop/util/api_exception.dart';

abstract class IProductDataSource {
  Future<List<Product>> getProducts();
  Future<List<Product>> getHotest();
  Future<List<Product>> getBestSeller();
}

class ProductRemotDataSource extends IProductDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<Product>> getProducts() async {
    try {
      var response = await _dio.get('collections/products/records');
      return response.data['items']
          .map<Product>((element) => Product.fromJson(element))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'onknow error');
    }
  }

  @override
  Future<List<Product>> getHotest() async {
    try {
      Map<String, String> qparams = {'filter': 'popularity="Hotest"'};

      var response = await _dio.get('collections/products/records',
          queryParameters: qparams);
      return response.data['items']
          .map<Product>((element) => Product.fromJson(element))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'onknow error');
    }
  }

  @override
  Future<List<Product>> getBestSeller() async {
    try {
      Map<String, String> qparams = {'filter': 'popularity="Best Seller"'};

      var response = await _dio.get('collections/products/records',
          queryParameters: qparams);
      return response.data['items']
          .map<Product>((element) => Product.fromJson(element))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'onknow error');
    }
  }
}
