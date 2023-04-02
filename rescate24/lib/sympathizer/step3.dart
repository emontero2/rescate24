import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rescate24/components/my_text_field.dart';

class Step3 extends StatelessWidget {
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
          MyTextField(
              controller: provinceController, hintText: "", obscureText: false),
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
              controller: MunicipeController, hintText: "", obscureText: false),
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
              controller: sectorController, hintText: "", obscureText: false),
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
              controller: phoneNumberResidenceController,
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
              controller: phoneNumberController,
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
              controller: emailController, hintText: "", obscureText: false),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
