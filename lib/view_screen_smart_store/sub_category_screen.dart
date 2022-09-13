import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:smartsstors/view_screen_smart_store/product_sub_category.dart';
import 'package:smartsstors/widget/AppTextFieldSearch.dart';

import '../api_controller/auth_api_controller.dart';
import '../model/list_sub_category.dart';

class SubCategoryScreen extends StatefulWidget {
  SubCategoryScreen({Key? key, required this.id, required this.image,required this.categoryname}) : super(key: key);
  final int id;
  final String image;
  final String categoryname;
  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  late bool connectedInternet;
  List<ListSubcategory> subCategory = <ListSubcategory>[];
  List<int> subCategoryLeangth = <int>[];
  late int offerslegnth;
  Color _iconColor = Colors.red;
  late int LeanthSubCategorys=0;
  late Future<List<ListSubcategory>> _futureSubCategory;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  void initState() {
    //   // TODO: implement initState
    super.initState();
    _futureSubCategory = AuthApiController().getSupCategory(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    double landscape = MediaQuery.of(context).size.height;
    double portrait = MediaQuery.of(context).size.width;
    double Landscape = landscape;
    double Portrait = portrait;
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
        backgroundColor:const Color(0xFFF4E55AF),
        leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white,size: 30,),
    onPressed: () => Navigator.pop(context),
           )),
        body: ListView(shrinkWrap: true, children: [
          Stack(children: [
            Container(
              height: 250,
              color: const Color(0xFFF4E55AF),
            ),
                  Padding(
                  padding: const EdgeInsets.only(left: 50,top: 20),
                    child:SimpleShadow(
                      opacity: 0.6,         // Default: 0.5
                          color: Colors.blue,   // Default: Black
                          offset: const Offset(30, 30), // Default: Offset(2, 2)
                         sigma: 7,
                      child:Padding(
                          padding: const EdgeInsets.only(left: 50,right: 100),child: Image.network(widget.image.toString(),height: 150,)),
                          ),
                        ),


                    // color: Color(0xFFF4E55AF)


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
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white),
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
                  hintText: 'Search sub categories ',
                  prefixIcon: Icon(Icons.search),
                  color: Colors.white),
            ),
            Container(
              margin: const EdgeInsets.only(top: 350),
              child: FutureBuilder<List<ListSubcategory>>(
                  future: _futureSubCategory,
                  builder: (context, snapshot) {
                    subCategory= snapshot.data ?? [];
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return buildShimmerSubCategory();
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return Stack(
                        children:[ Padding(
                          padding: const EdgeInsets.only(top: 40,left: 20,right: 20),
                    child:Material(
                      borderRadius: BorderRadius.circular(15),
                      elevation: 20.0,
                      shadowColor: Colors.white,

                      child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(topRight:Radius.circular(20),bottomLeft: Radius.circular(20)),
                                ),
                                child: ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: subCategory.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      // Color _iconColor = Colors.blue;
                                      return
                                        InkWell(
                                            onTap: () {
                      Navigator.push
                      (context,MaterialPageRoute(builder: (context)=>ProductSubCategoryScreen(id:subCategory[index].id!, categoryName: subCategory[index].nameEn.toString(), image:subCategory[index].imageUrl.toString() ,)));
                                            },
                                            child: connectedInternet
                                                ? Padding(
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
                                                            subCategory[index]
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
                                                        padding:
                                                        const EdgeInsets.only(top: 10),
                                                        child: Align(
                                                            alignment:
                                                            Alignment.topLeft,
                                                            child: Text(
                                                                ' ${subCategory[index].nameEn.toString()}')),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(top: 50,left: 5),
                                                        child: Align(
                                                            alignment:
                                                            Alignment.topLeft,
                                                            child: Text('category:  '+widget.categoryname)),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(top: 10,left: 100),
                                                        child: Align(
                                                            alignment:
                                                            Alignment.topLeft,
                                                            child: Text('product: '+subCategory[index].productsCount.toString())),
                                                      ),


                                                    ]),
                                                  ),
                                                ),
                                              ),
                                            )
                                                : Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 23, vertical: 20),
                                                child: Container(
                                                  height: 90,
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xFFF7F7F7),
                                                    borderRadius:
                                                    BorderRadius.circular(15),
                                                  ),
                                                ),
                                              ),
                                            ));
                                    }),
                              ),
                    ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 1,left: 23),
                              child: Text(subCategory.length.toString()+'  '+'sub categories available',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                        ]);
                    } else {
                      return buildShimmerSubCategory();
                    }

                  }),

            ),

        ])]));
  }

  ListView buildShimmerSubCategory() {
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
}
