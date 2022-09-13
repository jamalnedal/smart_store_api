import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:smartsstors/view_screen_smart_store/product_Description.dart';
import 'package:smartsstors/view_screen_smart_store/product_description_offer.dart';
import 'package:smartsstors/widget/AppTextFieldSearch.dart';

import '../api_controller/auth_api_controller.dart';
import '../model/products_model.dart';

class ProductSubCategoryScreen extends StatefulWidget {
  ProductSubCategoryScreen(
      {Key? key,
      required this.id,
      required this.image,
      required this.categoryName})
      : super(key: key);
  final int id;
  final String image;
  final String categoryName;

  @override
  _ProductSubCategoryScreenState createState() =>
      _ProductSubCategoryScreenState();
}

class _ProductSubCategoryScreenState extends State<ProductSubCategoryScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  late bool connectedInternet;
  List<Productsmodel> productSubCategory = <Productsmodel>[];
  double rate = 3;
  late Future<List<Productsmodel>> _futureProductSubCategory;
  void initState() {
    //   // TODO: implement initState
    super.initState();
    _futureProductSubCategory =
        AuthApiController().getProductDetails(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    double landscape = MediaQuery.of(context).size.height;
    double portrait = MediaQuery.of(context).size.width;
    return RefreshIndicator(
      displacement: 250,
      key: _refreshIndicatorKey,
      backgroundColor: Colors.yellow,
      color: Colors.red,
      strokeWidth: 3,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: _refreshPhotos,
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: const Color(0xFFF4E55AF),
            leading: Hero(
              tag: 'next2',
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            )),
        body: ListView(shrinkWrap: true, children: [
          Stack(children: [
            Container(
              height: 250,
              color: const Color(0xFFF4E55AF),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, top: 20),
              child: SimpleShadow(
                opacity: 0.6,
                // Default: 0.5
                color: Colors.blue,
                // Default: Black
                offset: const Offset(30, 30),
                // Default: Offset(2, 2)
                sigma: 7,
                child: Padding(
                    padding: const EdgeInsets.only(left: 50, right: 100),
                    child: Image.network(
                      widget.image.toString(),
                      height: 150,
                    )),
              ),
            ),
            OfflineBuilder(
              connectivityBuilder: (BuildContext context,
                  ConnectivityResult connectivity, Widget child) {
                connectedInternet = connectivity != ConnectivityResult.none;
                return Container(
                  width: 400,
                  height: 30,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    color: connectedInternet ? null : const Color(0xFFEE4400),
                    child: connectedInternet
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
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              ),
                            ],
                          ),
                  ),
                );
              },
              child: const Text('xeaxxea'),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 230, left: 40, right: 40),
              child: AppTextFieldSearch(
                  hintText: 'Search Product ',
                  prefixIcon: Icon(Icons.search),
                  color: Colors.white),
            ),
            FutureBuilder<List<Productsmodel>>(
                future: _futureProductSubCategory,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    productSubCategory = snapshot.data ?? [];
                    rate = productSubCategory[0].overalRate!.toDouble();
                    return Stack(children: [
                        Container(
                          margin: const EdgeInsets.only(top: 400),
                          child: InkWell(
                            child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: productSubCategory.length,
                                scrollDirection: Axis.vertical,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 20,
                                        crossAxisSpacing: 0,
                                        childAspectRatio: 5 / 9),
                                itemBuilder: (context, index) {
                                  rate = productSubCategory[index]
                                      .overalRate!
                                      .toDouble();
                                  // Color _iconColor = Colors.blue;
                                  return connectedInternet
                                      ? InkWell(
                                    onTap: () {
                                      if(productSubCategory[index].offerPrice==null){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDescriptionsScreen(
                                                    id: productSubCategory[index].id!,
                                                    expired: true,
                                                  )));
                                    }else{
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDescriptionsScreenOffer(
                                                      id: productSubCategory[index].id!,
                                                      image: productSubCategory[index]
                                                          .imageUrl
                                                          .toString(),
                                                    )));
                                      }},
                                        child: Padding(
                                    padding: const EdgeInsets.only(bottom: 10,left: 10,right: 10),
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
                                                  shadowColor: const Color(0xFFF4E55AF),
                                                  child: Stack(children: [
                                                    Container(
                                                      height: 150,
                                                      decoration: BoxDecoration(
                                                        borderRadius: const BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(20),
                                                            bottomLeft:
                                                                Radius.circular(20)),
                                                        image: DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: NetworkImage(
                                                            productSubCategory[index]
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
                                                              .favoraite(context,
                                                                  product_id:
                                                                      productSubCategory[
                                                                              index]
                                                                          .id);
                                                          setState(() =>
                                                          productSubCategory[index]
                                                                      .isFavorite =
                                                                  !productSubCategory[
                                                                          index]
                                                                      .isFavorite!);
                                                        },
                                                        icon: productSubCategory[index]
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
                                                          productSubCategory[index].nameEn.toString() ,
                                                          style: const TextStyle(
                                                              fontSize: 20,
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
                                                          productSubCategory[index]
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
                                        ),
                                      )
                                      : Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[100]!,
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 20
                                            ),
                                            child: Container(
                                              height: 700,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(24)),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(bottom: 40),
                                                    child: Container(
                                                      color: Colors.grey,
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        );
                                }),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 350, left: 23),
                            child: Text(
                              productSubCategory.length.toString() +
                                  '  ' +
                                  'products available',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )),
                      ]);
                  } else {
                    return const CircularProgressIndicator();
                  }
                })
          ])
        ]),
      ),
    );
  }
  Future<void> _refreshPhotos() async {
    final photos = await AuthApiController().getProductDetails(id: widget.id);
    setState(() {
      build(context);
      productSubCategory = photos;

    });

  }
}
