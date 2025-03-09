import 'package:dio/dio.dart';
import 'package:flutter_ecommerce_shop/data/model/product.dart';
import 'package:flutter_ecommerce_shop/di/di.dart';
import 'package:flutter_ecommerce_shop/util/api_exception.dart';

abstract class IProductSearchedDataSource {
  Future<List<Product>> getProductSeachedList();
}

class ProductSeachedRemotDataSource extends IProductSearchedDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<Product>> getProductSeachedList() async {
    try {
      Map<String, String> qParams = {'filter': 'name~"اپل"'};
      var productSeachedList = await _dio.get('collections/products/records',
          queryParameters: qParams);

      return productSeachedList.data['items']
          .map<Product>((jsonObject) => Product.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknow error');
    }
  }
}
