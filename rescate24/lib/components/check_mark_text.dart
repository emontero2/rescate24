import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CheckMarkText extends StatelessWidget {
  const CheckMarkText({Key? key, required this.icon, required this.description})
      : super(key: key);
  final String icon;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          SvgPicture.asset(icon),
          SizedBox(
            width: 10,
          ),
          Text(
            description,
            style: TextStyle(color: Colors.black, fontSize: 16),
          )
        ],
      ),
    );
  }
}
