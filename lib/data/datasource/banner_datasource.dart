import 'package:dio/dio.dart';
import 'package:flutter_ecommerce_shop/data/model/banner.dart';
import 'package:flutter_ecommerce_shop/di/di.dart';
import 'package:flutter_ecommerce_shop/util/api_exception.dart';

abstract class IBannerDataSource {
  Future<List<BannerCampain>> getBanner();
}

class BannerRemotDataSource extends IBannerDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<BannerCampain>> getBanner() async {
    try {
      var response = await _dio.get('collections/banner/records');
      return response.data['items']
          .map<BannerCampain>((element) => BannerCampain.fromjson(element))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown error');
    }
  }
}
