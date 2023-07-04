import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rescate24/components/my_text_field.dart';
import 'package:rescate24/sympathizer/register_asistant.dart';

import '../models/Direccion.dart';

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
  List<Direccion> direction = [];

  String? municipeSelected;
  String? provinceSelected;

  @override
  void initState() {
    super.initState();
    readFile();
  }

  void readFile() async {
    ByteData data = await rootBundle.load("assets/provincias.xlsx");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);
    var provinceIndex;
    var municipeIndex;

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        var d = Direccion();
        if (row.any((element) =>
            element?.value?.toString().toUpperCase() ==
            "Provincia".toUpperCase())) {
          Data? data = row.firstWhere((element) =>
              element?.value?.toString().toUpperCase() ==
              "Provincia".toUpperCase());
          provinceIndex = data?.colIndex;
        }
        // email variable is for Name of Column Heading for Email
        if (row.any((element) =>
            element?.value?.toString().toUpperCase() ==
            "Municipio".toUpperCase())) {
          Data? data = row.firstWhere((element) =>
              element?.value?.toString().toUpperCase() ==
              "Municipio".toUpperCase());
          municipeIndex = data?.colIndex;
        }

        if (provinceIndex != null && municipeIndex != null) {
          if (row[provinceIndex]?.value.toString().toUpperCase() !=
              "Provincia".toUpperCase()) {
            setState(() {
              d.province = row[provinceIndex]!.value.toString().toUpperCase();
            });
          }
          if (row[municipeIndex]?.value.toString().toUpperCase() !=
              "Municipio".toUpperCase()) {
            setState(() {
              d.municipe = row[municipeIndex]!.value.toString().toUpperCase();
            });
          }
        }
        direction.add(d);
      }
    }
    if (direction.any((Direccion element) =>
        element.municipe.toUpperCase() ==
        MunicipeController.text.toUpperCase())) {
      var dd = direction.firstWhere((Direccion element) =>
          element.municipe.toUpperCase() ==
          MunicipeController.text.toUpperCase());
      setState(() {
        municipeSelected = MunicipeController.text.toUpperCase();
        provinceSelected = dd.province;
        provinceController.text = dd.province;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Dirección de Residencia",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Provincia:",
              textAlign: TextAlign.start,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                    hint: Text(
                      'Selecciona una provincia',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    value: provinceSelected,
                    onChanged: (value) {
                      provinceController.text = value ?? "";
                      setState(() {
                        provinceSelected = value as String;
                      });
                    },
                    items: direction
                        .map((e) => e.province)
                        .toSet()
                        .map((e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(
                              e,
                              style: const TextStyle(fontSize: 14),
                            )))
                        .toList())),
          ),
          const SizedBox(
            height: 12,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Municipio:",
              textAlign: TextAlign.start,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                    hint: Text(
                      'Selecciona una Municipio',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    value: municipeSelected,
                    onChanged: (value) {
                      MunicipeController.text = value ?? "";
                      setState(() {
                        municipeSelected = value as String;
                      });
                    },
                    items: direction
                        .where((e) => e.province == provinceSelected)
                        .map((e) => e.municipe)
                        .toSet()
                        .map((e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(
                              e!,
                              style: const TextStyle(fontSize: 14),
                            )))
                        .toList())),
          ),
          const SizedBox(
            height: 12,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Sector:",
              textAlign: TextAlign.start,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 35,
            child: MyTextField(
                controller: widget.sectorController,
                hintText: "",
                obscureText: false),
          ),
          const SizedBox(
            height: 12,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Información de Contacto",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Teléfono Residencial:",
              textAlign: TextAlign.start,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 35,
            child: MyTextField(
                controller: widget.phoneNumberResidenceController,
                hintText: "",
                obscureText: false),
          ),
          const SizedBox(
            height: 12,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Celular:",
              textAlign: TextAlign.start,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 35,
            child: MyTextField(
                controller: widget.phoneNumberController,
                hintText: "",
                obscureText: false),
          ),
          const SizedBox(
            height: 12,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Correo electrónico (Email):",
              textAlign: TextAlign.start,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 35,
            child: MyTextField(
                controller: widget.emailController,
                hintText: "",
                obscureText: false),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
