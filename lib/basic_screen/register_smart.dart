import 'dart:math';
import 'package:flutter/material.dart';
import 'package:smartsstors/api_controller/auth_api_controller.dart';
import 'package:smartsstors/basic_screen/activate_code.dart';
import 'package:smartsstors/basic_screen/helpers.dart';
import 'package:smartsstors/widget/app_text_field Name.dart';
import 'package:smartsstors/widget/app_text_field Password.dart';
import 'package:smartsstors/model/cities.dart';

import '../model/user_store.dart';


class RegisterSmartScreen extends StatefulWidget {
  const RegisterSmartScreen({Key? key}) : super(key: key);

  @override
  _RegisterSmartScreenState createState() => _RegisterSmartScreenState();
}

class _RegisterSmartScreenState extends State<RegisterSmartScreen> with Helpers {
  late TextEditingController _fullNAmeTextController;
  late TextEditingController _phoneTextController;
  late TextEditingController _passwordTextController;
  late TextEditingController _cityIDController;
  String _gender = 'M';
  int? selectedCity;
  bool _obscureText=true;
  late String cityt;
  bool checkSelectedCity=true;

  //var List_name=['','',];
  List<City> Cities = <City>[];
  late Future<List<City>> _city;

  // @override
  void initState() {
    //   // TODO: implement initState
    super.initState();
    //   _emailTextController = TextEditingController();
    //   _passwordTextController = TextEditingController();
    _fullNAmeTextController = TextEditingController();
    _phoneTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _cityIDController = TextEditingController();
    _city = AuthApiController().getCities(context);
  }

  //
  // @override
  void dispose() {
    //   // TODO: implement dispose
    _fullNAmeTextController.dispose();
    _phoneTextController.dispose();
    _passwordTextController.dispose();
    _cityIDController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double landscape = MediaQuery.of(context).size.height;
    double portrait = MediaQuery.of(context).size.width;
    double Landscape = landscape;
    double Portrait = portrait;
    print(landscape);
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding:
            EdgeInsets.symmetric(horizontal: 20, vertical: Landscape * 0.069),
        children: [
          Image(
            image: AssetImage('images/Logo.png'),
            height: Landscape * 0.0594,
            width: portrait * 0.0138,
          ),
          Padding(
            padding: EdgeInsets.only(top: Landscape * 0.0274),
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                width: portrait * 0.89,
                // color: Colors.red,
                height: Landscape * 0.72,
              ),
              Padding(
                padding: EdgeInsets.only(top: Landscape * 0.0457, left: 10),
                child: const Text(
                  'Create new',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: Landscape * 0.0957, left: 10),
                child: const Text(
                  'Account.',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: Landscape * 0.164, left: 10, right: 10),
                child: AppTextField(
                  hintText: 'Name',
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Color(0xFF222B45),
                  ),
                  color: Color(0xFFF7F7F7),
                  controller: _fullNAmeTextController,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: Landscape * 0.256, left: 10, right: 10),
                child: AppTextField(
                  hintText: '587691611',
                  prefixIcon: const Icon(
                    Icons.phone,
                    color: Color(0xFF222B45),
                  ),
                  color: const Color(0xFFF7F7F7),
                  controller: _phoneTextController,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: Landscape * 0.348, left: 10, right: 10),
                child: AppTextFieldP(
                    obscureText: _obscureText,
                    hintText: 'password',
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Color(0xFF222B45),
                    ),
                    controller: _passwordTextController,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      icon: Icon(_obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                    )),
              ),
              Container(
                width: Portrait * 0.893,
                height: Landscape * 0.064,
                decoration: BoxDecoration(
                    color: Color(0xFFF7F7F7),
                    borderRadius: BorderRadius.circular(16)),
                margin:
                    EdgeInsets.only(top: Landscape * 0.44, left: 10, right: 10),
                child: Padding(
                  padding: EdgeInsets.only(left: portrait * 0.12),
                  child: FutureBuilder<List<City>>(
                      future: _city,
                      builder: (context, snapshot) {
                        Cities = snapshot.data ?? [];
                        return DropdownButton<int>(
                          // Initial Value
                          hint:Text('city'),
                          isExpanded: true,
                          onTap: () {},
                          elevation: 4,
                          value: selectedCity,
                          onChanged: (int? value) {
                            if (value != null) {
                              setState(() {
                                selectedCity = value;
                              });
                            }
                          },
                          items:Cities.map((e)=>
                             DropdownMenuItem(
                                  child: Text(e.nameEn),
                                  value: e.id,
                                ),
                              )
                              .toList(),
                        );}),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: Landscape * 0.46, left: portrait * 0.05),
                child: const Icon(
                  Icons.location_city,
                  color: Color(0xFF222B45),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: Landscape * 0.534),
                child: Row(children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Female'),
                      groupValue: _gender,
                      value: 'F',
                      onChanged: (String? value) {
                        if (value != null) {
                          setState(() {
                            _gender = value;
                          });
                        }
                      },
                    ),
                  ),
                  Expanded(
                      child: RadioListTile<String>(
                              title: const Text('Male'),
                    groupValue: _gender,
                    value: 'M',
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          _gender = value;
                        });
                      }
                    },
                  ))
                ]),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: Landscape * 0.614, left: 10, right: 10),
                child: Container(
                  width: Portrait * 0.893,
                  height: Landscape * 0.064,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4E55AF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextButton(
                    //       child: const Text('LOGIN'),
                    //       style: ElevatedButton.styleFrom(
                    //         minimumSize: const Size(500,56),
                    onPressed: ()async=>_performRegisterSmart(), child: const Text('login'),
                  ),
                ),
              ),
            ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('I already have an account.'),
              TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/loginscreen'),
                child: const Text('Sign in '),
              ),
            ],
          ),
          TextButton(
            onPressed: ()=>Navigator.pushNamed(context, '/Forgetscreen'),
            child: const Text('Forget Password?'),
          ),
        ],
      ),
    );
  }

  Future<bool> _performRegisterSmart() async {
    if (_checkData()) {
      registerSmarts();
      return true;
    } else {
      return false;
    }
  }

  bool _checkData() {
    if (_fullNAmeTextController.text.isNotEmpty &&
        _phoneTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
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

  Future<void> registerSmarts() async {
    bool statas =
        await AuthApiController().register(context, userStore: userStores);
    if (statas) {
      Future.delayed(const Duration(seconds: 5), () {
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ActivationCode(mobile: _phoneTextController.text,)));
    });
  }}

  UserStore get userStores {
    UserStore userStore = UserStore();
    userStore.name = _fullNAmeTextController.text;
    userStore.mobile = _phoneTextController.text;
    userStore.password = _passwordTextController.text;
    userStore.cityId = Cities[selectedCity!-1].id.toString();
    userStore.STORE_API_KEY;
    userStore.gender = _gender;

    return userStore;
  }
}
