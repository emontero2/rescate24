import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rescate24/components/my_back_button.dart';
import 'package:rescate24/components/my_text_field.dart';
import 'package:rescate24/components/person_card.dart';
import 'package:rescate24/models/PersonModel.dart';
import 'package:flutter_face_api/face_api.dart' as Regula;
import 'package:rflutter_alert/rflutter_alert.dart';

import '../models/Person.dart';

class LeadersScreen extends StatefulWidget {
  LeadersScreen({Key? key}) : super(key: key);

  @override
  State<LeadersScreen> createState() => _LeadersScreenState();
}

class _LeadersScreenState extends State<LeadersScreen> {
  TextEditingController controller = TextEditingController();
  String _liveness = "nil";
  String _similarity = "nil";
  var image1 = new Regula.MatchFacesImage();
  var image2 = new Regula.MatchFacesImage();
  var img1 = null;
  var img2 = null;

  @override
  initState() {
    _liveness = "nil";
    _similarity = "nil";
    super.initState();
    const EventChannel('flutter_face_api/event/video_encoder_completion')
        .receiveBroadcastStream()
        .listen((event) {
      var response = jsonDecode(event);
      String transactionId = response["transactionId"];
      bool success = response["success"];
      print("video_encoder_completion:");
      print("    success: $success");
      print("    transactionId: $transactionId");
    });
  }

  setImage(bool first, Uint8List? imageFile, int type) {
    if (imageFile == null) return;
    // setState(() => _similarity = "nil");
    if (first) {
      image1.bitmap = base64Encode(imageFile);
      image1.imageType = type;
      setState(() {
        img1 = Image.memory(imageFile);
        _liveness = "nil";
      });
    } else {
      image2.bitmap = base64Encode(imageFile);
      image2.imageType = type;
      setState(() => img2 = Image.memory(imageFile));
    }
  }

  liveness(Person person) => Regula.FaceSDK.startLivenessWithConfig(
          {"skipStep": Regula.LivenessSkipStep.START_STEP}).then((value) {
        var result = Regula.LivenessResponse.fromJson(json.decode(value));
        setImage(true, base64Decode(result!.bitmap!.replaceAll("\n", "")),
            Regula.ImageType.LIVE);
        setState(() => _liveness =
            result.liveness == Regula.LivenessStatus.PASSED
                ? "passed"
                : "unknown");
        if (result.exception == null && _liveness == "passed") {
          matchFaces(person);
        }
      });

  matchFaces(Person person) {
    if (image1.bitmap == null ||
        image1.bitmap == "" ||
        image2.bitmap == null ||
        image2.bitmap == "") return;
    setState(() => _similarity = "Processing...");
    var request = Regula.MatchFacesRequest();
    request.images = [image1, image2];
    Regula.FaceSDK.matchFaces(jsonEncode(request)).then((value) {
      var response = Regula.MatchFacesResponse.fromJson(json.decode(value));
      Regula.FaceSDK.matchFacesSimilarityThresholdSplit(
              jsonEncode(response!.results), 0.75)
          .then((str) {
        var split = Regula.MatchFacesSimilarityThresholdSplit.fromJson(
            json.decode(str));
        setState(() => _similarity = split!.matchedFaces.isNotEmpty
            ? ("${(split.matchedFaces[0]!.similarity! * 100).toStringAsFixed(2)}%")
            : "error");
      });

      if (_similarity != "error") {
        Provider.of<PersonModel>(context).setLiveness(person);
      } else {
        showErrorDialog(
            "Problema al intentar mostrar que esta vivo, favor, intente denuevo");
      }
    });
  }

  void showErrorDialog(String message) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Error",
      desc: message,
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          width: 120,
          child: const Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    List<Person> persons =
        //Person.generatePerson();
        Provider.of<PersonModel>(context, listen: false).person;
    return Column(
      children: [
        const MyBackButton(title: "Listado de simpatizantes"),
        Container(
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTabController(
                    length: 2,
                    child: Container(
                      child: TabBar(labelColor: Colors.black, tabs: [
                        Tab(
                          text: "Simpatizantes (${persons.length})",
                        ),
                        Tab(
                          text: "Dirigentes (0)",
                        )
                      ]),
                    )),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Flexible(
                      child: SizedBox(
                        height: 40,
                        child: MyTextField(
                          controller: controller,
                          hintText: "Buscar",
                          obscureText: false,
                          startIcon: "lib/images/search.svg",
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 2, color: Color(0xFFDDDDDD)),
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: IconButton(
                          onPressed: () => {},
                          icon: const Icon(
                            Icons.tune,
                          )),
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.grey,
                ),
                SizedBox(
                    height: 500,
                    child: persons.isEmpty
                        ? Text("No tiene personas asociadas a su movimiento")
                        : ListView.builder(
                            itemCount: persons.length,
                            itemBuilder: (context, index) {
                              return PersonCard(
                                person: persons[index],
                                onTap: () {
                                  liveness(persons[index]);
                                },
                              );
                            }))
              ],
            )),
      ],
    );
  }
}
