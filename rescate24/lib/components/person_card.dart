import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rescate24/models/Person.dart';

import 'my_data_info.dart';

class PersonCard extends StatelessWidget {
  PersonCard({Key? key, required this.person, this.onTap}) : super(key: key);
  final Person person;
  Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyDataInfo(title: "Cedula: ", description: person.docNumber),
                MyDataInfo(title: "Nombre:", description: person.name),
                MyDataInfo(title: "Genero:", description: person.gnere),
                MyDataInfo(title: "Nacimiento: ", description: person.birthDay),
                if (person.liveness == false)
                  ElevatedButton.icon(
                    icon: Icon(
                      Icons.autorenew,
                      color: Colors.green,
                    ),
                    onPressed: onTap,
                    label: Text(
                      "Prueba de vida",
                      style: TextStyle(color: Colors.green),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      side: BorderSide(color: Colors.green),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 30,
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Color(0xFFDDDDDD)),
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: SvgPicture.asset(
                "lib/images/whatsapp.svg",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
