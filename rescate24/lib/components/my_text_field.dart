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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFDDDDDD))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
            hintText: hintText,
            prefixIcon: startIcon == null
                ? null
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SvgPicture.asset(
                      startIcon ?? "",
                      color: Colors.grey,
                      width: 20,
                      height: 20,
                    ),
                  ),
            prefixIconConstraints:
                const BoxConstraints(minHeight: 20.0, maxHeight: 20.0)),
      ),
    );
  }
}
