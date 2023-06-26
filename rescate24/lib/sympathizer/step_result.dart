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
      required this.birthDay,
      required this.province,
      required this.sector,
      required this.municipality,
      required this.direction})
      : super(key: key);
  final String name;
  final Uint8List? doc_image;
  final String docNumber;
  final String genre;
  final String birthDay;
  final String province;
  final String sector;
  final String municipality;
  final String direction;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(left: 10, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Informacion del simpatizante",
              style: TextStyle(
                  color: Color(0xFF292929),
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 50,
                  child: doc_image != null
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
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyDataInfo(title: "Cedula: ", description: docNumber),
                    const SizedBox(
                      height: 5,
                    ),
                    MyDataInfo(title: "Nombre: ", description: name),
                    const SizedBox(
                      height: 5,
                    ),
                    MyDataInfo(title: "Genero: ", description: genre),
                    const SizedBox(
                      height: 5,
                    ),
                    MyDataInfo(title: "Nacimiento: ", description: birthDay)
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text(
                  "Direccion",
                  style: TextStyle(
                      color: Color(0xFF292929),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                      child: const Divider(
                        color: Colors.black,
                        height: 36,
                      )),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyDataInfo(title: "Provincia", description: province),
                const SizedBox(
                  height: 5,
                ),
                MyDataInfo(title: "Municipio", description: municipality),
                const SizedBox(
                  height: 5,
                ),
                MyDataInfo(title: "Sector", description: sector),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text(
                  "Lugar de Votacion",
                  style: TextStyle(
                      color: Color(0xFF292929),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                      child: const Divider(
                        color: Colors.black,
                        height: 36,
                      )),
                )
              ],
            ),
            MyDataInfo(title: "Provincia", description: province),
            const SizedBox(
              height: 5,
            ),
            MyDataInfo(title: "Municipio", description: municipality),
            const SizedBox(
              height: 5,
            ),
            MyDataInfo(title: "Recinto", description: direction),
          ],
        ),
      ),
    );
  }
}
