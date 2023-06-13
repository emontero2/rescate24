import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rescate24/components/my_back_button.dart';
import 'package:rescate24/components/my_text_field.dart';
import 'package:rescate24/components/person_card.dart';

import '../models/Person.dart';

class LeadersScreen extends StatelessWidget {
  LeadersScreen({Key? key}) : super(key: key);
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Person> persons = Person.generatePerson();
    return Column(
      children: [
        const MyBackButton(title: "Listado de simpatizantes"),
        Container(
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTabController(
                    length: 2,
                    child: Container(
                      child: TabBar(labelColor: Colors.black, tabs: [
                        Tab(
                          text: "Simpatizantes (0)",
                        ),
                        Tab(
                          text: "Dirigentes (0)",
                        )
                      ]),
                    )),
                Row(
                  children: [
                    Flexible(
                      child: MyTextField(
                        controller: controller,
                        hintText: "buscar",
                        obscureText: false,
                      ),
                    ),
                    const IconButton(onPressed: null, icon: Icon(Icons.tune)),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
                SizedBox(
                    height: 500,
                    child: ListView.builder(
                        itemCount: persons.length,
                        itemBuilder: (context, index) {
                          return PersonCard(person: persons[index]);
                        }))
              ],
            )),
      ],
    );
  }
}
