import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String desc;
  final Color? color;
  const IconText(
      {Key? key,
      required this.iconData,
      required this.title,
      required this.desc,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: color,
        ),
        SizedBox(
          width: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            Text(
              desc,
              style: TextStyle(color: Colors.black),
            )
          ],
        )
      ],
    );
  }
}
