import 'fvoraite_product.dart';

class Favorite {
  bool? status;
  String? message;
  List<FvoraiteProduct>? favoraiteproduct;

  Favorite({this.status, this.message, this.favoraiteproduct});

  Favorite.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['list'] != null) {
      favoraiteproduct = <FvoraiteProduct>[];
      json['list'].forEach((v) {
        favoraiteproduct!.add(new FvoraiteProduct.fromJson(v));
      });
    }
  }}

