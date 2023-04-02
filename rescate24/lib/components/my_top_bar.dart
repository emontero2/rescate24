import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyTopBar extends AppBar {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: SvgPicture.asset("lib/images/R24logo1.svg"),
      backgroundColor: Colors.purple,
      actions: [
        SvgPicture.asset("lib/images/notifications_icon.svg"),
        Text("|"),
        const Text(
          "Bienvenido \n Stalin Rivas",
          style: TextStyle(color: Colors.white),
        ),
        SvgPicture.asset("lib/images/user_icon.svg")
      ],
    );
  }
}
