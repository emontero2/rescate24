import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  NewsCard(
      {Key? key,
      required this.hasBorder,
      required this.image,
      required this.title,
      required this.date})
      : super(key: key);
  final String image;
  final String title;
  final String date;
  final bool hasBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: hasBorder ? const EdgeInsets.all(10) : EdgeInsets.zero,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: Colors.white,
            border: hasBorder ? Border.all(color: Colors.grey.shade400) : null),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.network(
              image,
              width: 100,
              height: 100,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxWidth: 180, minWidth: 180),
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(date)
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            )
          ],
        ));
  }
}
