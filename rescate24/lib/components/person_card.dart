import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rescate24/models/Person.dart';

import 'my_data_info.dart';

class PersonCard extends StatelessWidget {
  const PersonCard({Key? key, required this.person}) : super(key: key);
  final Person person;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            person.portrait != null
                ? Image.memory(
                    person.portrait!,
                    width: 100,
                    height: 100,
                  )
                : Image.asset(
                    "lib/images/portrait.png",
                    width: 100,
                    height: 100,
                  ),
            Column(
              children: [
                MyDataInfo(title: "Cedula: ", description: person.docNumber),
                MyDataInfo(title: "Nombre:", description: person.name),
                MyDataInfo(title: "Genero:", description: person.gnere),
                MyDataInfo(title: "Nacimiento: ", description: person.birthDay)
              ],
            )
          ],
        ),
      ),
    );
  }
}
