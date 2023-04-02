import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Step1 extends StatelessWidget {
  const Step1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Validacion Final del Simpatizante",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Realice una captura del rostro del simpatizante, sin anteojos, gorras, mascarillas o sombreros.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Image.asset("lib/images/precaucion.png"),
        const Text(
          "Realice la captura de la fotografia en un lugar iluminado",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
