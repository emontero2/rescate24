import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rescate24/components/my_bottom_bar.dart';
import 'package:rescate24/components/my_icon_button.dart';
import 'package:rescate24/components/my_top_bar.dart';

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
          Text("|"),
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
            SizedBox(
              height: 10,
            ),
            const Text(
              "Dashboard",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 22),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/add_sympathizer'),
                child: MyIconButton(title: "Agregar Simpatizante")),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade400)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "0",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Simpatizantes relacionados registrados")
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "0",
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                            "Cantidad de simpatizantes regulares \n faltantes por registrar")
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "0",
                          style: TextStyle(
                              color: Colors.purple,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                            "Total de simpatizantes registrados en su \n estructura")
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade400)),
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Text(
                    "Simpatizantes",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ))
          ],
        ),
      ),
      bottomNavigationBar: MyBottomBar(),
    );
  }
}
