import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartsstors/pref/shared_pref_controller.dart';
import 'package:smartsstors/view_screen_smart_store/product_Description.dart';
import 'package:smartsstors/view_screen_smart_store/product_description_offer.dart';

import '../api_controller/auth_api_controller.dart';
import '../basic_screen/helpers.dart';
import '../model/fvoraite_product.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({
    Key? key,
  }) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> with Helpers {
  List<FvoraiteProduct?> favoraiteProducts = <FvoraiteProduct>[];
  StreamSubscription? connection;
  late Future<List<FvoraiteProduct?>> _futureFavoraite;
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();

  @override
  void initState() {
    initConnectivity();
    connection = Connectivity()
        .onConnectivityChanged
        .listen((_updateConnectionState) {});
    //   // TODO: implement initState
    super.initState();
    _futureFavoraite = AuthApiController().getFavoraite(context);
  }

  @override
  void dispose() {
    connection!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Stack(children: [
          FutureBuilder<List<FvoraiteProduct?>>(
              future: _futureFavoraite,
              builder: (context, snapshot) {
                favoraiteProducts = snapshot.data ?? [];
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return buildShimmerFavorite();
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  if (SharedPrefController().id ==
                          favoraiteProducts[0]!.pivot!.userId &&
                      favoraiteProducts.isNotEmpty) {
                    print('8888888888888888888888888888');
                    return InkWell(
                      child: Stack(children: [
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: favoraiteProducts.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              // Color _iconColor = Colors.blue;
                              return InkWell(
                                onTap: () {
                                  if (favoraiteProducts[index]!.offerPrice ==
                                      null) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDescriptionsScreen(
                                                  id: favoraiteProducts[index]!
                                                      .id!,
                                                  expired: true,
                                                )));
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDescriptionsScreenOffer(
                                                  id: favoraiteProducts[index]!
                                                      .id!,
                                                  image:
                                                      favoraiteProducts[index]!
                                                          .imageUrl
                                                          .toString(),
                                                )));
                                  }
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
                                        borderRadius: BorderRadius.circular(15),
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
                                                favoraiteProducts[index]!
                                                    .imageUrl
                                                    .toString(),
                                              ),
                                            ),
                                          ),
                                        ),
                                        title: Stack(children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                    ' ${favoraiteProducts[index]!.nameEn.toString()}')),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 50),
                                              child: Text(
                                                  '${' ' + 'QUANTITY:' + ' ' + favoraiteProducts[index]!.quantity.toString()}')),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 50, left: 170),
                                              child: Text(
                                                  ' ${favoraiteProducts[index]!.price.toString() + '' + '₪'}')),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 170),
                                            child: IconButton(
                                                iconSize: 25,
                                                onPressed: () async {
                                                  await AuthApiController()
                                                      .favoraite(context,
                                                          product_id:
                                                              favoraiteProducts[
                                                                      index]!
                                                                  .id);
                                                  setState(() {
                                                    favoraiteProducts[index]!
                                                            .isFavorite =
                                                        !favoraiteProducts[
                                                                index]!
                                                            .isFavorite!;
                                                    int indexs = favoraiteProducts
                                                        .indexWhere((element) =>
                                                            element!.id ==
                                                            favoraiteProducts[
                                                                    index]!
                                                                .id);
                                                    if (indexs != -1) {
                                                      favoraiteProducts
                                                          .removeAt(indexs);
                                                    }
                                                    ;
                                                  });
                                                },
                                                icon: favoraiteProducts[index]!
                                                        .isFavorite!
                                                    ? const Icon(Icons.delete,
                                                        color: Colors.red)
                                                    : const Icon(Icons.delete,
                                                        color: Colors.grey)),
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ]),
                    );
                  } else {
                    print(favoraiteProducts[0]!.pivot!.userId);
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.warning,
                            size: 80,
                            color: Colors.grey,
                          ),
                          Text(
                            'No Favourite',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    );
                  }
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.warning,
                          size: 80,
                          color: Colors.grey,
                        ),
                        Text(
                          'No Data',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  );
                }
              }),
        ]));
  }

  ListView buildShimmerFavorite() {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 4,
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

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await Connectivity().checkConnectivity();
    } on PlatformException catch (e) {
      print("Error Occurred: ${e.toString()} ");
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    if (result == ConnectivityResult.none) {
      return _updateConnectionState(result);
    }
  }

  Future<void> _updateConnectionState(ConnectivityResult result) async {
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      showStatus(result, true);
    } else {
      showStatus(result, false);
    }
  }

  void showStatus(ConnectivityResult result, bool status) {
    const snackBar = SnackBar(
      content: Text('no internet'),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 5),
      dismissDirection: DismissDirection.horizontal,
    );
    //SnackBar(
    //     content:
    //     Text("${status ? 'ONLINE\n' : 'OFFLINE\n'}${result.toString()} "),
    //     backgroundColor: status ? Colors.green : Colors.red);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
