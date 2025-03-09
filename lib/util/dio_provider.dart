import 'package:dio/dio.dart';
import 'package:flutter_ecommerce_shop/util/auth_manager.dart';

class DioProvider {
  static Dio createDio() {
    final Dio dio = Dio(
      BaseOptions(baseUrl: 'https://startflutter.ir/api/', headers: {
        'Content_type': 'application/json',
        'Authorization': 'Bearer ${AuthManager.readAuth()}'
      }),
    );
    return dio;
  }

  static Dio createDioWithOutHeader() {
    final Dio dio = Dio(
      BaseOptions(baseUrl: 'https://startflutter.ir/api/'),
    );
    return dio;
  }
}
