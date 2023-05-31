import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rescate24/activities/activities_screen.dart';
import 'package:rescate24/dashboard/Dashboard.dart';
import 'package:rescate24/leaders/leaders_screen.dart';
import 'package:rescate24/news/news_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = <Widget>[
    Dashboard(),
    const ActivitiesScreen(),
    const NewsScreen(),
    LeadersScreen(),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SvgPicture.asset("lib/images/R24logo1.svg"),
        ),
        backgroundColor: const Color(0xFF560265),
        actions: [
          SvgPicture.asset(
            "lib/images/notifications_icon.svg",
            color: Colors.white,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: VerticalDivider(
              color: Colors.white,
              thickness: 2,
            ),
          ),
          const Center(
            child: Text(
              "Bienvenid@ \nDiana Rivas",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          const CircleAvatar(
            backgroundImage: AssetImage("lib/images/profile_pic.jpeg"),
          )
        ],
      ),
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
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
        onTap: _onItemTapped,
      ),
    );
  }
}
