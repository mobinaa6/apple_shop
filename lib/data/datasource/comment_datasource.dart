import 'package:dio/dio.dart';
import 'package:flutter_ecommerce_shop/di/di.dart';
import 'package:flutter_ecommerce_shop/util/api_exception.dart';
import 'package:flutter_ecommerce_shop/util/auth_manager.dart';

import '../model/comment.dart';

abstract class ICommentDataSource {
  Future<List<Comment>> getComments(String productId);
  Future<void> postComment(String productId, String comment);
}

class CommentRemotDataSource extends ICommentDataSource {
  final Dio _dio = locator.get();
  final String user_Id = AuthManager.getID();
  @override
  Future<List<Comment>> getComments(String productId) async {
    try {
      Map<String, dynamic> qParams = {
        'filter': 'product_id="$productId"',
        'expand': 'user_id',
        'perPage': 30
      };
      var response = await _dio.get('collections/comment/records',
          queryParameters: qParams);
      return response.data['items']
          .map<Comment>((jsonObject) => Comment.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw ApiException(0, "unknow error");
    }
  }

  @override
  Future<void> postComment(String productId, String comment) async {
    try {
      await _dio.post('collections/comment/records', data: {
        'text': comment,
        'user_id': user_Id,
        'product_id': productId,
      });
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw ApiException(0, "unknown error");
    }
  }
}
