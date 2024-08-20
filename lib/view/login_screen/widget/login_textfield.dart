import 'package:flutter/material.dart';
import 'package:totodo/utils/color_constants.dart';

class LoginTextfield extends StatelessWidget {
  LoginTextfield({
    super.key,
    required this.hintText,
    required this.icon,
    this.suffixIcon,
    this.controller,
    obscureText,
    this.validation,
  });
  final controller;
  final String hintText;

  final IconData icon;
  final bool obscureText = false;
  final Widget? suffixIcon;
  final String? Function(String?)? validation;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validation,
      style: TextStyle(color: ColorConstants.LetterWhite),
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: ColorConstants.LetterWhite),
        prefixIcon: Icon(icon, color: ColorConstants.buttonviolet),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: ColorConstants.buttonviolet),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: ColorConstants.LetterWhite, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: ColorConstants.buttonviolet),
        ),
      ),
    );
  }
}
