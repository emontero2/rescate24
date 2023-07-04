import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Step2 extends StatelessWidget {
  const Step2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        const Text(
          "Capturar fotografia de la parte frontal de la cedula",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(
          height: 5,
        ),
        Image.asset("lib/images/card_front.png"),
        const Text(
          "Realice la captura de la fotografía en un lugar iluminado.​​",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Coloque la cédula en una superficie plana.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        )
      ],
    );
    ;
  }
}
