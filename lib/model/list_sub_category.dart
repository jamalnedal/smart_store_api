class ListSubcategory {
  int? id;
  String? nameEn;
  String? nameAr;
  int? categoryId;
  String? image;
  int? productsCount;
  String? imageUrl;

  ListSubcategory(
      {this.id,
        this.nameEn,
        this.nameAr,
        this.categoryId,
        this.image,
        this.productsCount,
        this.imageUrl});

  ListSubcategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    categoryId = json['category_id'];
    image = json['image'];
    productsCount = json['products_count'];
    imageUrl = json['image_url'];
  }
}