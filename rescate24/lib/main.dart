import 'package:flutter/material.dart';
import 'package:rescate24/dashboard/Dashboard.dart';
import 'package:rescate24/login/login.dart';
import 'package:rescate24/sympathizer/add_sympathizer_page.dart';
import 'package:rescate24/sympathizer/register_asistant.dart';

void main() {
  runApp(const MyApp());
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
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/dashboard': (context) => Dashboard(),
        '/add_sympathizer': (context) => AddSympathizerPage(),
        '/register_assitant': (context) => RegisterAsistant()
      },
    );
  }
}
