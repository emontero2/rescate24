import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyBottomBar extends StatelessWidget {
  const MyBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "lib/images/home_icon.svg",
              color: Colors.purple,
            ),
            label: "Inicio"),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "lib/images/calendar_icon.svg",
              color: Colors.purple,
            ),
            label: "Actividades"),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "lib/images/news_icon.svg",
              color: Colors.purple,
            ),
            label: "Noticias"),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "lib/images/group_icon.svg",
              color: Colors.purple,
            ),
            label: "Dirigentes")
      ],
      unselectedItemColor: Colors.purple,
      selectedItemColor: Colors.purple,
      showUnselectedLabels: true,
    );
  }
}
