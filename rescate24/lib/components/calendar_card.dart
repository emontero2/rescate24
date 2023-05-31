import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalendarCard extends StatelessWidget {
  const CalendarCard({
    Key? key,
    required this.title,
    required this.date,
    required this.month,
    required this.day,
  }) : super(key: key);
  final String month;
  final String day;
  final String title;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade400)),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color(0xFF5F0069)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    month,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    day,
                    style: const TextStyle(color: Colors.white, fontSize: 22),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 10,
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
            const SizedBox(
              width: 70,
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color.fromARGB(255, 232, 229, 229),
            )
          ],
        ));
  }
}
