import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_shop/data/datasource/comment_datasource.dart';
import 'package:flutter_ecommerce_shop/data/model/comment.dart';
import 'package:flutter_ecommerce_shop/di/di.dart';
import 'package:flutter_ecommerce_shop/util/api_exception.dart';

abstract class ICommentRepository {
  Future<Either<String, List<Comment>>> getCommetns(
    String productId,
  );
  Future<Either<String, String>> postComment(String productId, String comment);
}

class CommentRepostory extends ICommentRepository {
  final ICommentDataSource _dataSource = locator.get();
  @override
  Future<Either<String, List<Comment>>> getCommetns(String productId) async {
    try {
      List<Comment> response = [];
      response.addAll(await _dataSource.getComments(productId));
      return Right(response);
    } on ApiException catch (ex) {
      return Left(ex.message!);
    }
  }

  @override
  Future<Either<String, String>> postComment(
      String productId, String comment) async {
    try {
      await _dataSource.postComment(productId, comment);
      return const Right('نظر شما اضافه شد');
    } on ApiException catch (ex) {
      return Left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
