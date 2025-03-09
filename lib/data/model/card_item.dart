import 'package:hive/hive.dart';
part 'card_item.g.dart';

@HiveType(typeId: 1)
class BasketItem extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String collectionId;

  @HiveField(2)
  String thumbnail;

  @HiveField(3)
  int discount_price;

  @HiveField(4)
  int price;

  @HiveField(5)
  String name;

  @HiveField(6)
  String categoryId;

  @HiveField(7)
  int? realprice;

  @HiveField(8)
  num? persent;

  BasketItem(
    this.id,
    this.collectionId,
    this.thumbnail,
    this.discount_price,
    this.price,
    this.name,
    this.categoryId,
  ) {
    realprice = price + discount_price;
    persent = ((price - realprice!) / price) * 100;
    // this.thumbnail=        'http://startflutter.ir/api/files/${JsonObject['collectionId']}/${JsonObject['id']}/${JsonObject['thumbnail']}',
  }
}
