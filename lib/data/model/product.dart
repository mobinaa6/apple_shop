class Product {
  String id;
  String collectionId;
  String thumbnail;
  String description;
  int discount_price;
  int price;
  String popularity;
  String name;
  int quantity;
  String categoryId;
  int? realprice;
  num? persent;

  Product(
    this.id,
    this.collectionId,
    this.thumbnail,
    this.description,
    this.discount_price,
    this.price,
    this.popularity,
    this.name,
    this.quantity,
    this.categoryId,
  ) {
    realprice = price + discount_price;
    persent = ((price - realprice!) / price) * 100;
  }
  factory Product.fromJson(Map<String, dynamic> JsonObject) {
    return Product(
        JsonObject['id'],
        JsonObject['collectionId'],
        'http://startflutter.ir/api/files/${JsonObject['collectionId']}/${JsonObject['id']}/${JsonObject['thumbnail']}',
        JsonObject['description'],
        JsonObject['discount_price'],
        JsonObject['price'],
        JsonObject['popularity'],
        JsonObject['name'],
        JsonObject['quantity'],
        JsonObject['category']);
  }
}
