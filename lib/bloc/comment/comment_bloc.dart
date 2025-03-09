import 'package:bloc/bloc.dart';
import 'package:flutter_ecommerce_shop/bloc/comment/comment_event.dart';
import 'package:flutter_ecommerce_shop/bloc/comment/comment_state.dart';
import 'package:flutter_ecommerce_shop/data/repository/comment_repository.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final ICommentRepository _repository;

  CommentBloc(this._repository) : super(CommentLoadingState()) {
    on<CommentInitializeEvent>((event, emit) async {
      var commentList = await _repository.getCommetns(event.productID);
      emit(CommentRequestSuccessState(commentList));
    });

    on<CommentPostEvent>((event, emit) async {
      emit(CommentLoadingState());
      await _repository.postComment(event.productId, event.comment);
      var reponse = await _repository.getCommetns(event.productId);
      emit(CommentRequestSuccessState(reponse));
    });
  }
}
