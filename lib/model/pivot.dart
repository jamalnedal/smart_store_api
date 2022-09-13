class Pivot {
  int? userId;
  int? productId;

  Pivot({this.userId, this.productId});

  Pivot.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    productId = json['product_id'];
  }}