import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rescate24/components/icon_text.dart';
import 'package:rescate24/components/my_back_button.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 150,
            width: double.maxFinite,
            child: Container(
              color: const Color(0xFF5F0069),
              child: Column(
                children: [
                  const MyBackButton(
                    title: "Mi perfil",
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage("lib/images/profile_pic.jpeg"),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Stalin Rivas",
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                          const Text(
                            "Registrado desde el 2022",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.all(25),
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 1,
                  spreadRadius: 1,
                  offset: Offset(4, 8), // Shadow position
                ),
              ],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Datos",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const IconText(
                      iconData: Icons.phone,
                      title: "Mobile",
                      desc: "809-972-8707",
                      color: Colors.green,
                    ),
                    const IconText(
                      iconData: Icons.whatshot,
                      title: "Whatsapp",
                      desc: "809-972-8707",
                      color: Colors.green,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const IconText(
                      iconData: Icons.email,
                      title: "Email",
                      desc: "Sin recuperar",
                      color: Colors.grey,
                    ),
                    const IconText(
                      iconData: Icons.assignment,
                      title: "Cedula",
                      desc: "809-972-8707",
                      color: Colors.green,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const IconText(
                  iconData: Icons.location_on,
                  title: "Direccion",
                  desc: "Sin recuperar",
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
              margin: const EdgeInsets.all(25),
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: Offset(4, 8), // Shadow position
                  ),
                ],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        "Tipo: ",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const Text("Militante")
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Responsabilidad: ",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const Text("Simpatazante")
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Estado: ",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const Text("Validado")
                    ],
                  )
                ],
              )),
          const SizedBox(
            height: 10,
          ),
          Container(
              margin: const EdgeInsets.all(25),
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: Offset(4, 8), // Shadow position
                  ),
                ],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text(
                        "Codigo localizador",
                        style: TextStyle(fontSize: 22),
                      ),
                      const Text(
                        "AXYVZ",
                        style:
                            TextStyle(color: Color(0xFF5F0069), fontSize: 32),
                      ),
                      RichText(
                          text: const TextSpan(children: [
                        WidgetSpan(child: Icon(Icons.ios_share)),
                        TextSpan(
                            text: "Compartir",
                            style: TextStyle(color: Colors.black))
                      ]))
                    ],
                  ),
                  const Icon(
                    Icons.qr_code,
                    size: 80,
                  )
                ],
              ))
        ],
      ),
    );
  }
}
