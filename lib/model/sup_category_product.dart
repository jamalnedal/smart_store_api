
import 'list_sub_category.dart';

class Supcategoryproduct {
  late bool? status;
 late String? message;
 late List<ListSubcategory> listproduct;


  Supcategoryproduct.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['list'] != null) {
      listproduct = <ListSubcategory>[];
      json['list'].forEach((v) {
        listproduct.add(ListSubcategory.fromJson(v));
      });
    }
  }}