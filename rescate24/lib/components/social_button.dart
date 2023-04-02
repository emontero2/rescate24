import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String title;
  final Color? buttonColor;
  final String icon;

  const SocialButton(
      {super.key, required this.title, this.buttonColor, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
          color: buttonColor, borderRadius: BorderRadius.circular(8)),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            width: 30.0,
            height: 30.0,
          ),
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 16),
          )
        ],
      )),
    );
  }
}
