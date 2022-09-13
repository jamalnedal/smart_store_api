import 'data_home.dart';

class MainHome {
  late bool status;
  late String message;
  late DataHome data;

  MainHome.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = DataHome.fromJson(json['data']);
    }
  }
}
