import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartsstors/api_controller/auth_api_controller.dart';
import 'package:smartsstors/basic_screen/sheet_code_activation.dart';
import 'package:smartsstors/model/offer.dart';
import 'package:smartsstors/pref/shared_pref_controller.dart';
import 'package:smartsstors/view_screen_smart_store/product_description_offer.dart';
import 'package:smartsstors/widget/app_text_field Name.dart';
import '../model/data_home.dart';
import '../view_screen_smart_store/bn_smart_store_screen.dart';
import '../view_screen_smart_store/sub_category_screen.dart';

class MyHomeSmartStore extends StatefulWidget {
  final String password;
  final String phone;

  MyHomeSmartStore({Key? key, required this.password, required this.phone})
      : super(key: key);

  @override
  _MyHomeSmartStoreState createState() => _MyHomeSmartStoreState();
}

class _MyHomeSmartStoreState extends State<MyHomeSmartStore>
    with sheetCodeActivation {
  List<Offers> offers = <Offers>[];
  late Future<List<Offers>> _futureOffer;
  List<DataHome> mainHome = <DataHome>[];
  late Future<DataHome?> _futureHome;
  late bool connectInternet;
  double rate = 3;

  //bool _isFavorited=false;
  // @override
  void initState() {
    //   // TODO: implement initState
    super.initState();
    _futureHome = AuthApiController().getMainHome(context);
    // _future1 = AuthApiController().getSlider(context);
    // _future = AuthApiController().getCategorias();
    // _future2 = AuthApiController().getlatestprouduct();
    // _future3 = AuthApiController().getfamuosproduct();
    _futureOffer = AuthApiController().getOffers();
  }

  static final DateTime now = DateTime.now();
  String date = now.year.toString() +
      '-' +
      now.month.toString() +
      '-' +
      now.day.toString();
  int _courntpageindex = 0;

  @override
  Widget build(BuildContext context) {
    double landscape = MediaQuery.of(context).size.height;
    double portrait = MediaQuery.of(context).size.width;
    print(4.toString());
      return Scaffold(
          extendBodyBehindAppBar: false,
          body: ListView(shrinkWrap: true, children: [
            Stack(children: [
              Container(
                height: 250,
                color: const Color(0xFFF4E55AF),
              ),
              OfflineBuilder(
                connectivityBuilder: (BuildContext context,
                    ConnectivityResult connectivity, Widget child) {
                  connectInternet = connectivity != ConnectivityResult.none;
                  return Container(
                    width: 400,
                    height: 30,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 350),
                      color: connectInternet ? null : const Color(0xFFEE4400),
                      child: connectInternet
                          ? null
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Text(
                                  "OFFLINE",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                SizedBox(
                                  width: 12.0,
                                  height: 12.0,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  );
                },
                child: const Text(''),
              ),
              FutureBuilder<DataHome?>(
                future: _futureHome,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return buildShimmerHome();
                  } else if (snapshot.hasData) {
                    mainHome.add(snapshot.data!);
                    return Stack(children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 150, right: 40, left: 40),
                          child: Material(
                              borderRadius: BorderRadius.circular(15),
                              elevation: 20.0,
                              shadowColor: const Color(0xFFF4E55AF),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CarouselSlider.builder(
                                      itemCount: 5,
                                      options: CarouselOptions(
                                        onPageChanged: (index, value) {
                                          setState(() {
                                            _courntpageindex = index;
                                          });
                                        },
                                        //enlargeCenterPage: true,
                                        height: 200,
                                        autoPlay: true,
                                        autoPlayInterval:
                                            const Duration(seconds: 3),
                                        reverse: false,
                                        aspectRatio: 5.0,
                                        viewportFraction: 1.0,
                                        //       aspectRatio: 2,
                                      ),
                                      itemBuilder: (context, i, id) {
                                        return GestureDetector(
                                            //ClipRRect for image border radius
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color: Colors.black12,
                                                    image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: NetworkImage(
                                                          mainHome[0]
                                                              .slider[i]
                                                              .imageUrl),
                                                    )))
                                            // : Shimmer.fromColors(
                                            //     baseColor: Colors.grey[300]!,
                                            //     highlightColor: Colors.grey[100]!,
                                            //     child: Container(
                                            //       decoration: BoxDecoration(
                                            //         color: Colors.grey,
                                            //       ),
                                            //       width: 360,
                                            //       height: 200,
                                            //     ),
                                            //   ),
                                            );
                                      })))),
                      Container(
                          margin: const EdgeInsets.only(
                              top: 425, left: 40, right: 10),
                          height: 250,
                          child: GridView.builder(
                              itemCount: 4,
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 130,
                                      mainAxisSpacing: 20),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SubCategoryScreen(
                                                  id: mainHome[0]
                                                      .Categorie[index]
                                                      .id!,
                                                  image: mainHome[0]
                                                      .Categorie[index]
                                                      .imageUrl!,
                                                  categoryname: mainHome[0]
                                                      .Categorie[index]
                                                      .nameEn!,
                                                )));
                                  },
                                  child: Stack(children: [
                                    Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            color: const Color(0xFFF7F7F7),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                              color: const Color(0xFFF7F7F7),
                                            )),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Container(
                                                height: 60,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color: Colors.black12,
                                                    image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: NetworkImage(
                                                            mainHome[0]
                                                                .Categorie[
                                                                    index]
                                                                .imageUrl
                                                                .toString())))))
                                        // : Shimmer.fromColors(
                                        //     baseColor: Colors.grey[300]!,
                                        //     highlightColor: Colors.grey[100]!,
                                        //     child: ClipRRect(
                                        //         borderRadius:
                                        //             BorderRadius.circular(15),
                                        //         child: Container(
                                        //           height: 70,
                                        //           width: 70,
                                        //           color: Colors.grey,
                                        //         )),
                                        //   ),
                                        ),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            top: 70, left: 25),
                                        child: Text(mainHome[0]
                                            .Categorie[index]
                                            .nameEn
                                            .toString()))
                                    // : Shimmer.fromColors(
                                    //     baseColor: Colors.grey[300]!,
                                    //     highlightColor: Colors.grey[100]!,
                                    //     child: Padding(
                                    //         padding:
                                    //             EdgeInsets.only(top: 85, left: 10),
                                    //         child: Container(
                                    //           height: 10,
                                    //           width: 80,
                                    //           color: Colors.grey,
                                    //         ))),
                                  ]),
                                );
                              })),
                      Container(
                          width: 390,
                          margin: const EdgeInsets.only(top: 650),
                          child: const Divider(
                            color: Colors.grey,
                          )),
                      Container(
                          width: 390,
                          margin: const EdgeInsets.only(top: 1090),
                          child: const Divider(
                            color: Colors.grey,
                          )),
                      Container(
                          width: 390,
                          margin: const EdgeInsets.only(top: 1910),
                          child: const Divider(
                            color: Colors.grey,
                          )),
                      ////////////////////////////////////////////////////////////////

                      Container(
                        margin: const EdgeInsets.only(top: 705),
                        height: 400,
                        child: GridView.builder(
                            itemCount: 4,
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    mainAxisSpacing: 20,
                                    childAspectRatio: 4 / 2),
                            itemBuilder: (context, index) {
                              rate = mainHome[0]
                                  .latestprouduct[index]
                                  .overalRate!
                                  .toDouble();
                              // subctegoryid.add(latestprouduct[index]
                              //     .subCategoryId!);
                              return Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 60, left: 10, right: 10),
                                  child: Container(
                                    width: 100,
                                    height: 300,
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey.shade100,
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          topRight: Radius.circular(20)),
                                    ),
                                    child: Material(
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            topRight: Radius.circular(20)),
                                        elevation: 20.0,
                                        shadowColor: const Color(0xFFF4E55AF),
                                        child: Stack(children: [
                                          Container(
                                            height: 150,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(20),
                                                      bottomLeft:
                                                          const Radius.circular(
                                                              20)),
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                  mainHome[0]
                                                      .latestprouduct[index]
                                                      .imageUrl
                                                      .toString(),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 160, left: 140),
                                            child: IconButton(
                                              iconSize: 30,
                                              onPressed: () async {
                                                await AuthApiController()
                                                    .favoraite(
                                                        context,
                                                        product_id: mainHome[0]
                                                            .latestprouduct[
                                                                index]
                                                            .id);
                                                setState(() => mainHome[0]
                                                        .latestprouduct[index]
                                                        .isFavorite =
                                                    !mainHome[0]
                                                        .latestprouduct[index]
                                                        .isFavorite!);
                                              },
                                              icon: mainHome[0]
                                                      .latestprouduct[index]
                                                      .isFavorite!
                                                  ? const Icon(Icons.favorite,
                                                      color: Colors.red)
                                                  : const Icon(
                                                      Icons.favorite_border,
                                                      color: Colors.red),
                                            ),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 170, left: 20),
                                              child: Text(
                                                mainHome[0]
                                                    .latestprouduct[index]
                                                    .nameEn
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                          const Padding(
                                              padding: EdgeInsets.only(
                                                  top: 210, left: 20),
                                              child: Text(
                                                'Rate the product:',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 250, left: 20),
                                            child: RatingBar.builder(
                                              initialRating: rate,
                                              minRating: rate,
                                              maxRating: rate,
                                              ignoreGestures: true,
                                              updateOnDrag: true,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: 20,
                                              // glow: false,
                                              itemPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                              itemBuilder: (context, _) =>
                                                  const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating) {
                                                setState(() {
                                                  rating = rate;
                                                });
                                              },
                                            ),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 290, left: 20),
                                              child: Text(
                                                mainHome[0]
                                                        .latestprouduct[index]
                                                        .price
                                                        .toString() +
                                                    '₪',
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ])),
                                  ));
                              // : Shimmer.fromColors(
                              //     baseColor: Colors.grey[300]!,
                              //     highlightColor: Colors.grey[100]!,
                              //     child: Container(
                              //       height: 205,
                              //       width: 180,
                              //       decoration: BoxDecoration(
                              //         color: Colors.grey,
                              //         borderRadius:
                              //             BorderRadius.circular(24),
                              //       ),
                              //     ),
                              //   );

                              // conected
                              //     ? Stack(
                              //         children: [
                              //           Padding(
                              //               padding: EdgeInsets.only(
                              //                   top: 170, left: 6),
                              //               child: Align(
                              //                   alignment: Alignment.topLeft,
                              //                   child: Text(MainHome[0]
                              //                       .latestprouduct[index]
                              //                       .nameEn!))),
                              //           Padding(
                              //             padding:
                              //                 EdgeInsets.only(top: 170, right: 6),
                              //             child: Align(
                              //                 alignment: Alignment.topRight,
                              //                 child: Text(MainHome[0]
                              //                         .latestprouduct[index]
                              //                         .price
                              //                         .toString() +
                              //                     '₪')),
                              //           ),
                              //           Padding(
                              //               padding: EdgeInsets.only(
                              //                   top: 215, left: 6),
                              //               child: Align(
                              //                   alignment: Alignment.topLeft,
                              //                   child: Text('Quantity'))),
                              //           Padding(
                              //             padding:
                              //                 EdgeInsets.only(top: 215, right: 6),
                              //             child: Align(
                              //                 alignment: Alignment.topRight,
                              //                 child: Text(MainHome[0]
                              //                     .latestprouduct[index]
                              //                     .quantity
                              //                     .toString())),
                              //           ),
                              //           Padding(
                              //             padding:
                              //                 EdgeInsets.only(top: 240, left: 6),
                              //             child: Row(children: [
                              //               Text('add to cart'),
                              //               Padding(
                              //                 padding: EdgeInsets.only(left: 20),
                              //                 child: InkWell(
                              //                     onTap: () {
                              //                       if (index == 0) {}
                              //                     },
                              //                     child: IconButton(
                              //                         icon: Icon(
                              //                             Icons.shopping_cart),
                              //                         onPressed: () {})),
                              //               ),
                              //             ]),
                              //           ),
                              //         ],
                              //       )
                              //     : Shimmer.fromColors(
                              //         baseColor: Colors.grey[300]!,
                              //         highlightColor: Colors.grey[100]!,
                              //         child: Stack(children: [
                              //           Padding(
                              //             padding:
                              //                 EdgeInsets.only(top: 170, left: 10),
                              //             child: Container(
                              //               height: 20,
                              //               width: 180,
                              //               color: Colors.grey,
                              //             ),
                              //           ),
                              //           Padding(
                              //             padding:
                              //                 EdgeInsets.only(top: 200, left: 10),
                              //             child: Container(
                              //               height: 20,
                              //               width: 180,
                              //               color: Colors.grey,
                              //             ),
                              //           ),
                              //           Padding(
                              //             padding:
                              //                 EdgeInsets.only(top: 240, left: 10),
                              //             child: Container(
                              //               height: 20,
                              //               width: 180,
                              //               color: Colors.grey,
                              //             ),
                              //           ),
                              //         ]),
                              //       ),
                              //]),
                            }),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 1160),
                        height: 900,
                        child: InkWell(
                          child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 4,
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 20,
                                      childAspectRatio: 5 / 9),
                              itemBuilder: (context, index) {
                                rate = mainHome[0]
                                    .famousproduct[index]
                                    .overalRate!
                                    .toDouble();
                                // Color _iconColor = Colors.blue;
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Container(
                                    height: 600,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey.shade100,
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          topRight: Radius.circular(20)),
                                    ),
                                    child: Material(
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            topRight: Radius.circular(20)),
                                        elevation: 20.0,
                                        shadowColor: const Color(0xfff4e55af),
                                        child: Stack(children: [
                                          Container(
                                            height: 150,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(20),
                                                      bottomLeft:
                                                          Radius.circular(20)),
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                  mainHome[0]
                                                      .famousproduct[index]
                                                      .imageUrl
                                                      .toString(),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 160, left: 130),
                                            child: IconButton(
                                              iconSize: 30,
                                              onPressed: () async {
                                                await AuthApiController()
                                                    .favoraite(
                                                        context,
                                                        product_id: mainHome[0]
                                                            .famousproduct[
                                                                index]
                                                            .id);
                                                setState(() => mainHome[0]
                                                        .famousproduct[index]
                                                        .isFavorite =
                                                    !mainHome[0]
                                                        .famousproduct[index]
                                                        .isFavorite!);
                                              },
                                              icon: mainHome[0]
                                                      .famousproduct[index]
                                                      .isFavorite!
                                                  ? const Icon(Icons.favorite,
                                                      color: Colors.red)
                                                  : const Icon(
                                                      Icons.favorite_border,
                                                      color: Colors.red),
                                            ),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 170, left: 20),
                                              child: Text(
                                                mainHome[0]
                                                    .famousproduct[index]
                                                    .nameEn
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                          const Padding(
                                              padding: EdgeInsets.only(
                                                  top: 210, left: 20),
                                              child: Text(
                                                'Rate the product:',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 250, left: 20),
                                            child: RatingBar.builder(
                                              initialRating: rate,
                                              minRating: rate,
                                              maxRating: rate,
                                              ignoreGestures: true,
                                              updateOnDrag: true,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: 20,
                                              // glow: false,
                                              itemPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                              itemBuilder: (context, _) =>
                                                  const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating) {
                                                setState(() {
                                                  rating = rate;
                                                });
                                              },
                                            ),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 290, left: 20),
                                              child: Text(
                                                mainHome[0]
                                                        .famousproduct[index]
                                                        .price
                                                        .toString() +
                                                    '₪',
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ])),
                                  ),
                                );
                                // : Shimmer.fromColors(
                                //     baseColor: Colors.grey[300]!,
                                //     highlightColor: Colors.grey[100]!,
                                //     child: Container(
                                //       height: 700,
                                //       decoration: BoxDecoration(
                                //           color: Colors.white,
                                //           borderRadius:
                                //               BorderRadius.circular(24)),
                                //       child: ClipRRect(
                                //           borderRadius:
                                //               BorderRadius.circular(15),
                                //           child: Padding(
                                //             padding:
                                //                 EdgeInsets.only(bottom: 40),
                                //             child: Container(
                                //               color: Colors.grey,
                                //             ),
                                //           )),
                                //     ),);

                                // conected
                                //     ? Stack(
                                //         children: [
                                //           Padding(
                                //               padding: EdgeInsets.only(
                                //                   top: 170, left: 6),
                                //               child: Align(
                                //                   alignment: Alignment.topLeft,
                                //                   child: Text(MainHome[0].famousproduct[index]
                                //                       .nameEn!))),
                                //           Padding(
                                //             padding:
                                //                 EdgeInsets.only(top: 170, right: 6),
                                //             child: Align(
                                //                 alignment: Alignment.topRight,
                                //                 child: Text(MainHome[0].famousproduct[index]
                                //                         .price
                                //                         .toString() +
                                //                     '₪')),
                                //           ),
                                //           Padding(
                                //               padding: EdgeInsets.only(
                                //                   top: 215, left: 6),
                                //               child: Align(
                                //                   alignment: Alignment.topLeft,
                                //                   child: Text('Quantity'))),
                                //           Padding(
                                //             padding:
                                //                 EdgeInsets.only(top: 215, right: 6),
                                //             child: Align(
                                //                 alignment: Alignment.topRight,
                                //                 child: Text(MainHome[0].famousproduct[index]
                                //                     .quantity
                                //                     .toString())),
                                //           ),
                                //           Padding(
                                //             padding:
                                //                 EdgeInsets.only(top: 240, left: 6),
                                //             child: Row(children: [
                                //               Text('add to cart'),
                                //               Padding(
                                //                   padding:
                                //                       EdgeInsets.only(left: 20),
                                //                   child: IconButton(
                                //                       icon: Icon(
                                //                         Icons.shopping_cart,
                                //                         color: _iconColor,
                                //                       ),
                                //                       onPressed: () {
                                //                         setState(() {
                                //                           _iconColor = _iconColor ==
                                //                                   Colors.red
                                //                               ? Colors.yellow
                                //                               : Colors.red;
                                //                         });
                                //                       })),
                                //             ]),
                                //           ),
                                //         ],
                                //       )
                                //     : Shimmer.fromColors(
                                //         baseColor: Colors.grey[300]!,
                                //         highlightColor: Colors.grey[100]!,
                                //         child: Padding(
                                //           padding:
                                //               EdgeInsets.only(top: 320, left: 10),
                                //           child: Container(
                                //             height: 20,
                                //             width: 90,
                                //             color: Colors.grey,
                                //           ),
                                //         ),
                                //       ),
                              }),
                        ),
                      ),
                    ]);
                  } else {
                    return buildShimmerHome();
                  }
                },
              ),
              const Padding(
                padding: EdgeInsets.only(top: 50, left: 20, right: 20),
                child: AppTextField(
                    hintText: 'Search Product offers ',
                    prefixIcon: Icon(Icons.search),
                    color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 170, left: 260),
                child: Container(
                  height: 70,
                  width: 70,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text('Day:\n' + date)),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 170, left: 60),
                child: Text(
                  'Latest products\nin our store...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 300, left: 50),
                height: 8,
                child: GridView.builder(
                  itemCount: 5,
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
                        color: _courntpageindex == index
                            ? Colors.blue
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 370, left: 40),
                  child: Row(children: [
                    const Text(
                      'Category',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 190),
                      child: Text(
                        'see more',
                        style: TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BnSmartStoreScreen(
                                    currentIndex: 2,
                                    password: SharedPrefController().password,
                                    phone: SharedPrefController().phon)));
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      ),
                    )
                  ])),
              Padding(
                  padding: const EdgeInsets.only(top: 660, left: 40),
                  child: Row(
                    children: [
                      const Text(
                        'latest_products',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 150),
                        child: Text(
                          'see more',
                          style: TextStyle(
                            fontSize: 11,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/latestscreen');
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        ),
                      )
                    ],
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 1100, left: 40),
                  child: Row(
                    children: [
                      const Text(
                        'famous_products',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 140),
                        child: Text(
                          'see more',
                          style: TextStyle(
                            fontSize: 11,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/latestscreen');
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        ),
                      )
                    ],
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 1960),
                  child: FutureBuilder<List<Offers>>(
                      future: _futureOffer,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return buildShimmerOffers();
                        } else if (snapshot.hasData &&
                            snapshot.data!.isNotEmpty) {
                          offers = snapshot.data ?? [];
                          return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 3,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                // Color _iconColor = Colors.blue;
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDescriptionsScreenOffer(
                                                  id: offers[index].productId!,
                                                  image: offers[index]
                                                      .imageUrl
                                                      .toString(),
                                                )));
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 23, vertical: 20),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(15),
                                        elevation: 20.0,
                                        shadowColor: const Color(0xFFF4E55AF),
                                        child: Container(
                                          height: 90,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF7F7F7),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: ListTile(
                                            // contentPadding: EdgeInsets.zero,
                                            leading: Container(
                                              width: 70,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.black12,
                                                image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                    offers[index]
                                                        .imageUrl
                                                        .toString(),
                                                  ),
                                                ),
                                              ),
                                              // child: Container(
                                              //   width: 80,
                                              //   height: 80,
                                              //   decoration: BoxDecoration(
                                              //     color: Colors.red,
                                              //       borderRadius: BorderRadius.circular(15),
                                              //       image: DecorationImage(
                                              //         fit: BoxFit.fill,
                                              //         image: NetworkImage(
                                              //             _users[index].imageUrl.toString()),
                                              //       ))),
                                            ),
                                            title: Stack(children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                        ' ${offers[index].nameEn.toString()}')),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 50),
                                                child: Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(' ' +
                                                        'discount:' +
                                                        ' ' +
                                                        offers[index]
                                                            .discountPrice
                                                            .toString())),
                                              ),
                                              Container(
                                                  width: 100,
                                                  margin: const EdgeInsets.only(
                                                      top: 53, left: 120),
                                                  child: const Divider(
                                                    color: Colors.red,
                                                  )),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 50, left: 120),
                                                child: Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                        ' ${'original:' + ' ' + offers[index].originalPrice.toString()}')),
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10, right: 10),
                                                    child: Text(
                                                        offers[index].expired!
                                                            ? 'expired'
                                                            : 'available')),
                                              ),
                                            ]),
                                          ),
                                        ),
                                      )),
                                );
                                // ) : Shimmer.fromColors(
                                //   baseColor: Colors.grey[300]!,
                                //   highlightColor: Colors.grey[100]!,
                                //   child: Padding(
                                //     padding: EdgeInsets.symmetric(
                                //         horizontal: 23, vertical: 20),
                                //     child: Container(
                                //       height: 90,
                                //       decoration: BoxDecoration(
                                //         color: Color(0xFFF7F7F7),
                                //         borderRadius: BorderRadius.circular(
                                //             15),
                                //       ),
                                //     ),
                                //   ),
                                // );
                              });
                        } else {
                          return buildShimmerOffers();
                        }
                      })),
              Padding(
                  padding: const EdgeInsets.only(top: 1930, left: 40),
                  child: Row(
                    children: [
                      const Text(
                        'offers_product',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 155),
                        child: Text(
                          'see more',
                          style: TextStyle(
                            fontSize: 11,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/offers_screen');
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        ),
                      )
                    ],
                  )),
            ])
          ]));
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Stack buildShimmerHome() {
    return Stack(children: [
      Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Padding(
          padding: const EdgeInsets.only(top: 150, left: 40, right: 40),
          child: Container(
            height: 200,
            width: 360,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CarouselSlider.builder(
                  itemCount: 5,
                  options: CarouselOptions(
                    onPageChanged: (index, value) {
                      setState(() {
                        _courntpageindex = index;
                      });
                    },
                    //enlargeCenterPage: true,
                    height: 200,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    reverse: false,
                    aspectRatio: 5.0,
                    viewportFraction: 1.0,
                    //       aspectRatio: 2,
                  ),
                  itemBuilder: (context, i, id) {
                    return GestureDetector(
                        //ClipRRect for image border radius
                        child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            topLeft: Radius.circular(15),
                            topRight: const Radius.circular(15)),
                      ),
                      width: 340,
                      height: 200,
                    ));
                  }),
            ),
          ),
        ),
      ),
      Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          margin: const EdgeInsets.only(top: 425, left: 40, right: 10),
          height: 250,
          child: GridView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 130,
              ),
              itemBuilder: (context, index) {
                return Stack(children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: const Color(0xFFF7F7F7),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: const Color(0xFFF7F7F7),
                        )),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          height: 70,
                          width: 70,
                          color: Colors.grey,
                        )),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 85, left: 10),
                      child: Container(
                        height: 10,
                        width: 80,
                        color: Colors.grey,
                      )),
                ]);
              }),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 705),
        height: 300,
        child: GridView.builder(
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 20,
              childAspectRatio: 7 / 4,
            ),
            itemBuilder: (context, index) {
              return Stack(children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  height: 300,
                  decoration: BoxDecoration(
                      color: const Color(0xFFF7F7F7),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: const Color(0xFFF7F7F7),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 40),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24)),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 205,
                          width: 300,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 270, left: 10),
                    child: Container(
                      height: 20,
                      width: 90,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ]);
            }),
      ),
      Container(
        margin: const EdgeInsets.only(top: 1070),
        child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 4,
            scrollDirection: Axis.vertical,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 130,
                mainAxisSpacing: 20,
                childAspectRatio: 3 / 8),
            itemBuilder: (context, index) {
              return Stack(children: [
                Container(
                    height: 700,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F7F7),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 40),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24)),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 700,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  color: Colors.grey,
                                )),
                          ),
                        ),
                      ),
                    )),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 320, left: 10),
                    child: Container(
                      height: 20,
                      width: 90,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ]);
            }),
      ),
    ]);
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////
  ListView buildShimmerOffers() {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 3,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          // Color _iconColor = Colors.blue;
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 20),
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          );
        });
  }
}
