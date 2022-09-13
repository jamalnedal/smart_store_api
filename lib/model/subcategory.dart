class SubCategory {
  int? id;
  String? nameEn;
  String? nameAr;
  int? categoryId;
  String? image;
  String? imageUrl;


  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    categoryId = json['category_id'];
    image = json['image'];
    imageUrl = json['image_url'];
  }}