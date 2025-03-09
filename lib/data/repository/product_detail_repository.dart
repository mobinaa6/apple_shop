import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_shop/data/datasource/product_detail_datasource.dart';
import 'package:flutter_ecommerce_shop/data/model/category.dart';
import 'package:flutter_ecommerce_shop/data/model/comment.dart';
import 'package:flutter_ecommerce_shop/data/model/product_image.dart';
import 'package:flutter_ecommerce_shop/data/model/product_properties.dart';
import 'package:flutter_ecommerce_shop/data/model/product_variant.dart';
import 'package:flutter_ecommerce_shop/data/model/variant_type.dart';
import 'package:flutter_ecommerce_shop/di/di.dart';
import 'package:flutter_ecommerce_shop/util/api_exception.dart';

abstract class IDetailProductRepository {
  Future<Either<String, List<ProductImage>>> getGallery(String ProductId);
  Future<Either<String, List<VariantType>>> getVariantTypes();
  Future<Either<String, List<Productvariant>>> getProductVariants(
      String ProductId);
  Future<Either<String, Category>> getProductCategory(String CategoryId);
  Future<Either<String, List<Property>>> getProductProperties(String ProductId);
  Future<Either<String, List<Comment>>> getComments(String productId);
}

class DetailProductRepository extends IDetailProductRepository {
  IDetaiProductlDataSource _datasource = locator.get();
  @override
  Future<Either<String, List<ProductImage>>> getGallery(
      String ProductId) async {
    try {
      var response = await _datasource.getGallery(ProductId);
      return Right(response);
    } on ApiException catch (ex) {
      return Left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<VariantType>>> getVariantTypes() async {
    try {
      var response = await _datasource.getVariantTypes();
      return Right(response);
    } on ApiException catch (ex) {
      return Left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<Productvariant>>> getProductVariants(
      String ProductId) async {
    try {
      var response = await _datasource.getProductVariants(ProductId);
      return Right(response);
    } on ApiException catch (ex) {
      return Left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, Category>> getProductCategory(String CategoryId) async {
    try {
      var response = await _datasource.getProductCategory(CategoryId);
      return Right(response);
    } on ApiException catch (ex) {
      return Left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<Property>>> getProductProperties(
      String ProductId) async {
    try {
      var response = await _datasource.getProductProperties(ProductId);
      return Right(response);
    } on ApiException catch (ex) {
      return Left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<Comment>>> getComments(String productId) async {
    try {
      final response = await _datasource.getComments(productId);
      return Right(response);
    } on ApiException catch (ex) {
      return Left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
