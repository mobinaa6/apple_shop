import 'package:dio/dio.dart';
import 'package:flutter_ecommerce_shop/data/model/product.dart';
import 'package:flutter_ecommerce_shop/di/di.dart';
import 'package:flutter_ecommerce_shop/util/api_exception.dart';

abstract class ICategoryProductDataSource {
  Future<List<Product>> getProductByCategoryId(String Categoryid);
}

class CategoryProductRemotDataSource extends ICategoryProductDataSource {
  Dio _dio = locator.get();
  @override
  Future<List<Product>> getProductByCategoryId(String Categoryid) async {
    var response;
    try {
      Map<String, String> qparams = {'filter': 'category="$Categoryid"'};
      if (Categoryid == '78q8w901e6iipuk') {
        response = await _dio.get('collections/products/records');
      } else {
        response = await _dio.get('collections/products/records',
            queryParameters: qparams);
      }
      return response.data['items']
          .map<Product>((jsonObject) => Product.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'onknow error');
    }
  }
}
