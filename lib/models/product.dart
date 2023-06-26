class Product {
  late final String? title;
  late final String? description;
  late final String? price;
  late final String? discountPrice;
  late final String? discountRate;
  late final String? imageUrl;
  late final String? shopOwnerName;
  late final String? shopUrl;
  late final String? shopName;
  late final String? productCommentCount;
  late final String? shopCommentCount;
  late final List<String?> reviews;

  Product(
      this.title,
      this.description,
      this.price,
      this.discountPrice,
      this.discountRate,
      this.imageUrl,
      this.shopOwnerName,
      this.shopUrl,
      this.shopName,
      this.shopCommentCount,
      this.productCommentCount,
      this.reviews);
}
