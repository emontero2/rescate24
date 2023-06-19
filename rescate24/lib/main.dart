import 'package:flutter/material.dart';
import 'package:rescate24/dashboard/Dashboard.dart';
import 'package:rescate24/home/home.dart';
import 'package:rescate24/login/login.dart';
import 'package:rescate24/news/news_screen.dart';
import 'package:rescate24/sympathizer/add_sympathizer_page.dart';
import 'package:rescate24/sympathizer/register_asistant.dart';
import 'package:provider/provider.dart';
import 'package:rescate24/user/user_screen.dart';

import 'models/PersonModel.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => PersonModel(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      showSemanticsDebugger: false,
      showPerformanceOverlay: false,
      initialRoute: '/login',
      routes: {
        '/home': (context) => Home(),
        '/login': (context) => LoginPage(),
        '/dashboard': (context) => const Dashboard(
              isDatabaseReady: false,
            ),
        '/add_sympathizer': (context) => AddSympathizerPage(),
        '/register_assitant': (context) => RegisterAsistant(
              key: UniqueKey(),
            ),
        '/news_screen': (context) => const NewsScreen(),
        '/user': (context) => const UserScreen()
      },
    );
  }
}
