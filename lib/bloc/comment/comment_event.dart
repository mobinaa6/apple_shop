abstract class CommentEvent {}

class CommentInitializeEvent extends CommentEvent {
  String productID;

  CommentInitializeEvent(this.productID);
}

class CommentPostEvent extends CommentEvent {
  String productId;
  String comment;
  CommentPostEvent(this.productId, this.comment);
}
