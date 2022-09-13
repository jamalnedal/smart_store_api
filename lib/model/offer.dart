class Offers {
  int? id;
  String? nameEn;
  String? nameAr;
  String? infoEn;
  String? infoAr;
  String? image;
  int? discountRatio;
  int? originalPrice;
  int? discountPrice;
  int? productId;
  String? startDate;
  String? endDate;
  bool? expired;
  String? imageUrl;
  bool? iconprees=false;

  Offers(
      {this.id,
        this.nameEn,
        this.nameAr,
        this.infoEn,
        this.infoAr,
        this.image,
        this.discountRatio,
        this.originalPrice,
        this.discountPrice,
        this.productId,
        this.startDate,
        this.endDate,
        this.expired,
        this.imageUrl});

  Offers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    infoEn = json['info_en'];
    infoAr = json['info_ar'];
    image = json['image'];
    discountRatio = json['discount_ratio'];
    originalPrice = json['original_price'];
    discountPrice = json['discount_price'];
    productId = json['product_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    expired = json['expired'];
    imageUrl = json['image_url'];
  }}