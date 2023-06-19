import 'dart:io';
import 'dart:typed_data';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rescate24/components/my_text_field.dart';

class Step3 extends StatefulWidget {
  Step3(
      {Key? key,
      required this.provinceController,
      required this.MunicipeController,
      required this.sectorController,
      required this.phoneNumberResidenceController,
      required this.phoneNumberController,
      required this.emailController})
      : super(key: key);
  final TextEditingController provinceController;
  final TextEditingController MunicipeController;
  final TextEditingController sectorController;
  final TextEditingController phoneNumberResidenceController;
  final TextEditingController phoneNumberController;
  final TextEditingController emailController;

  @override
  State<Step3> createState() => _Step3State();
}

class _Step3State extends State<Step3> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readFile();
  }

  void readFile() async {
    ByteData data = await rootBundle.load("assets/provincias.xlsx");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      print(table); //sheet Name
      print(excel.tables[table]!.maxCols);
      print(excel.tables[table]!.maxRows);
      for (var row in excel.tables[table]!.rows) {
        print('$row');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Direccion",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Provincia:",
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.black),
            ),
          ),
          //DropdownButtonHideUnderline(child: DropdownButton2(items: )),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Municipio:",
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.black),
            ),
          ),
          MyTextField(
              controller: widget.MunicipeController,
              hintText: "",
              obscureText: false),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Sector:",
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.black),
            ),
          ),
          MyTextField(
              controller: widget.sectorController,
              hintText: "",
              obscureText: false),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Informacion de Contacto",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Telefono Residencial:",
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.black),
            ),
          ),
          MyTextField(
              controller: widget.phoneNumberResidenceController,
              hintText: "",
              obscureText: false),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Celular:",
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.black),
            ),
          ),
          MyTextField(
              controller: widget.phoneNumberController,
              hintText: "",
              obscureText: false),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Correo electronico (Email):",
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.black),
            ),
          ),
          MyTextField(
              controller: widget.emailController,
              hintText: "",
              obscureText: false),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
