class City {
  late int id;
  late String nameEn;
 late String nameAr;

  City({required this.id, required this.nameEn, required this.nameAr});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
  }
}