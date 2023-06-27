class Product {
  String? id;
  String? title;
  String? description;
  String? price;
  String? discountPrice;
  String? discountRate;
  String? imageUrl;
  String? shopOwnerName;
  String? shopUrl;
  String? shopName;
  String? productCommentCount;
  String? shopCommentCount;
  List<String?> reviews;

  Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.discountPrice,
    this.discountRate,
    this.imageUrl,
    this.shopOwnerName,
    this.shopUrl,
    this.shopName,
    this.productCommentCount,
    this.shopCommentCount,
    this.reviews = const [],
  });
}
