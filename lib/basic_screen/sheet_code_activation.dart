import 'package:flutter/material.dart';

mixin sheetCodeActivation{
   modalBottomSheetMenuCode({required String messageReplay ,required String code,required BuildContext context}) {
    double landscape = MediaQuery.of(context).size.height;
    double portrait = MediaQuery.of(context).size.width;
    double Landscape = landscape;
    double Portrait = portrait;
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (context) {
          return SizedBox(
            height: Landscape * 0.557,
            child: Padding(
              padding: EdgeInsets.only(top: Landscape * 0.103),
              child: Stack(children: [
                Container(
                  padding: EdgeInsets.only(
                      left: Portrait * 0.341,
                      right: Portrait * 0.34),
                  width: Landscape * 14.7,
                  height: Portrait * 0.32,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF7F7F7),
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                      padding: EdgeInsets.only(
                          top: Landscape * 0.032,
                          bottom: Landscape * 0.041),
                      child: Image.asset('images/lock.png')),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: Landscape * 0.23,
                      left: Portrait * 0.206,
                      right: Portrait * 0.146),
                  child: Text(
                    messageReplay,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: Landscape * 0.13),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'activation code: '+code,
                        style:
                        const TextStyle(fontSize: 16, color: Colors.grey,fontWeight: FontWeight.bold,),
                      ),
                    ),
                  ),


              ]),
            ),
          );
        });
  }


}
