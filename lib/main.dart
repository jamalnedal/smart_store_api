import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartsstors/basic_screen/forget_password.dart';
import 'package:smartsstors/basic_screen/login_smart.dart';
import 'package:smartsstors/basic_screen/my-home-smart-store.dart';
import 'package:smartsstors/pref/shared_pref_controller.dart';
import 'package:smartsstors/view_screen_smart_store/carts_creen.dart';
import 'package:smartsstors/view_screen_smart_store/category_screen.dart';
import 'package:smartsstors/view_screen_smart_store/offer_screen.dart';
import 'basic_screen/launch_screen.dart';
import 'basic_screen/outboarding_home.dart';
import 'basic_screen/register_smart.dart';
import 'controller_Db/Information_cart_provider.dart';
import 'controller_Db/db_controller_product_cart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbControllerProductCart().initDataBase();
  await SharedPrefController().initPref();
  runApp(const MyAppShoping());
}

class MyAppShoping extends StatelessWidget {
  const MyAppShoping({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
return MultiProvider(
    providers: [
  ChangeNotifierProvider<InformationCartProvider>(
     create:(context) => InformationCartProvider()) ,
],
  child:MyApp(),);
  }
  }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        builder: (context, child) {
      // Obtain the current media query information.
      final mediaQueryData = MediaQuery.of(context);

      return MediaQuery(
        // Set the default textScaleFactor to 1.0 for
        // the whole subtree.
          data: mediaQueryData.copyWith(textScaleFactor: 1.0),
          child: child!);
        },

        initialRoute: '/launch_screen',
        routes: {
          '/out_boarding_smart_Store': (context) => OutBoardingSmartStore(),
          '/login_screen': (context) => const LoginSmartScreen(),
          '/register_screen': (context) => const RegisterSmartScreen(),
          '/forget_screen': (context) => const ForgetPassword(),
          '/launch_screen': (context) => LaunchScreen(),
          '/cart_screen': (context) => CartScreen(),
          '/offers_screen': (context) => OffersScreen(),


        });
  }
}
