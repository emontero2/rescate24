import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyIconButton extends StatelessWidget {
  final String title;

  const MyIconButton({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
          color: Colors.yellow, borderRadius: BorderRadius.circular(8)),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SvgPicture.asset(
            "lib/images/add_icon.svg",
            width: 30.0,
            height: 30.0,
            color: Colors.black,
          ),
        ],
      )),
    );
  }
}
