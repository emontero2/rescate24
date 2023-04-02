import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rescate24/components/my_data_info.dart';

class StepResult extends StatelessWidget {
  const StepResult(
      {Key? key, required this.name, required this.last_name, this.doc_image})
      : super(key: key);
  final String name;
  final String last_name;
  final Uint8List? doc_image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Informacion del simpatizante",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            doc_image != null
                ? Image.memory(doc_image!)
                : Image.asset("lib/images/portrait.png"),
            Column(
              children: [
                MyDataInfo(title: "Cedula", description: "001-121232"),
                MyDataInfo(title: "Nombre", description: name),
                MyDataInfo(title: "Apellidos", description: last_name),
                MyDataInfo(title: "Genero", description: "Masculino"),
                MyDataInfo(title: "Nacimiento", description: "10/10/2010")
              ],
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Direccion",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        MyDataInfo(title: "Provincia", description: "Santo Domingo"),
        MyDataInfo(title: "Municipio", description: "Distrito Nacional"),
        MyDataInfo(title: "Direccion", description: "Las caobas"),
        SizedBox(
          height: 20,
        ),
        Text(
          "Lugar de Votacion",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        MyDataInfo(title: "Provincia", description: "Santo Domingo"),
        MyDataInfo(title: "Municipio", description: "Distrito Nacional"),
        MyDataInfo(title: "Recinto", description: "Las caobas"),
        MyDataInfo(title: "Colegio", description: "Las caobas high school")
      ],
    );
  }
}
