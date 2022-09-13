import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:smartsstors/basic_screen/sheet_code_activation.dart';
import 'package:smartsstors/model/category.dart';
import 'package:smartsstors/model/categoryhome.dart';
import 'package:smartsstors/model/famous_products_home.dart';
import 'package:smartsstors/model/offer.dart';
import 'package:smartsstors/view_screen_smart_store/product_Description.dart';
import 'package:smartsstors/widget/AppTextFieldSearch.dart';
import 'package:smartsstors/widget/app_text_field%20Name.dart';

import '../api_controller/auth_api_controller.dart';

class ProductDescriptionsScreenOffer extends StatefulWidget {
  ProductDescriptionsScreenOffer({
    Key? key,
    required this.id,
    required this.image,
  }) : super(key: key);
  final int id;
  final String image;

  @override
  _ProductDescriptionsScreenState createState() =>
      _ProductDescriptionsScreenState();
}

class _ProductDescriptionsScreenState
    extends State<ProductDescriptionsScreenOffer> with sheetCodeActivation {
  late bool connectedInternet;
  List<Offers> offers = <Offers>[];
  List<Offers> objectProductOffer = <Offers>[];
  List<int> offerList = <int>[];
  late Future<List<Offers>> _futureOffers;

  void initState() {
    //   // TODO: implement initState
    super.initState();
    _futureOffers = AuthApiController().getOffers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: const Color(0xFFF4E55AF),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () => Navigator.pop(context),
            )),
        backgroundColor: const Color(0XFFFEEF6F6),
        body: FutureBuilder<List<Offers>>(
            future: _futureOffers,
            builder: (context, snapshot) {
              offers = snapshot.data ?? [];
              offers.forEach((element) {
                if (element.productId == widget.id) {
                  objectProductOffer.add(element);
                  offerList.add(offers.length);
                }
              });
              if (snapshot.connectionState == ConnectionState.waiting) {
                return buildShimmerOffer();
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView(children: [
                  Stack(children: [
                    Container(
                      color: const Color(0xFFF4E55AF),
                      height: 330,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 60, horizontal: 20),
                      child: SimpleShadow(
                        opacity: 0.6,
                        // Default: 0.5
                        color: Colors.blue,
                        // Default: Black
                        offset: const Offset(30, 30),
                        // Default: Offset(2, 2)
                        sigma: 7,
                        child: Align(
                            alignment: Alignment.topCenter,
                            child: Image.network(
                              widget.image.toString(),
                              height: 150,
                            )),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 300),
                        child: Material(
                            borderRadius: BorderRadius.circular(15),
                            elevation: 20.0,
                            shadowColor: const Color(0xFFF4E55AF),
                            child: Container(
                              height: 100,
                              decoration: const BoxDecoration(
                                color: Color(0XFFF5E6297),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15)),
                              ),
                            ))),
                    Padding(
                        padding: const EdgeInsets.only(top: 350, left: 15),
                        child: Material(
                            borderRadius: BorderRadius.circular(15),
                            elevation: 20.0,
                            shadowColor: const Color(0xFFF4E55AF),
                            child: Container(
                              height: 40,
                              width: 90,
                              decoration: BoxDecoration(
                                color: const Color(0XFFFFCBF02),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(objectProductOffer[0]
                                          .discountRatio
                                          .toString() +
                                      '%' +
                                      'off')),
                            ))),
                    Padding(
                      padding: const EdgeInsets.only(top: 340, left: 280),
                      child: Text(
                        objectProductOffer[0].expired!
                            ? 'expired'
                            : 'available',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 320, left: 20),
                      child: Text(
                        objectProductOffer[0].nameEn.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 350, left: 120),
                      child: Text(
                        objectProductOffer[0].discountPrice.toString(),
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF97D4A4)),
                      ),
                    ),
                    Container(
                        width: 60,
                        margin: const EdgeInsets.only(top: 370, left: 140),
                        child: const Divider(
                          color: Colors.red,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 370, left: 150),
                      child: Text(
                        objectProductOffer[0].originalPrice.toString(),
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFC1CCD8)),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 420),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade100,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(50),
                                bottomLeft: Radius.circular(10)),
                          ),
                          height: 230,
                          child: ListView(children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Product info',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                            Stack(children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 50, left: 20),
                                  child: Text(
                                    'start_date : ' +
                                        objectProductOffer[0]
                                            .startDate
                                            .toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 90, left: 20),
                                  child: Text(
                                    'end_date : ' +
                                        objectProductOffer[0]
                                            .endDate
                                            .toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                              const Padding(
                                  padding: EdgeInsets.only(top: 130, left: 20),
                                  child: Text(
                                    'Product Description :',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 160, left: 20),
                                  child: Text(
                                    objectProductOffer[0].infoEn.toString() +
                                        '\n',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ))
                            ]),
                          ]),
                        )),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 660, left: 110, right: 10),
                      child: Container(
                        width: 200,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Color(0xFF4E55AF),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                        ),
                        child: TextButton(
                            child: const Text('go to the product'),
                            //       child: const Text('LOGIN'),
                            //       style: ElevatedButton.styleFrom(
                            //         minimumSize: const Size(500,56),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDescriptionsScreen(
                                            id: objectProductOffer[0]
                                                .productId!,
                                            expired:
                                                objectProductOffer[0].expired!,
                                          )));
                            }),
                      ),
                    ),
                  ]),
                ]);
              } else {
                return buildShimmerOffer();
              }
            }));
  }

  Shimmer buildShimmerOffer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Stack(children: [
        Container(
          height: 350,
          color: Colors.grey,
        ),
        Padding(
            padding: const EdgeInsets.only(top: 360),
            child: Container(
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
              ),
            )),
        Container(
            child: Padding(
                padding: const EdgeInsets.only(top: 480),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade100,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(50),
                        bottomLeft: Radius.circular(10)),
                  ),
                  height: 230,
                ))),
      ]),
    );
  }
}
