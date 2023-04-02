import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rescate24/components/my_back_button.dart';
import 'package:rescate24/components/my_bottom_bar.dart';
import 'package:rescate24/components/my_button.dart';
import 'package:rescate24/components/my_icon_button.dart';
import 'package:rescate24/components/my_text_field.dart';

class AddSympathizerPage extends StatelessWidget {
  AddSympathizerPage({Key? key}) : super(key: key);

  final cedulaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: SvgPicture.asset("lib/images/R24logo1.svg"),
        backgroundColor: Colors.purple,
        actions: [
          SvgPicture.asset(
            "lib/images/notifications_icon.svg",
            color: Colors.white,
          ),
          Text("|"),
          const Text(
            "Bienvenido \n Stalin Rivas",
            style: TextStyle(color: Colors.white),
          ),
          SvgPicture.asset("lib/images/user_icon.svg")
        ],
      ),
      body: Column(
        children: [
          MyBackButton(
            title: "Registro y Validacion de Militante y/o Simpatizante",
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Localizador de Simpatizante Registrado",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          MyTextField(
              controller: cedulaController,
              hintText: "Ingrese el numero del localizador",
              obscureText: false),
          SizedBox(
            height: 10,
          ),
          MyButton(title: "Buscar"),
          SizedBox(
            height: 50,
          ),
          Text(
            "Inicia Asistente de registro \n de nuevo simpatizante",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/register_assitant'),
              child: MyIconButton(title: "Asistente de Registro")),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Debe tener el documento de identidad y electoral del Simpatizante y de ser posible el simpatizante mismo debe estar presente para completar su validacion al 100%",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade400),
            ),
          )
        ],
      ),
      bottomNavigationBar: MyBottomBar(),
    );
  }
}
