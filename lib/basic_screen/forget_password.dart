import 'package:flutter/material.dart';
import 'package:smartsstors/basic_screen/helpers.dart';
import 'package:smartsstors/basic_screen/reset_password.dart';
import 'package:smartsstors/widget/app_text_field Name.dart';
import 'package:smartsstors/widget/app_text_field Password.dart';

import '../api_controller/auth_api_controller.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword>with Helpers {
  late TextEditingController _phoneTextController;
  bool f=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _phoneTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _phoneTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double landscape = MediaQuery.of(context).size.height;
    double portrait = MediaQuery.of(context).size.width;
    double textscal = MediaQuery.of(context).textScaleFactor;
    double Landscape = landscape;
    double Portrait = portrait;
    //
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding:
          EdgeInsets.symmetric(horizontal: 20, vertical: Landscape * 0.036),
          children: [
            Padding(
              padding: EdgeInsets.only(top: 70),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Padding(
                  padding: EdgeInsets.only(right: Portrait * 0.042),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Forget password',
                  style: TextStyle(fontSize: 18.0*textscal, fontWeight: FontWeight.bold),
                ),
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(top: Landscape * 0.017),
              child: Stack(children: [
                Padding(
                  padding: EdgeInsets.only(top: Landscape * 0.04, left: 10),
                  child: Text(
                    'Continue using',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Landscape * 0.095, left: 10),
                  child: Text(
                    'Enter mobile to receive reset code...',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.only(
                      top: Landscape * 0.188, left: 10, right: 10),
                  child: AppTextField(
                    hintText: 'Name',
                    prefixIcon: Icon(
                      Icons.person,
                      color: Color(0xFF222B45),
                    ),
                    color: Colors.white, controller:_phoneTextController ,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: Landscape * 0.392, left: 10, right: 10),
                    child: Container(
                      width: Portrait * 0.893,
                      height: Landscape * 0.068,
                      decoration: BoxDecoration(
                        color: Color(0xFF4E55AF),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextButton(
                        //       child: const Text('LOGIN'),
                        //       style: ElevatedButton.styleFrom(
                        //         minimumSize: const Size(500,56),
                        onPressed: () async=> await _performForgetPassword(), child: Text('send'),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ]),
    );
  }


  Future<bool> _performForgetPassword() async {
    if (_checkData()) {
      _forgetPassword();
      return true;
    } else {
      return false;
    }
  }

  bool _checkData() {
    if (_phoneTextController.text.isNotEmpty) {
      return true;
    }
    //TODO: SHOW SNACK BAR
    showSnackBar(
      context: context,
      message: 'Enter required data!',
      error: true,
    );
    return false;
  }

  Future<void> _forgetPassword() async {
    bool statas =
    await AuthApiController().forgetPassword(context,mobile: _phoneTextController.text);
    if (statas) {
      Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>ResetPasswordScreen(mobile: _phoneTextController.text)));
    });
  }
  }


  }



