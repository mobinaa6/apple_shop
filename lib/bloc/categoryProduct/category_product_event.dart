abstract class CategoryProductEvent {}

class CategoryProductInitialize extends CategoryProductEvent {
  String CategoryId;
  CategoryProductInitialize(this.CategoryId);
}
