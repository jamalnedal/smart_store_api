import 'offer.dart';

class ProductOffer {
  bool? status;
  String? message;
  List<Offers>? offers;

  ProductOffer({this.status, this.message, this.offers});

  ProductOffer.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['list'] != null) {
      offers = <Offers>[];
      json['list'].forEach((v) {
        offers!.add(new Offers.fromJson(v));
      });
    }
  }}