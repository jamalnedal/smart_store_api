import 'package:smartsstors/model/category.dart';
import 'package:smartsstors/model/cities.dart';

class ApiResponseCategory {
  late bool status;
  late String message;
  late List<Category> list;



  ApiResponseCategory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['list'] != null) {
      list = <Category>[];
      json['list'].forEach((v) {
        list.add(Category.fromJson(v));
      });
    }
  }}