import 'package:dio/dio.dart';
import 'package:flutter_ecommerce_shop/data/model/category.dart';
import 'package:flutter_ecommerce_shop/data/model/comment.dart';
import 'package:flutter_ecommerce_shop/data/model/product_image.dart';
import 'package:flutter_ecommerce_shop/data/model/product_properties.dart';
import 'package:flutter_ecommerce_shop/data/model/product_variant.dart';
import 'package:flutter_ecommerce_shop/data/model/variant.dart';
import 'package:flutter_ecommerce_shop/data/model/variant_type.dart';
import 'package:flutter_ecommerce_shop/di/di.dart';
import 'package:flutter_ecommerce_shop/util/api_exception.dart';

abstract class IDetaiProductlDataSource {
  Future<List<ProductImage>> getGallery(String ProductId);
  Future<List<VariantType>> getVariantTypes();
  Future<List<Variant>> getVariants(String ProductId);
  Future<List<Productvariant>> getProductVariants(String ProductId);
  Future<Category> getProductCategory(String CategoryId);
  Future<List<Property>> getProductProperties(String ProductId);
  Future<List<Comment>> getComments(String productId);
}

class DetailProductRemotDataSource extends IDetaiProductlDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<ProductImage>> getGallery(String ProductId) async {
    try {
      Map<String, String> qparams = {'filter': 'product_id="$ProductId"'};
      var response = await _dio.get('collections/gallery/records',
          queryParameters: qparams);
      return response.data['items']
          .map<ProductImage>((jsonObject) => ProductImage.FromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['Message']);
    } catch (ex) {
      throw ApiException(0, 'onknow error');
    }
  }

  @override
  Future<List<VariantType>> getVariantTypes() async {
    try {
      var response = await _dio.get('collections/variants_type/records');
      return response.data['items']
          .map<VariantType>((jsonObject) => VariantType.fromjson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['Message']);
    } catch (ex) {
      throw ApiException(0, 'onknow error');
    }
  }

  @override
  Future<List<Variant>> getVariants(String ProductId) async {
    try {
      Map<String, String> qparams = {'filter': 'product_id="$ProductId"'};
      var response = await _dio.get('collections/variants/records',
          queryParameters: qparams);
      return response.data['items']
          .map<Variant>((jsonObject) => Variant.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['Message']);
    } catch (ex) {
      throw ApiException(0, 'onknow error');
    }
  }

  @override
  Future<List<Productvariant>> getProductVariants(String ProductId) async {
    var variantTypeList = await getVariantTypes();
    var VariantList = await getVariants(ProductId);

    List<Productvariant> ProductvariantList = [];
    try {
      for (var variantType in variantTypeList) {
        var variantList =
            VariantList.where((Variant) => Variant.typeId == variantType.id)
                .toList();
        ProductvariantList.add(Productvariant(variantType, variantList));
      }
      return ProductvariantList;
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'onknow error');
    }
  }

  @override
  Future<Category> getProductCategory(String CategoryId) async {
    try {
      Map<String, String> qParams = {'filter': 'id="$CategoryId"'};
      var response = await _dio.get('collections/Category/records',
          queryParameters: qParams);
      return Category.fromMapjson(response.data['items'][0]);
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'onknow error');
    }
  }

  @override
  Future<List<Property>> getProductProperties(String ProductId) async {
    try {
      Map<String, String> qParams = {'filter': 'product_id="$ProductId"'};
      var response = await _dio.get('collections/properties/records',
          queryParameters: qParams);
      return response.data['items']
          .map<Property>((jsonObject) => Property.fromjson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'onknow error');
    }
  }

  @override
  Future<List<Comment>> getComments(String productId) async {
    try {
      Map<String, String> qParams = {
        'filter': 'product_id="$productId"',
        'expand': 'user_id'
      };
      var response = await _dio.get('collections/comment/records',
          queryParameters: qParams);
      return response.data['items']
          .map<Comment>((jsonObject) => Comment.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw ApiException(0, "unknown error");
    }
  }
}
