class CategoryHome {
  int? id;
  String? nameEn;
  String? nameAr;
  String? image;
  String? imageUrl;

  CategoryHome({this.id, this.nameEn, this.nameAr, this.image, this.imageUrl});

  CategoryHome.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    image = json['image'];
    imageUrl = json['image_url'];
  }
  }