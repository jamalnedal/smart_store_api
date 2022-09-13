import 'package:smartsstors/model/famous_products_home.dart';
import 'package:smartsstors/model/slider_image.dart';
import 'categoryhome.dart';
import 'latest_prouduct_home.dart';

class DataHome {
  late List<SliderHome> slider;
  late List<CategoryHome> Categorie;
  late List<LatestProducts> latestprouduct;
  late List<famous_products> famousproduct;
  DataHome.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      Categorie = <CategoryHome>[];
      json['categories'].forEach((v) {
        Categorie.add(CategoryHome.fromJson(v));
      });
    }
    if (json['slider'] != null) {
      slider = <SliderHome>[];
      json['slider'].forEach((v) {
        slider.add(SliderHome.fromJson(v));
      });
    }

    if (json['famous_products'] != null) {
    famousproduct = <famous_products>[];
    json['famous_products'].forEach((v) {
      famousproduct.add(famous_products.fromJson(v));
    });
    }
    if (json['latest_products'] != null) {
    latestprouduct = <LatestProducts>[];
    json['latest_products'].forEach((v) {
      latestprouduct.add(LatestProducts.fromJson(v));
    });
    }
  }
}
