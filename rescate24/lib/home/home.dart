import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_document_reader_api/document_reader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
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
  int progrss = 0;
  bool? isDatabaseReady;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
    const EventChannel('flutter_document_reader_api/event/database_progress')
        .receiveBroadcastStream()
        .listen((progress) => setState(() {
              progrss = int.parse(progress);
            }));
  }

  Future<void> initPlatformState() async {
    print("Initializing...");

    ByteData byteData = await rootBundle.load("assets/regula.license");
    print(await DocumentReader.initializeReader({
      "license": base64.encode(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes)),
      "delayedNNLoad": true
    }));
    print("Ready");
    setState(() {
      isDatabaseReady = true;
      _pages[0] = Dashboard(isDatabaseReady: isDatabaseReady!);
    });
    List<List<String>> scenarios = [];
    var scenariosTemp =
        json.decode(await DocumentReader.getAvailableScenarios());
    //print(scenariosTemp);
    for (var i = 0; i < scenariosTemp.length; i++) {
      DocumentReaderScenario scenario = DocumentReaderScenario.fromJson(
          scenariosTemp[i] is String
              ? json.decode(scenariosTemp[i])
              : scenariosTemp[i])!;
      scenarios.add([scenario.name!, scenario.caption!]);
      print(scenariosTemp[i]);
    }
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = <Widget>[
    Dashboard(
      isDatabaseReady: false,
    ),
    ActivitiesScreen(),
    NewsScreen(),
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
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/user'),
            child: const CircleAvatar(
              backgroundImage: AssetImage("lib/images/profile_pic.jpeg"),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (progrss < 100 && isDatabaseReady == null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LinearPercentIndicator(
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  backgroundColor: Colors.grey,
                  progressColor: Colors.blue,
                  lineHeight: 20.0,
                  percent: (progrss / 100).toDouble(),
                  center: Text(
                      "Descargando base de datos, por favor espere. ($progrss%)"),
                ),
              )
            else if ((isDatabaseReady ?? false) == false)
              IconButton(
                  onPressed: () {
                    setState(() {
                      progrss = 0;
                      isDatabaseReady = null;
                    });
                    initPlatformState();
                  },
                  icon: Icon(Icons.autorenew)),
            _pages.elementAt(_selectedIndex)
          ],
        ),
      ),
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
