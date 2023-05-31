import 'package:flutter/cupertino.dart';
import 'package:rescate24/components/calendar_card.dart';
import 'package:rescate24/models/Activities.dart';

import '../components/filter_chips.dart';
import '../components/my_back_button.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Activities> activities = Activities.generateActivities();
    return Column(
      children: [
        const MyBackButton(
          title: "Noticias",
        ),
        const FilterChips(
            labels: ["Todas", "Futuras", "Pasadas", "2023", "Nuevas"]),
        SizedBox(
          height: 400,
          child: ListView.builder(
              itemCount: activities.length,
              itemBuilder: (context, index) {
                return CalendarCard(
                    title: activities[index].title,
                    date: activities[index].date,
                    month: activities[index].month,
                    day: activities[index].day);
              }),
        )
      ],
    );
  }
}
