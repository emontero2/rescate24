import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rescate24/components/my_bottom_bar.dart';
import 'package:rescate24/components/my_icon_button.dart';
import 'package:rescate24/components/my_top_bar.dart';
import 'package:rescate24/components/person_card.dart';
import 'package:rescate24/models/PersonModel.dart';

class Dashboard extends StatelessWidget {
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
          const Text("|"),
          const Text(
            "Bienvenido \n Stalin Rivas",
            style: TextStyle(color: Colors.white),
          ),
          SvgPicture.asset("lib/images/user_icon.svg")
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Dashboard",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 22),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/add_sympathizer'),
                child: const MyIconButton(title: "Agregar Simpatizante")),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade400)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "0",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text("Simpatizantes relacionados registrados")
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "0",
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                            "Cantidad de simpatizantes regulares \n faltantes por registrar")
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "0",
                          style: TextStyle(
                              color: Colors.purple,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                            "Total de simpatizantes registrados en su \n estructura")
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade400)),
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text(
                      "Simpatizantes",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Consumer<PersonModel>(
                        builder: (context, personModel, child) =>
                            personModel.person.isNotEmpty
                                ? Stack(
                                    children: personModel.person
                                        .map((e) => PersonCard(person: e))
                                        .toList(),
                                  )
                                : const Text(
                                    "No hay personas afiliadas actualmente"))
                  ],
                ))
          ],
        ),
      ),
      bottomNavigationBar: const MyBottomBar(),
    );
  }
}
