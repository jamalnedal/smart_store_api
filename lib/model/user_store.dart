class UserStore {
  late int id;
  late String name;
  late Null? email;
  late String mobile;
  late String gender;
  late bool? active;
  late bool? verified;
  late String cityId;
  late String storeId;
  late String? fcmToken;
  late String token;
  late String? tokenType;
  late String? refreshToken;
  late String actives;
  late String password;
  String STORE_API_KEY='97aaf5f6-642b-4c32-be90-947b288bb662';

  UserStore();

  UserStore.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    gender = json['gender'];
    active = json['active'];
    verified = json['verified'];
    cityId = json['city_id'];
    storeId = json['store_id'];
    fcmToken = json['fcm_token'];
    token = json['token'];
    tokenType = json['token_type'];
    refreshToken = json['refresh_token'];
  }
}
