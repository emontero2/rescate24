import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final String? startIcon;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      this.startIcon});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
            hintText: hintText,
            prefixIcon: startIcon == null
                ? null
                : SvgPicture.asset(
                    startIcon ?? "",
                    width: 10.0,
                    height: 10.0,
                    color: Colors.grey,
                  )),
      ),
    );
  }
}
