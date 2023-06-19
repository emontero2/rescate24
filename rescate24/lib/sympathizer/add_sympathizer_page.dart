import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rescate24/components/my_back_button.dart';
import 'package:rescate24/components/my_bottom_bar.dart';
import 'package:rescate24/components/my_button.dart';
import 'package:rescate24/components/my_icon_button.dart';
import 'package:rescate24/components/my_text_field.dart';
import 'package:rescate24/sympathizer/dialog_vinculation.dart';
import 'package:rescate24/sympathizer/register_asistant.dart';

class AddSympathizerPage extends StatelessWidget {
  AddSympathizerPage({Key? key}) : super(key: key);

  final cedulaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Future<void> _showSimpleDialog() async {
      await showDialog<void>(
        context: context,
        builder: (context) => DialogVinculation(),
      );
    }

    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SvgPicture.asset("lib/images/R24logo1.svg"),
          ),
          backgroundColor: const Color(0xFF560265),
          actions: [
            SvgPicture.asset(
              "lib/images/notifications_icon.svg",
              color: Colors.white,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: VerticalDivider(
                color: Colors.white,
                thickness: 2,
              ),
            ),
            const Center(
              child: Text(
                "Bienvenid@ \nDiana Rivas",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const CircleAvatar(
              backgroundImage: AssetImage("lib/images/profile_pic.jpeg"),
            )
          ],
        ),
        body: Column(
          children: [
            const MyBackButton(
              title: "Registro y Validacion de Militante y/o Simpatizante",
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Localizador de Simpatizante Registrado",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: MyTextField(
                      controller: cedulaController,
                      hintText: "Ingrese el numero del localizador",
                      obscureText: false),
                ),
                IconButton(
                    onPressed: () => {_showSimpleDialog()},
                    icon: const Icon(Icons.camera_alt))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const MyButton(title: "Buscar"),
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Inicia Asistente de registro \n de nuevo simpatizante",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/register_assitant');
                },
                child: const MyIconButton(title: "Asistente de Registro")),
            const SizedBox(
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
        ));
  }
}
