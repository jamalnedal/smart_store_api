import 'package:smartsstors/model/product_one_search.dart';

class Productdescription {
  bool? status;
  String? message;
  Objectproductone? object;

  Productdescription({this.status, this.message, this.object});

  Productdescription.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    object =
    json['object'] != null ? new Objectproductone.fromJson(json['object']) : null;
  }
}