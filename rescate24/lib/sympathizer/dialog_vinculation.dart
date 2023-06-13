import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rescate24/components/my_button.dart';

import '../components/my_data_info.dart';

class DialogVinculation extends StatelessWidget {
  const DialogVinculation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Datos del militante y/o simpatizante"),
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage("lib/images/profile_pic.jpeg"),
        ),
        MyDataInfo(title: "Cedula: ", description: "0010212121"),
        SizedBox(
          height: 3,
        ),
        MyDataInfo(title: "Nombre: ", description: "Peter"),
        SizedBox(
          height: 3,
        ),
        MyDataInfo(title: "Apellido: ", description: "Gonzales"),
        SizedBox(
          height: 3,
        ),
        MyDataInfo(title: "Genero: ", description: "M"),
        SizedBox(
          height: 3,
        ),
        MyDataInfo(title: "Nacimiento: ", description: "10/10/2010"),
        SizedBox(
          height: 3,
        ),
        MyDataInfo(title: "Estructura: ", description: "1"),
        SizedBox(
          height: 10,
        ),
        MyButton(title: "Vincular")
      ],
    );
  }
}
