import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDataInfo extends StatelessWidget {
  final String title;
  final String description;
  final double? maxWidth;
  const MyDataInfo(
      {Key? key, required this.title, required this.description, this.maxWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 5,
        ),
        ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth ?? 100),
            child: Text(description))
      ],
    );
  }
}
