import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartsstors/pref/shared_pref_controller.dart';
import '../basic_screen/helpers.dart';
import '../controller_Db/Information_cart_provider.dart';
import '../controller_Db/information_cart.dart';

class CartScreen extends StatefulWidget {
  CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with Helpers {
  bool download = false;
  int total = 0;
  int counter = 0;
  List<InformationCart> informationCart = <InformationCart>[];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void initState() {
    //   // TODO: implement initState
    super.initState();
    Provider.of<InformationCartProvider>(context, listen: false).read();
  }

  @override
  Widget build(BuildContext context) {
    double Landscape = MediaQuery.of(context).size.height;
    double Portrait = MediaQuery.of(context).size.width;
    return Scaffold(
        extendBodyBehindAppBar: false,
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Cart'),
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
            },
          ),
        ),
        body: Stack(children: [
          Container(child: Consumer<InformationCartProvider>(builder:
              (BuildContext context, InformationCartProvider value, child) {
            if (informationCart.isEmpty) {
              for (int i = 0; i < value.contact.length; i++) {
                if (value.contact[i].idUser == SharedPrefController().id) {
                  informationCart.add(value.contact[i]);
                }
              }
            }

            if (informationCart.isNotEmpty) {
              if (counter < 1) {
                calculateTotal();
                counter++;
              }

              return InkWell(
                child: Stack(children: [
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: informationCart.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
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
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.black12,
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                          informationCart[index]
                                              .image
                                              .toString(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: Stack(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                              ' ${informationCart[index].price}')),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(top: 50),
                                        child: Text(' ' +
                                            'QUANTITY:' +
                                            ' ' +
                                            informationCart[index]
                                                .quantity
                                                .toString())),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            top: 40, left: 130),
                                        child: Container(
                                          width: Portrait * 0.373,
                                          height: Landscape * 0.055,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF4E55AF),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Stack(children: [
                                            TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (informationCart[index]
                                                          .count >
                                                      1) {
                                                    informationCart[index]
                                                        .count--;
                                                    total = total -
                                                        (informationCart[index]
                                                            .price);
                                                  }
                                                });
                                              },
                                              child: const Text(
                                                '-',
                                                style: TextStyle(fontSize: 25),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 66, top: 13),
                                              child: Text(
                                                informationCart[index]
                                                    .count
                                                    .toString(),
                                                style: const TextStyle(
                                                    color:
                                                        Color(0xFFFFFA1DBF5)),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 90),
                                              child: TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    informationCart[index]
                                                        .count++;
                                                    total = total +
                                                        (informationCart[index]
                                                            .price);
                                                  });
                                                },
                                                child: const Text(
                                                  '+',
                                                  style:
                                                      TextStyle(fontSize: 19),
                                                ),
                                              ),
                                            ),
                                          ]),
                                        )),
                                  ]),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Card(
                      margin: EdgeInsets.all(15),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Total',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(width: 10),
                            Spacer(),
                            Chip(
                              label: Text(total.toString() + '.00',
                                  style: TextStyle(color: Colors.white)),
                              backgroundColor: Color(0xFF4E55AF),
                            ),
                            SizedBox(width: 20),
                            Container(
                              width: Portrait * 0.393,
                              height: Landscape * 0.064,
                              decoration: BoxDecoration(
                                color: Color(0xFF4E55AF),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    download = true;
                                  });
                                  Future.delayed(const Duration(seconds: 3),
                                      () {
                                    Navigator.pushNamed(
                                        context, '/offersscreen');
                                  });
                                },
                                child: Text('Order Now',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            SizedBox(width: 10),
                            download ? CircularProgressIndicator() : Text(''),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
              );
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
                      'No cart',
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
          })),
        ]));
  }

  void calculateTotal() {
    informationCart.forEach((element) {
      total += element.count * element.price;
    });
  }

//
// Future<void> createCart() async {
//   bool create = await Provider.of<InformationCartProvider>(context, listen: false)
//       .create(c: cart);
//   if (create) {
//     showSnackBar(context: context, message: 'pass', error: false);
//   } else {
//     showSnackBar(context: context, message: 'no paas', error: false);
//   }
// }
//
// InformationCart get cart {
//   InformationCart informcart = InformationCart();
//   informcart.name = informationCart[0].name;
//   informcart.price = 10;
//   informcart.count = 3;
//   informcart.image = 'https://www.almrsal.com/wp-content/uploads/2016/04/Fruit-apple-one-protect-against-premature-death.jpg';
//   informcart.idProduct = 779;
//   informcart.quantity = 300;
//   informcart.infoEn = 'lxwmlxlwmlxw';
//   informcart.infoAr = 'xwl,xmwlmlxw';
//   informcart.overalRate = 3;
//   informcart.productRate = 4;
//   informcart.offerPrice = 4;
//   informcart.subCategoryId = 400;
//   informcart.nameAr = 'xle,lx,el,';
//   informcart.isFavorite = 1;
//   informcart.idUser = SharedPrefController().id;
//   return informcart;
// }
}
