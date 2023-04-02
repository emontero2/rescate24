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
          color: isGrey == null ? Colors.purple : Colors.grey,
          borderRadius: BorderRadius.circular(8)),
      child: Center(
          child: Text(
        title,
        style: TextStyle(
            color: isGrey == null ? Colors.orange : Colors.grey.shade400,
            fontSize: 22),
      )),
    );
  }
}
