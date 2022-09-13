class famous_products {
  int? id;
  String? nameEn;
  String? nameAr;
  String? infoEn;
  String? infoAr;
  int? price;
  int? quantity;
  int? overalRate;
  int? subCategoryId;
  int? productRate;
  int? offerPrice;
  bool? isFavorite;
  String? imageUrl;


  famous_products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    infoEn = json['info_en'];
    infoAr = json['info_ar'];
    price = json['price'];
    quantity = json['quantity'];
    overalRate = json['overal_rate'];
    subCategoryId = json['sub_category_id'];
    productRate = json['product_rate'];
    offerPrice = json['offer_price'];
    isFavorite = json['is_favorite'];
    imageUrl = json['image_url'];
  }

}