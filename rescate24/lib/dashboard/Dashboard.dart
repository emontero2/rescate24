import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_document_reader_api/document_reader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rescate24/components/my_bottom_bar.dart';
import 'package:rescate24/components/my_icon_button.dart';
import 'package:rescate24/components/my_top_bar.dart';
import 'package:rescate24/components/news_card.dart';
import 'package:rescate24/components/person_card.dart';
import 'package:rescate24/models/News.dart';
import 'package:rescate24/models/PersonModel.dart';
import 'package:table_calendar/table_calendar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, required this.isDatabaseReady});

  @override
  State<Dashboard> createState() => _DashboardState();
  final bool isDatabaseReady;
}

class _DashboardState extends State<Dashboard> {
  List<News> news = News.generateNews();
  @override
  Widget build(BuildContext context) {
    int quantityOfAffiliates = context.read<PersonModel>().person.length;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Dashboard",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 22),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () => widget.isDatabaseReady
                    ? Navigator.pushNamed(context, '/add_sympathizer')
                    : null,
                child: const MyIconButton(title: "Agregar Simpatizante")),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade400)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            quantityOfAffiliates.toString(),
                            style: const TextStyle(
                                color: Colors.green,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text("Simpatizantes relacionados registrados")
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            (quantityOfAffiliates < 10
                                    ? 10 - quantityOfAffiliates
                                    : 0)
                                .toString(),
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                              "Cantidad de simpatizantes regulares \nfaltantes por registrar")
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "10",
                            style: const TextStyle(
                                color: Colors.purple,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                              "Total de simpatizantes registrados en \nsu estructura")
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 100, minWidth: 400),
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade400)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Calendario de simpatizantes",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      TableCalendar(
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: DateTime.now(),
                        rowHeight: 30.2,
                      ),
                    ],
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 200, minWidth: 400),
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade400)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        "Noticias destacadas",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                            itemCount: news.length,
                            itemBuilder: (context, index) {
                              return NewsCard(
                                  hasBorder: false,
                                  image: news[index].image,
                                  title: news[index].title,
                                  date: news[index].date);
                            }),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
