import 'package:concentric_transition/page_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../model/item-data_outboarding.dart';
import 'outboarding_item_widget.dart';

 class OutBoardingSmartStore extends StatelessWidget {
   OutBoardingSmartStore({Key? key}) : super(key: key);
  final data = [
    ItemData(
      title: "Genuine product",
      subtitle: "Diversified items of products in life, genuine product, safe",
      image: Image(image: AssetImage('images/imageone.png'),height: 300,),
      backgroundColor: const Color.fromRGBO(0, 10, 56, 1),
      titleColor: Colors.amber,
      subtitleColor: Colors.green,
      background: Lottie.network(
          'https://assets2.lottiefiles.com/packages/lf20_bq485nmk.json'),

    ),
    ItemData(
      title: "Convenient ordering",
      subtitle: "Order multiple items from multiple brands at the same time.",
      image: Image(image: AssetImage("images/imagetwo.png"),height: 300,),
      backgroundColor: Colors.white,
      titleColor: Colors.purple,
      subtitleColor: const Color.fromRGBO(0, 10, 56, 1),
      background: Lottie.network(
          'https://assets2.lottiefiles.com/packages/lf20_bq485nmk.json'),
    ),
    ItemData(
      title: "Easy search",
      subtitle: "Find products easy with Scanning camera, pay with just one camera scan.",
      image: Image(image: AssetImage("images/imagethree.png"),height: 300,),
      backgroundColor: const Color.fromRGBO(71, 59, 117, 1),
      titleColor: Colors.orange.shade600,
      subtitleColor: Colors.white,
      background: Lottie.network(
          'https://assets2.lottiefiles.com/packages/lf20_bq485nmk.json'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
          radius: 40,
        colors: data.map((e) => e.backgroundColor).toList(),
        itemCount: data.length,
    itemBuilder: (int index){
            print(index);
      return ItemWidget(data: data[index], courntpageindex: index);
    }

      ),
    );
  }
}