import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:smartsstors/pref/shared_pref_controller.dart';
import 'package:smartsstors/widget/app_text_field Name.dart';
import 'package:smartsstors/widget/app_text_field Password.dart';
import 'package:smartsstors/model/cities.dart';
import '../api_controller/auth_api_controller.dart';
import '../basic_screen/helpers.dart';
import '../model/passwored_Change.dart';
import '../model/user_store.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> with Helpers {
  late TextEditingController _fullNAmeTextController;
  late TextEditingController _newPasswordTextController;
  late TextEditingController _passwordTextController;
  late TextEditingController _confirmPassword;
  String? _gender = SharedPrefController().gender;
  int? selectedCity = SharedPrefController().city as int?;
  bool _obscureText = true;
  bool _obscureTextNew = true;
  bool _obscureTextConfirm = true;
  bool checkSelectedCity = true;
  late List<City> Cities = <City>[];
  late Future<List<City>> _city;

  // @override
  void initState() {
    //   // TODO: implement initState
    super.initState();

    _fullNAmeTextController =
        TextEditingController(text: SharedPrefController().name);
    _newPasswordTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _confirmPassword = TextEditingController();
    _city = AuthApiController().getCities(context);
  }

  //
  // @override
  void dispose() {
    //   // TODO: implement dispose
    _fullNAmeTextController.dispose();
    _newPasswordTextController.dispose();
    _passwordTextController.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double Landscape = MediaQuery.of(context).size.height;
    double Portrait = MediaQuery.of(context).size.width;
    bool genderImageMale;
    if (SharedPrefController().gender == 'M') {
      genderImageMale = true;
    } else {
      genderImageMale = false;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: Landscape * 0.059),
        children: [
          Stack(children: [
            Container(
                margin: const EdgeInsets.only(left: 130),
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  border: Border.all(width: 4, color: Colors.white),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.1))
                  ],
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: genderImageMale
                        ? const NetworkImage(
                            'https://cdn.pixabay.com/photo/2017/04/01/21/06/portrait-2194457_960_720.jpg')
                        : const NetworkImage(
                            'https://cdn.pixabay.com/photo/2018/01/29/17/01/woman-3116587_960_720.jpg'),
                  ),
                )),

            // Image(
            //   image: AssetImage('images/Logo.png'),
            //   height: Landscape * 0.0594,
            //   width: portrait * 0.0138,
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Stack(children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: Landscape * 0.164, left: 10, right: 10),
                  child: AppTextField(
                    hintText: 'Name',
                    prefixIcon: const Icon(
                      Icons.person,
                      color: const Color(0xFF222B45),
                    ),
                    color: const Color(0xFFF7F7F7),
                    controller: _fullNAmeTextController,
                  ),
                ),
                Container(
                  width: Portrait * 0.893,
                  height: Landscape * 0.064,
                  decoration: BoxDecoration(
                      color: const Color(0xFFF7F7F7),
                      borderRadius: BorderRadius.circular(16)),
                  margin: EdgeInsets.only(
                      top: Landscape * 0.27, left: 10, right: 10),
                  child: Padding(
                    padding: EdgeInsets.only(left: Portrait * 0.12),
                    child: FutureBuilder<List<City>>(
                        future: _city,
                        builder: (context, snapshot) {
                          Cities = snapshot.data ?? [];
                          return DropdownButton<int>(
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
                            items: Cities.map(
                              (e) => DropdownMenuItem(
                                child: Text(e.nameEn),
                                value: e.id,
                              ),
                            ).toList(),
                          );
                        }),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: Landscape * 0.29, left: Portrait * 0.05),
                  child: const Icon(
                    Icons.location_city,
                    color: Color(0xFF222B45),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: Landscape * 0.374),
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
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: Landscape * 0.504, left: 80, right: 10),
                    child: Container(
                      width: Portrait * 0.603,
                      height: Landscape * 0.064,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4E55AF),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          await _performEditInformation();
                        },
                        child: const Text('Save edits'),
                      ),
                    ),
                  ),
                ),
                Container(
                    width: 135,
                    margin: EdgeInsets.only(top: Landscape * 0.664),
                    child: const Divider(color: Colors.grey)),
                Padding(
                  padding: EdgeInsets.only(top: Landscape * 0.66, left: 135),
                  child: const Text(
                    'change password',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Container(
                    width: 135,
                    margin: EdgeInsets.only(top: Landscape * 0.664, left: 260),
                    child: const Divider(
                      color: Colors.grey,
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      top: Landscape * 0.70, left: 10, right: 10),
                  child: AppTextFieldP(
                      controller: _passwordTextController,
                      obscureText: _obscureText,
                      hintText: 'current Password',
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: const Color(0xFF222B45),
                      ),
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
                Padding(
                  padding: EdgeInsets.only(
                      top: Landscape * 0.80, left: 10, right: 10),
                  child: AppTextFieldP(
                      controller: _newPasswordTextController,
                      obscureText: _obscureTextNew,
                      hintText: 'New Password',
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: const Color(0xFF222B45),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureTextNew = !_obscureTextNew;
                          });
                        },
                        icon: Icon(_obscureTextNew
                            ? Icons.visibility
                            : Icons.visibility_off),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: Landscape * 0.90, left: 10, right: 10),
                  child: AppTextFieldP(
                      controller: _confirmPassword,
                      obscureText: _obscureTextConfirm,
                      hintText: 'Password',
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Color(0xFF222B45),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureTextConfirm = !_obscureTextConfirm;
                          });
                        },
                        icon: Icon(_obscureTextConfirm
                            ? Icons.visibility
                            : Icons.visibility_off),
                      )),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: Landscape * 1.004, left: 80, right: 10),
                    child: Container(
                      width: Portrait * 0.603,
                      height: Landscape * 0.064,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4E55AF),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextButton(
                        //       child: const Text('LOGIN'),
                        //       style: ElevatedButton.styleFrom(
                        //         minimumSize: const Size(500,56),
                        onPressed: () async => _performChangePassword(),
                        child: const Text('Save edits'),
                      ),
                    ),
                  ),
                ),
              ]),
            )
          ]),
        ],
      ),
    );
  }

  Future<bool> _performEditInformation() async {
    if (_checkData()) {
      editInformationProfile();
      return true;
    } else {
      return false;
    }
  }

  bool _checkData() {
    if (_fullNAmeTextController.text.isNotEmpty && selectedCity != null) {
      return true;
    }
    //TODO: SHOW SNACK BAR
    showSnackBar(
      context: context,
      message: 'Enter required data to name or city',
      error: true,
    );
    return false;
  }

  Future<void> editInformationProfile() async {
    //await AuthApiController().FcmToken(context);
    await AuthApiController().updateInformation(context, userStore: userStores);
    await AuthApiController().login(context,
        mobile: SharedPrefController().phon,
        passwor: SharedPrefController().password);
  }

  // if (statas) {
  //   Future.delayed(const Duration(seconds: 5), () {
  //     Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => ActivationCode(
  //                   mobile: _phonTextController.text,
  //                 )));
  //   });
  // }

  UserStore get userStores {
    UserStore userstore = UserStore();
    userstore.token = SharedPrefController().token;
    userstore.name = _fullNAmeTextController.text;
    userstore.cityId = Cities[selectedCity! - 1].id.toString();
    // print('kokokokok'+Cities[selectedCity!-1].id.toString());
    userstore.gender = _gender!;
    userstore.id = SharedPrefController().id;
    userstore.fcmToken = randomString(20).toString();
    userstore.mobile = SharedPrefController().phon;
    SharedPrefController()
        .saveUserStore(userstore: userstore, password: SharedPrefController().password);
    return userstore;
  }

  Future<bool> _performChangePassword() async {
    if (_checkPassword()) {
      changePassword();
      return true;
    } else {
      return false;
    }
  }

  bool _checkPassword() {
    if (_passwordTextController.text.isNotEmpty &&
        _newPasswordTextController.text.isNotEmpty &&
        _confirmPassword.text.isNotEmpty) {
      return true;
    }
    //TODO: SHOW SNACK BAR
    showSnackBar(
      context: context,
      message: 'Enter required data to name or city',
      error: true,
    );
    return false;
  }

  Future<void> changePassword() async {
    //await AuthApiController().FcmToken(context);
    await AuthApiController()
        .passwordChange(context, passwordChange: passwordChange);
    await AuthApiController().login(context,
        mobile: SharedPrefController().phon,
        passwor: _newPasswordTextController.text);
  }

  PasswordChange get passwordChange {
    PasswordChange passwordChange = PasswordChange();
    passwordChange.password = _passwordTextController.text;
    passwordChange.NewPAssword = _newPasswordTextController.text;
    passwordChange.ConfirmPAssword = _confirmPassword.text;
    return passwordChange;
  }
}
