import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyBackButton extends StatelessWidget {
  final String title;
  final Color? color;
  final bool? hasBottomDivider;
  const MyBackButton(
      {Key? key, required this.title, this.color, this.hasBottomDivider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            border: Border(
                bottom: hasBottomDivider == false
                    ? BorderSide.none
                    : BorderSide(color: Colors.grey.shade300, width: 2))),
        child: Row(
          children: [
            SvgPicture.asset(
              "lib/images/left_icon.svg",
              color: color,
            ),
            const SizedBox(
              width: 10,
            ),
            Flex(direction: Axis.horizontal, children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: color ?? Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ])
          ],
        ),
      ),
    );
  }
}
