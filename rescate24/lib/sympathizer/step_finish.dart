import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rescate24/components/check_mark_text.dart';

class StepFinish extends StatelessWidget {
  const StepFinish(
      {Key? key, required this.isLivenessOk, required this.isCaptureDocumentOk})
      : super(key: key);
  final bool isLivenessOk;
  final bool isCaptureDocumentOk;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Proceso Completado!",
          style: TextStyle(
              color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        const SizedBox(
          height: 20,
        ),
        CheckMarkText(
            icon: isCaptureDocumentOk
                ? "lib/images/check_icon.svg"
                : "lib/images/x_mark_icon.svg",
            description:
                "Captura Frontal de documento \nde identidad y extraccion de datos"),
        const SizedBox(
          height: 20,
        ),
        CheckMarkText(
            icon: isCaptureDocumentOk
                ? "lib/images/check_icon.svg"
                : "lib/images/x_mark_icon.svg",
            description:
                "Captura de parte trasera de Documento \nde identidad y extraccion de datos"),
        const SizedBox(
          height: 20,
        ),
        const CheckMarkText(
            icon: "lib/images/check_icon.svg",
            description: "Captura de datos complementario \ny de contacto"),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
