import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:smartsstors/basic_screen/helpers.dart';
import 'package:smartsstors/controller_Db/Information_cart_provider.dart';
import 'package:smartsstors/controller_Db/information_cart.dart';
import 'package:smartsstors/model/famous_products_home.dart';
import 'package:smartsstors/model/offer.dart';
import 'package:smartsstors/pref/shared_pref_controller.dart';

import '../api_controller/auth_api_controller.dart';
import '../model/product_one_search.dart';

class ProductDescriptionsScreen extends StatefulWidget {
  ProductDescriptionsScreen({
    Key? key,
    required this.id,
    required this.expired,
  }) : super(key: key);
  final int id;
  final bool expired;

  @override
  _ProductDescriptionsScreenState createState() =>
      _ProductDescriptionsScreenState();
}

class _ProductDescriptionsScreenState extends State<ProductDescriptionsScreen> with Helpers {
  int? idProduct;
  int? priceProduct;
  String? nameProduct;
  String? imageProduct;
  late bool connectedInternet;
  int addCart = 0;
  bool checkAdd = false;
  int idProductDelete = 0;
  List<Objectproductone> objectProductDes = <Objectproductone>[];
  late Future<Objectproductone?> _futureProduct;
  //late List<int> idProduct = <int>[];
  List<famous_products> famous = <famous_products>[];
  int _courntPageIndex = 0;
  late String id;
  late int quantityToUser = 1;
  late Offers off;
  double rate = 3;
  int prise = 0;
  double disCountProduct = 0;
  late bool onPress = false;
  List<int> length = <int>[];
  bool _show = false;
  Objectproductone objectproduct=Objectproductone();

  void initState() {
    //   // TODO: implement initState
    super.initState();
    Provider.of<InformationCartProvider>(context, listen: false).read();
    _futureProduct = AuthApiController().getProductOne(id: widget.id);
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
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        backgroundColor: const Color(0XFFFEEF6F6),
        body: FutureBuilder<Objectproductone?>(
            future: _futureProduct,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return buildShimmerProductDec();
              } else if (snapshot.hasData) {
                objectProductDes.add(snapshot.data!);
                objectproduct=objectProductDes[0];
                if (objectProductDes[0].overalRate! > 0) {
                  rate = objectProductDes[0].overalRate!.toDouble();
                } else {
                  rate = 1;
                }
                if (widget.expired == false) {
                  disCountProduct = 100 -
                      (objectProductDes[0].offerPrice!*100 /objectProductDes[0].price!);
                  prise = objectProductDes[0].offerPrice!;
                } else {
                  disCountProduct = 0;
                  prise = objectProductDes[0].price!;
                }
                return ListView(children: [
                  Stack(children: [
                    Container(
                      color: const Color(0xFFF4E55AF),
                      height: 300,
                    ),
                    CarouselSlider.builder(
                        itemCount: 3,
                        options: CarouselOptions(
                          onPageChanged: (index, value) {
                            setState(() {
                              _courntPageIndex = index;
                            });
                          },
                          //enlargeCenterPage: true,
                          height: 500,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          reverse: false,
                          aspectRatio: 5.0,
                          viewportFraction: 1.0,
                          //       aspectRatio: 2,
                        ),
                        itemBuilder: (context, i, id) {
                          return GestureDetector(
                            child: Padding(
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
                                  child: Image.network(
                                    objectProductDes[0]
                                        .images![i]
                                        .imageUrl
                                        .toString(),
                                    height: 150,
                                  )),
                            ),
                          );
                        }),
                    Container(
                      margin: const EdgeInsets.only(top: 270, left: 180),
                      height: 8,
                      child: GridView.builder(
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 3,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _courntPageIndex == index
                                  ? Colors.blue
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          );
                        },
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
                                  child: Text(disCountProduct.toString() +
                                      '%' +
                                      'off')),
                            ))),
                    Padding(
                      padding: const EdgeInsets.only(top: 320, left: 20),
                      child: Text(
                        objectProductDes[0].nameEn.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 360, left: 120),
                      child: Text(
                        prise.toString(),
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF97D4A4)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 360, left: 220),
                      child: RatingBar.builder(
                        initialRating: rate,
                        minRating: rate,
                        maxRating: rate,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        ignoreGestures: true,
                        updateOnDrag: true,
                        itemCount: 5,
                        itemSize: 20,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          rating = rate;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 310, left: 325),
                      child: IconButton(
                        iconSize: 30,
                        onPressed: () async {
                          await AuthApiController().favoraite(context,
                              product_id: objectProductDes[0].id);
                          setState(() => objectProductDes[0].isFavorite =
                              !objectProductDes[0].isFavorite!);
                        },
                        icon: objectProductDes[0].isFavorite!
                            ? const Icon(Icons.favorite, color: Colors.red)
                            : const Icon(Icons.favorite_border, color: Colors.black),
                      ),
                    ),
                    Container(
                        child: Padding(
                            padding: const EdgeInsets.only(top: 430),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.shade100,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(50),
                                    bottomLeft: Radius.circular(10)),
                              ),
                              height: 200,
                              child: ListView(children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Quantity',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                                Stack(children: [
                                  Padding(
                                      padding:
                                          const EdgeInsets.only(left: 280, top: 20),
                                      child: FloatingActionButton(
                                          heroTag: 'remove',
                                          onPressed: () {
                                            setState(() {
                                              quantityToUser++;
                                            });
                                          },
                                          child: const Text(
                                            '+',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          backgroundColor: const Color(0xFFF4E55AF))),
                                  Padding(
                                      padding:
                                          const EdgeInsets.only(top: 20, left: 70),
                                      child: FloatingActionButton(
                                        heroTag: 'add',
                                        onPressed: () {
                                          setState(() {
                                            if (quantityToUser > 1) {
                                              quantityToUser--;
                                            }
                                          });
                                        },
                                        child: const Text(
                                          '-',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        backgroundColor: const Color(0xFFF4E55AF),
                                      )),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 40, left: 200),
                                    child: Text(
                                      quantityToUser.toString(),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const Padding(
                                      padding:
                                          EdgeInsets.only(top: 100, left: 20),
                                      child: Text(
                                        'Product Description :',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 130, left: 20, right: 10),
                                      child: Text(
                                        objectProductDes[0].infoEn.toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ))
                                ]),
                              ]),
                            ))),
                    Consumer<InformationCartProvider>(builder:
                        (BuildContext context, InformationCartProvider value, child) {
                        for (int i = 0; i < value.contact.length; i++) {
                          if (objectProductDes[0].id ==
                              value.contact[i].idProduct&&SharedPrefController().id==value.contact[i].idUser) {
                            checkAdd = true;
                            idProductDelete = value.contact[i].id;
                          }
                        }
                        return Stack(children: [
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 650, left: 200, right: 10),
                              child: Container(
                                  width: 200,
                                  height: 50,
                                  decoration:  BoxDecoration(
                                    color: checkAdd? Colors.red: const Color(0xFF4E55AF),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15)),
                                  ),
                                  child: TextButton(
                                      //       child: const Text('LOGIN'),
                                      //       style: ElevatedButton.styleFrom(
                                      //         minimumSize: const Size(500,56),
                                      onPressed: () async {
                                        if (checkAdd == false) {
                                          await saveToCart();
                                        } else {
                                          await delete(idProductDelete);
                                        }
                                        setState(() {
                                          checkAdd = !checkAdd;
                                        });
                                      },
                                      child: Text(checkAdd
                                          ? 'remove cart'
                                          : 'Add to cart'
                                      ,style: const TextStyle(color: Colors.white),)
                                  ))),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 650),
                            child: IconButton(
                                icon: Icon(
                                  Icons.shopping_cart,
                                  color: checkAdd ? Colors.green : Colors.red,
                                  size: 40,
                                ),
                                onPressed: () {}),
                          ),
                        ]);

                    }),
                  ])
                ]);
              } else {
                return buildShimmerProductDec();
              }
            }));
  }

  Shimmer buildShimmerProductDec() {
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

  Future<void> saveToCart() async {
    bool create = await Provider.of<InformationCartProvider>(context, listen: false)
        .create(c: cart);
    if (create) {
      showSnackBar(context: context, message: 'pass', error: false);
    } else {
      showSnackBar(context: context, message: 'no paas', error: false);
    }
  }

  Future<void> delete(int id) async {
    bool delet =
        await Provider.of<InformationCartProvider>(context, listen: false).delete(id);
    if (delet) {
      showSnackBar(context: context, message: 'pass delet', error: false);
    } else {
      showSnackBar(context: context, message: 'no paas delete', error: false);
    }
  }

  InformationCart get cart {
    InformationCart informcart = InformationCart();
    informcart.name = objectproduct.nameEn.toString();
    informcart.price = objectproduct.price!;
    informcart.count = quantityToUser;
    informcart.image = objectproduct.imageUrl.toString();
    informcart.idProduct = objectproduct.id!;
    informcart.quantity = objectproduct.quantity!;
    informcart.infoEn = objectproduct.infoEn!;
    informcart.infoAr = objectproduct.infoAr!;
    informcart.overalRate = objectproduct.overalRate!;
    informcart.productRate = objectproduct.productRate!;
    informcart.offerPrice = objectproduct.offerPrice==null?0:objectproduct.offerPrice!;
    informcart.subCategoryId = objectproduct.subCategoryId!;
    informcart.nameAr = objectproduct.nameAr!;
    informcart.isFavorite = objectproduct.isFavorite!?1:0;
    informcart.idUser =SharedPrefController().id;
    return informcart;
  }
}
