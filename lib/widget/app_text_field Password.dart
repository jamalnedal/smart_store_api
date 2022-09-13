import 'package:flutter/material.dart';

class AppTextFieldP extends StatelessWidget {
  const AppTextFieldP({
    Key? key,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
     this.obscureText=true,
    this.textInputType = TextInputType.text, required this.suffixIcon,
  }) : super(key: key);

  final TextInputType textInputType;
  final TextEditingController controller;
  final String hintText;
  final Icon prefixIcon;
  final bool obscureText;
  final IconButton suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: textInputType,
      obscureText: obscureText,
      decoration: InputDecoration(
          filled: true,
          fillColor:Color(0xFFF7F7F7),
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon:suffixIcon ,
          enabledBorder: buildOutlineInputBorder(),
          focusedBorder: buildOutlineInputBorder(borderColor: Color(0xFF4E55AF))
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
