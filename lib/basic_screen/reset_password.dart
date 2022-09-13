import 'package:flutter/material.dart';
import 'package:smartsstors/widget/app_text_field Name.dart';
import 'package:smartsstors/widget/app_text_field Password.dart';
import '../api_controller/auth_api_controller.dart';
import '../widget/app_code_text_field.dart';
import 'package:smartsstors/widget/app_code_text_field.dart';
import 'package:smartsstors/widget/app_text_field Password.dart';
import 'helpers.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key, required this.mobile}) : super(key: key);

  final String mobile;

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with Helpers {
  late TextEditingController _firstCodeTextController;
  late TextEditingController _secondCodeTextController;
  late TextEditingController _thirdCodeTextController;
  late TextEditingController _fourthCodeTextController;

  late FocusNode _firstCodeFocusNode;
  late FocusNode _secondCodeFocusNode;
  late FocusNode _thirdCodeFocusNode;
  late FocusNode _fourthCodeFocusNode;

  late TextEditingController _newPasswordTextController;
  late TextEditingController _newPasswordConfirmationTextController;
  bool obscureTextPassword = true;
  bool obscureTextConfirmPassword = true;
  String _code = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firstCodeTextController = TextEditingController();
    _secondCodeTextController = TextEditingController();
    _thirdCodeTextController = TextEditingController();
    _fourthCodeTextController = TextEditingController();

    _firstCodeFocusNode = FocusNode();
    _secondCodeFocusNode = FocusNode();
    _thirdCodeFocusNode = FocusNode();
    _fourthCodeFocusNode = FocusNode();

    _newPasswordTextController = TextEditingController();
    _newPasswordConfirmationTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _firstCodeTextController.dispose();
    _secondCodeTextController.dispose();
    _thirdCodeTextController.dispose();
    _fourthCodeTextController.dispose();
    _firstCodeFocusNode.dispose();
    _secondCodeFocusNode.dispose();
    _thirdCodeFocusNode.dispose();
    _fourthCodeFocusNode.dispose();

    _newPasswordTextController.dispose();
    _newPasswordConfirmationTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double landscape = MediaQuery.of(context).size.height;
    double portrait = MediaQuery.of(context).size.width;
    double textscal = MediaQuery.of(context).textScaleFactor;
    double Landscape = landscape;
    double Portrait = portrait;
    return Scaffold(
        body: ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
                horizontal: 20, vertical: Landscape * 0.036),
            children: [
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.only(right: Portrait * 0.042),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              const Text(
                'Reset Password',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ]),
          ),
          Padding(
            padding: EdgeInsets.only(top: Landscape * 0.017),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: Landscape * 0.04, left: 10),
                  child: const Text(
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
                  child: const Text(
                    'Enter receive Code & new password... ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                //Padding(
                //  padding: EdgeInsets.only(top: Landscape * 0.18, left: 10),
                Padding(
                  padding: EdgeInsets.only(
                      top: Landscape * 0.170, left: portrait * 0.30),
                  child: Image.asset('images/Logo.png',
                      width: portrait * 0.290,
                      height: Landscape * 0.108,
                      fit: BoxFit.fill),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Landscape * 0.290),
                  child: Row(
                    children: [
                      Expanded(
                        child: AppCodeTextField(
                          focusNode: _firstCodeFocusNode,
                          controller: _firstCodeTextController,
                          onChanged: (String value) {
                            if (value.isNotEmpty) {
                              _secondCodeFocusNode.requestFocus();
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: AppCodeTextField(
                          focusNode: _secondCodeFocusNode,
                          controller: _secondCodeTextController,
                          onChanged: (String value) {
                            value.isNotEmpty
                                ? _thirdCodeFocusNode.requestFocus()
                                : _firstCodeFocusNode.requestFocus();
                          },
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: AppCodeTextField(
                          focusNode: _thirdCodeFocusNode,
                          controller: _thirdCodeTextController,
                          onChanged: (String value) {
                            value.isNotEmpty
                                ? _fourthCodeFocusNode.requestFocus()
                                : _secondCodeFocusNode.requestFocus();
                          },
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: AppCodeTextField(
                          focusNode: _fourthCodeFocusNode,
                          controller: _fourthCodeTextController,
                          onChanged: (String value) {
                            if (value.isEmpty) {
                              _thirdCodeFocusNode.requestFocus();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: Landscape * 0.406, left: 10, right: 10),
                  child: AppTextFieldP(
                      obscureText: obscureTextPassword,
                      hintText: 'password',
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Color(0xFF222B45),
                      ),
                      controller: _newPasswordTextController,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureTextPassword = !obscureTextPassword;
                          });
                        },
                        icon: Icon(obscureTextPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                      )),
                ),

                Padding(
                  padding: EdgeInsets.only(
                      top: Landscape * 0.508, left: 10, right: 10),
                  child: AppTextFieldP(
                      obscureText: obscureTextConfirmPassword,
                      hintText: 'confirm password',
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Color(0xFF222B45),
                      ),
                      controller: _newPasswordConfirmationTextController,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureTextConfirmPassword =
                                !obscureTextConfirmPassword;
                          });
                        },
                        icon: Icon(obscureTextConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                      )),
                ),

                Container(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: Landscape * 0.634, left: 10, right: 10),
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
                        onPressed: () {
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
                                    padding:
                                        EdgeInsets.only(top: Landscape * 0.103),
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
                                            child:
                                                Image.asset('images/lock.png')),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: Landscape * 0.23,
                                            left: Portrait * 0.206,
                                            right: Portrait * 0.146),
                                        child: Text(
                                          'Reset Password Success',
                                          style: TextStyle(
                                              fontSize: 18*textscal,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: Landscape * 0.273,
                                            left: Portrait * 0.256,
                                            right: Portrait * 0.146),
                                        child: Text(
                                          'Leading e-commerce market',
                                          style: TextStyle(
                                              fontSize: 13*textscal, color: Colors.grey),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: Landscape * 0.346,
                                            left: 20,
                                            right: 20),
                                        child: Container(
                                          width: Portrait * 0.893,
                                          height: Landscape * 0.064,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF4E55AF),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: TextButton(
                                            //       child: const Text('LOGIN'),
                                            //       style: ElevatedButton.styleFrom(
                                            //         minimumSize: const Size(500,56),
                                            onPressed: () async =>
                                                await _performResetPassword(),
                                            child: Text('login'),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                );
                              });
                        },
                        child: Text('login'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]));
  }

  Future<void> _performResetPassword() async {
    if (_checkData()) {
      await _resetPassword();
    }
  }

  bool _checkData() {
    if (checkCode() && checkPassword()) {
      return true;
    }

    return false;
  }

  bool checkPassword() {
    if (_newPasswordTextController.text.isNotEmpty &&
        _newPasswordConfirmationTextController.text.isNotEmpty) {
      if (_newPasswordTextController.text ==
          _newPasswordConfirmationTextController.text) {
        return true;
      } else {
        showSnackBar(
          context: context,
          message: 'Password confirmation error',
          error: true,
        );
        return false;
      }
    }
    showSnackBar(
      context: context,
      message: 'Enter password',
      error: true,
    );
    return false;
  }

  bool checkCode() {
    _code = _firstCodeTextController.text +
        _secondCodeTextController.text +
        _thirdCodeTextController.text +
        _fourthCodeTextController.text;

    if (_code.length != 4) {
      showSnackBar(
        context: context,
        message: 'Enter received code 4 digits',
        error: true,
      );
    }
    return _code.length == 4;
  }

  Future<void> _resetPassword() async {
    bool status = await AuthApiController().resetPassword(
      context,
      code: _code,
      email: widget.mobile,
      password: _newPasswordTextController.text,
    );
     if (status) Navigator.pushNamed(context, '/loginscreen');
  }
}
