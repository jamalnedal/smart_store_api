import 'package:flutter/material.dart';

class AppTextFieldSearch extends StatelessWidget {
  const AppTextFieldSearch({
    Key? key,
    required this.hintText,
    required this.prefixIcon,
    this.controller,
    required this.color,
    this.obscureText = false,
    this.textInputType = TextInputType.text,
  }) : super(key: key);

  final TextInputType textInputType;
  final String hintText;
  final Icon prefixIcon;
  final bool obscureText;
  final Color color;
  final TextEditingController? controller;


  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 30.0,
      shadowColor: Color(0xFFF4E55AF),
      child: TextField(
        keyboardType: textInputType,
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
            filled: true,
            fillColor:color,
            hintText: hintText,
            prefixIcon: prefixIcon,
            enabledBorder: buildOutlineInputBorder(),
            focusedBorder: buildOutlineInputBorder(borderColor: Colors.blue)
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder({Color borderColor = const Color(0xFFF7F7F7)}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        width: 1,
        color: borderColor,
      ),
    );
  }
}
