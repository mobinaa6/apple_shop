import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_shop/data/model/comment.dart';

abstract class CommentState {}

class CommentLoadingState extends CommentState {}

class CommentRequestSuccessState extends CommentState {
  Either<String, List<Comment>> commentList;

  CommentRequestSuccessState(this.commentList);
}

class CommentPostResponseState extends CommentState {
  Either<String, String> response;
  CommentPostResponseState(this.response);
}
