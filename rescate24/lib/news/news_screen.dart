import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rescate24/components/filter_chips.dart';

import '../components/my_back_button.dart';
import '../components/news_card.dart';
import '../models/News.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<News> news = News.generateNews();
    return Column(
      children: [
        MyBackButton(
          title: "Noticias",
        ),
        FilterChips(labels: ["Todas", "Leidas", "No leidas", "2023", "Nuevas"]),
        SizedBox(
          height: 400,
          child: ListView.builder(
              itemCount: news.length,
              itemBuilder: (context, index) {
                return NewsCard(
                    hasBorder: true,
                    image: news[index].image,
                    title: news[index].title,
                    date: news[index].date);
              }),
        )
      ],
    );
  }
}
