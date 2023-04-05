import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyTopBar extends AppBar {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(120),
      child: Container(
        color: Colors.purple,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset("lib/images/R24logo1.svg"),
            Row(
              children: [
                SvgPicture.asset("lib/images/notifications_icon.svg"),
                Text("|"),
                const Text(
                  "Bienvenido \n Stalin Rivas",
                  style: TextStyle(color: Colors.white),
                ),
                SvgPicture.asset("lib/images/user_icon.svg")
              ],
            )
          ],
        ),
      ),
    );
  }
}
