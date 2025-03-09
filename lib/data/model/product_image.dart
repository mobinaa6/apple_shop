class ProductImage {
  String? imageUrl;
  String? ProductId;
  ProductImage(this.imageUrl, this.ProductId);
  factory ProductImage.FromJson(Map<String, dynamic> jsonObject) {
    return ProductImage(
      'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['image']}',
      jsonObject['product_id'],
    );
  }
}
