import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rescate24/components/my_data_info.dart';

class StepResult extends StatelessWidget {
  const StepResult(
      {Key? key,
      required this.name,
      this.doc_image,
      required this.docNumber,
      required this.genre,
      required this.birthDay})
      : super(key: key);
  final String name;
  final Uint8List? doc_image;
  final String docNumber;
  final String genre;
  final String birthDay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Informacion del simpatizante",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            doc_image != null
                ? Image.memory(
                    doc_image!,
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
                MyDataInfo(title: "Cedula: ", description: docNumber),
                MyDataInfo(title: "Nombre: ", description: name),
                MyDataInfo(title: "Genero: ", description: genre),
                MyDataInfo(title: "Nacimiento: ", description: birthDay)
              ],
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Direccion",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        const MyDataInfo(title: "Provincia", description: "Santo Domingo"),
        const MyDataInfo(title: "Municipio", description: "Distrito Nacional"),
        const MyDataInfo(title: "Direccion", description: "Las caobas"),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Lugar de Votacion",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        const MyDataInfo(title: "Provincia", description: "Santo Domingo"),
        const MyDataInfo(title: "Municipio", description: "Distrito Nacional"),
        const MyDataInfo(title: "Recinto", description: "Las caobas"),
        const MyDataInfo(
            title: "Colegio", description: "Las caobas high school")
      ],
    );
  }
}
