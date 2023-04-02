import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyBackButton extends StatelessWidget {
  final String title;
  const MyBackButton({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey, width: 2))),
        child: Row(
          children: [
            SvgPicture.asset("lib/images/left_icon.svg"),
            SizedBox(
              width: 10,
            ),
            Text(
              title,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
