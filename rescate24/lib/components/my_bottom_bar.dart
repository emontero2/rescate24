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
              color: Color(0xFF5F0069),
            ),
            label: "Inicio"),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "lib/images/calendar_icon.svg",
              color: Color(0xFF5F0069),
            ),
            label: "Actividades"),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "lib/images/news_icon.svg",
              color: Color(0xFF5F0069),
            ),
            label: "Noticias"),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "lib/images/group_icon.svg",
              color: Color(0xFF5F0069),
            ),
            label: "Dirigentes")
      ],
      unselectedItemColor: Color(0xFF5F0069),
      selectedItemColor: Color(0xFF5F0069),
      showUnselectedLabels: true,
    );
  }
}
