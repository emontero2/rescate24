import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rescate24/components/my_bottom_bar.dart';
import 'package:rescate24/components/my_icon_button.dart';
import 'package:rescate24/components/my_top_bar.dart';
import 'package:rescate24/components/person_card.dart';
import 'package:rescate24/models/PersonModel.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    int quantityOfAffiliates = context.read<PersonModel>().person.length;
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            quantityOfAffiliates.toString(),
                            style: const TextStyle(
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
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                              "Cantidad de simpatizantes regulares \nfaltantes por registrar")
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                              "Total de simpatizantes registrados en su \nestructura")
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 200, minWidth: 400),
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade400)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          builder: (context, personModel, child) {
                        if (personModel.person.isNotEmpty) {
                          return SizedBox(
                            height: 200,
                            child: ListView.separated(
                                itemCount: personModel.person.length,
                                separatorBuilder: (context, index) =>
                                    const Divider(),
                                itemBuilder: (context, int index) => PersonCard(
                                    person: personModel.person[index])),
                          );
                        } else {
                          return const Text(
                              "No hay personas afiliadas actualmente");
                        }
                      })
                    ],
                  )),
            )
          ],
        ),
      ),
      bottomNavigationBar: const MyBottomBar(),
    );
  }
}
