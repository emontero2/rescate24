import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String title;
  final bool? isGrey;

  const MyButton({super.key, required this.title, this.isGrey});
  @override
  Widget build(Object context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
          color: isGrey == null ? Color(0xFF5F0069) : Color(0xFFD3D3D3),
          borderRadius: BorderRadius.circular(8)),
      child: Center(
          child: Text(
        title,
        style: TextStyle(
            color: isGrey == null ? Color(0xFFFCDE0A) : Color(0xFF707070),
            fontSize: 22),
      )),
    );
  }
}
