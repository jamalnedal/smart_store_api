import 'package:flutter/material.dart';
import 'package:smartsstors/pref/shared_pref_controller.dart';

import '../view_screen_smart_store/bn_smart_store_screen.dart';

class LaunchScreen extends StatefulWidget {
  LaunchScreen({Key? key}) : super(key: key);
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      print(SharedPrefController().phon);
      SharedPrefController().loggedIn
          ? Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BnSmartStoreScreen( password:SharedPrefController().password , phone:SharedPrefController().phon, currentIndex: 0,)))
              : SharedPrefController().showOutBo?Navigator.pushReplacementNamed(context,'/login_screen'):Navigator.pushReplacementNamed(context,'/out_boarding_smart_Store');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Color(0xFFF4E55AF)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50.0,
                          child: Image(image: AssetImage('images/Logo.png'),)
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        'smart store',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      'Smart Store for all products',
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
