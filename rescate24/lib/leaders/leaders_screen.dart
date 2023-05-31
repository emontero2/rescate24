import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rescate24/components/my_back_button.dart';
import 'package:rescate24/components/my_text_field.dart';

class LeadersScreen extends StatelessWidget {
  LeadersScreen({Key? key}) : super(key: key);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MyBackButton(title: "Listado de simpatizantes"),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: Column(
            children: [
              DefaultTabController(
                  length: 2,
                  child: Container(
                    child: TabBar(labelColor: Colors.black, tabs: [
                      Tab(
                        text: "Simpatizantes (0)",
                      ),
                      Tab(
                        text: "Dirigentes (0)",
                      )
                    ]),
                  )),
              MyTextField(
                  controller: controller,
                  hintText: "buscar",
                  obscureText: false)
            ],
          ),
        ),
      ],
    );
  }
}
