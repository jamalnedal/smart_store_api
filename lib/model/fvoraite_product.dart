import 'package:smartsstors/model/pivot.dart';

class FvoraiteProduct {
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
  Pivot? pivot;

  FvoraiteProduct(
      {this.id,
        this.nameEn,
        this.nameAr,
        this.infoEn,
        this.infoAr,
        this.price,
        this.quantity,
        this.overalRate,
        this.subCategoryId,
        this.productRate,
        this.offerPrice,
        this.isFavorite,
        this.imageUrl,
        this.pivot});

  FvoraiteProduct.fromJson(Map<String, dynamic> json) {
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
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }
}