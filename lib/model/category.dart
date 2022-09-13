class Category {
 late int id;
 late String nameEn;
 late String nameAr;
 late String image;
 late int productsCount;
 late int subCategoriesCount;
 late String imageUrl;


  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    image = json['image'];
    productsCount = json['products_count'];
    subCategoriesCount = json['sub_categories_count'];
    imageUrl = json['image_url'];
  }}
