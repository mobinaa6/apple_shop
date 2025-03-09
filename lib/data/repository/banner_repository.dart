import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_shop/data/datasource/banner_datasource.dart';
import 'package:flutter_ecommerce_shop/data/model/banner.dart';
import 'package:flutter_ecommerce_shop/di/di.dart';
import 'package:flutter_ecommerce_shop/util/api_exception.dart';

abstract class IBannerRepository {
  Future<Either<String, List<BannerCampain>>> getBanners();
}

class BannerRespository extends IBannerRepository {
  final IBannerDataSource _dataSource = locator.get();

  @override
  Future<Either<String, List<BannerCampain>>> getBanners() async {
    try {
      var response = await _dataSource.getBanner();
      return Right(response);
    } on ApiException catch (ex) {
      return Left(ex.message ?? 'خطای نامشخص');
    }
  }
}
