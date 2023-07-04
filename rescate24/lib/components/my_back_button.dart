import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyBackButton extends StatelessWidget {
  final String title;
  final Color? color;
  final bool? hasBottomDivider;
  final bool? isCentered;
  const MyBackButton(
      {Key? key,
      required this.title,
      this.color,
      this.hasBottomDivider,
      this.isCentered})
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
            if (isCentered == true) Spacer(),
            Text(
              title,
              textAlign:
                  isCentered == true ? TextAlign.center : TextAlign.start,
              style: TextStyle(
                  color: color ?? Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
            if (isCentered == true) Spacer()
          ],
        ),
      ),
    );
  }
}
