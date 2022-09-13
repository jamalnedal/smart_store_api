import 'package:smartsstors/model/cities.dart';

class ApiBaseResponse {
  late bool status;
 late String message;
 late List<City> list;



  ApiBaseResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['list'] != null) {
      list = <City>[];
      json['list'].forEach((v) {
        list.add(City.fromJson(v));
      });
    }
  }}