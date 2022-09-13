import 'package:flutter/material.dart';
import 'package:smartsstors/basic_screen/helpers.dart';
import 'package:smartsstors/widget/app_text_field Name.dart';
import '../api_controller/auth_api_controller.dart';
import '../model/user_store.dart';

class ActivationCode extends StatefulWidget {
  ActivationCode({Key? key,required this.mobile}) : super(key: key);
  final String mobile;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ActivationCode>with Helpers {
  late TextEditingController _activateTextController;
  bool f=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _activateTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _activateTextController.dispose();
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
                  'Activation Code',
                  style: TextStyle(fontSize: 18*textscal, fontWeight: FontWeight.bold),
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
                      fontSize: 24*textscal,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Landscape * 0.095, left: 10),
                  child:  Text(
                    'Activation code.',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24*textscal,
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
                    color: Colors.white, controller:_activateTextController ,
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
                        onPressed: () async=> await _performActivation(), child: Text('send'),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ]),
    );
  }


  Future<bool> _performActivation() async {
    if (checkCode()&&_checkData()) {
      _activation();
      return true;
    } else {
      return false;
    }
  }

  bool _checkData() {
    if (_activateTextController.text.isNotEmpty) {
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

  Future<void> _activation() async {
    bool statas =
    await AuthApiController().activation(context, userStores);
    if (statas) {
      Navigator.pushNamed(context, '/loginscreen');
    }
  }
  bool checkCode() {
    if (_activateTextController.text.length != 4) {
      showSnackBar(
        context: context,
        message: 'Enter received code 4 digits yagagsaggs',
        error: true,
      );
    }
    return true;
  }

  UserStore get userStores {
    UserStore userStore = UserStore();
    userStore.mobile = widget.mobile;
    userStore.actives =_activateTextController.text;
    return userStore;
  }
}


