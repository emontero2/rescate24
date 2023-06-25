import 'dart:convert';
import 'dart:typed_data';

import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_document_reader_api/document_reader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:im_stepper/stepper.dart';
import 'package:provider/provider.dart';
import 'package:rescate24/components/my_button.dart';
import 'package:rescate24/models/Person.dart';
import 'package:rescate24/models/PersonModel.dart';
import 'package:rescate24/sympathizer/step1.dart';
import 'package:rescate24/sympathizer/step2.dart';
import 'package:rescate24/sympathizer/step3.dart';
import 'package:rescate24/sympathizer/step_finish.dart';
import 'package:rescate24/sympathizer/step_result.dart';
import 'package:flutter_face_api/face_api.dart' as Regula;
import 'package:rflutter_alert/rflutter_alert.dart';

import '../components/my_back_button.dart';
import '../components/my_bottom_bar.dart';
import '../components/my_icon_button.dart';

class RegisterAsistant extends StatefulWidget {
  const RegisterAsistant({Key? key}) : super(key: key);

  @override
  _RegisterAsistantState createState() => _RegisterAsistantState();
}

final provinceController = TextEditingController();
final MunicipeController = TextEditingController();
final sectorController = TextEditingController();
final phoneNumberResidenceController = TextEditingController();
final phoneNumberController = TextEditingController();
final emailController = TextEditingController();

int activeStep = 0;

String _name = "";
String _genre = "";
String _birthDay = "";
String _documentNumber = "";
Image _portrait = Image.asset("lib/images/portrait.png");
Image _docImage = Image.asset("lib/images/id.png");
List<List<String>> _scenarios = [];
String _selectedScenario = "FullProcess";
Uint8List? _portraitBytes = null;
Uint8List? _docImageBytes = null;

bool isFinish = false;
List<String> whiteList = [
  "00116145889",
  "00118314723",
  "00113746598",
  "40215765898"
];

Widget getActiveStepWidget() {
  if (activeStep == 0) {
    return const Step2();
  } else if (activeStep == 1) {
    return Step3(
      MunicipeController: MunicipeController,
      provinceController: provinceController,
      sectorController: sectorController,
      phoneNumberController: phoneNumberController,
      phoneNumberResidenceController: phoneNumberResidenceController,
      emailController: emailController,
    );
  } else if (activeStep == 2) {
    return StepResult(
      name: _name,
      doc_image: _portraitBytes,
      docNumber: _documentNumber,
      birthDay: _birthDay,
      genre: _genre,
      province: provinceController.text,
      sector: sectorController.text,
      municipality: MunicipeController.text,
    );
  } else if (activeStep == 3) {
    return StepFinish(
      isLivenessOk: isOnWhiteList(_documentNumber),
      isCaptureDocumentOk: _name.isNotEmpty && _docImageBytes != null,
    );
  } else {
    return Container();
  }
}

bool isOnWhiteList(String docNumber) {
  return whiteList.contains(docNumber);
}

bool isAnythingEmpty() {
  if (provinceController.text.isNotEmpty &&
      MunicipeController.text.isNotEmpty &&
      sectorController.text.isNotEmpty &&
      phoneNumberController.text.isNotEmpty &&
      phoneNumberResidenceController.text.isNotEmpty &&
      emailController.text.isNotEmpty) {
    return false;
  } else {
    return true;
  }
}

Color getActiveColor(int active) {
  return activeStep == active ? Color(0xFF3CBC2F) : Color(0xFFE7ECF4);
}

class _RegisterAsistantState extends State<RegisterAsistant> {
  var stepperData = [];

  @override
  void initState() {
    super.initState();
    activeStep = 0;

    _name = "";
    _genre = "";
    _birthDay = "";
    _documentNumber = "";
    _portrait = Image.asset("lib/images/portrait.png");
    _docImage = Image.asset("lib/images/id.png");
    MunicipeController.clear();
    provinceController.clear();
    emailController.clear();
    phoneNumberController.clear();
    phoneNumberResidenceController.clear();
    sectorController.clear();
    initPlatformState();

    const EventChannel('flutter_document_reader_api/event/completion')
        .receiveBroadcastStream()
        .listen((jsonString) => handleCompletion(
            DocumentReaderCompletion.fromJson(json.decode(jsonString))!));
  }

  void handleCompletion(DocumentReaderCompletion completion) {
    if (completion.action == DocReaderAction.COMPLETE ||
        completion.action == DocReaderAction.TIMEOUT) {
      if (completion.results != null) {
        displayResults(completion.results!);
      }
    }
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

  displayResults(DocumentReaderResults results) async {
    var name = await results
        .textFieldValueByType(EVisualFieldType.FT_SURNAME_AND_GIVEN_NAMES);
    var genre = await results.textFieldValueByType(EVisualFieldType.FT_SEX);
    var documentNumber =
        await results.textFieldValueByType(EVisualFieldType.FT_DOCUMENT_NUMBER);
    var birthDay =
        await results.textFieldValueByType(EVisualFieldType.FT_DATE_OF_BIRTH);
    var doc = await results
        .graphicFieldImageByType(EGraphicFieldType.GF_DOCUMENT_IMAGE);
    var portrait =
        await results.graphicFieldImageByType(EGraphicFieldType.GF_PORTRAIT);
    var province =
        await results.textFieldValueByType(EVisualFieldType.FT_ADDRESS_STATE);
    var municipe = await results
        .textFieldValueByType(EVisualFieldType.FT_ADDRESS_MUNICIPALITY);
    var sector =
        await results.textFieldValueByType(EVisualFieldType.FT_ADDRESS_STATE);

    MunicipeController.text = municipe ?? "";
    provinceController.text = province ?? "";
    sectorController.text = sector ?? "";

    setState(() {
      _name = name?.split(" ")[0] ?? "";
      _documentNumber = documentNumber ?? "";
      _birthDay = birthDay ?? "No encontrado";
      _genre = genre ?? "No encontrado";
      _docImage = Image.asset('assets/images/id.png');
      _portrait = Image.asset('assets/images/portrait.png');
      if (doc != null) {
        _docImage = Image.memory(doc.data!.contentAsBytes());

        setState(() {
          _docImageBytes = doc.data!.contentAsBytes();
        });
      }
      if (portrait != null) {
        setState(() {
          _portraitBytes = portrait.data!.contentAsBytes();
        });
        _portrait = Image.memory(portrait.data!.contentAsBytes());
      }
    });
    if (_name.isNotEmpty && _documentNumber.isNotEmpty) {
      activeStep++;
    } else {
      showErrorDialog(
          "Error al leer los documentos, por favor, intenta denuevo.");
    }
    print("Name: " + _name);
    print("documentnumber " + _documentNumber);
  }

  Future<void> initPlatformState() async {
    Regula.FaceSDK.init().then((json) {
      var response = jsonDecode(json);
      if (!response["success"]) {
        print("Init failed: ");
        print(json);
      }
    });

    DocumentReader.setConfig({
      "functionality": {"videoCaptureMotionControl": true},
      "customization": {
        "showResultStatusMessages": false,
        "showStatusMessages": false,
        "showBackgroundMask": true,
        "backgroundMaskAlpha": 0.5,
        "showNextPageAnimation": true,
        "uiCustomizationLayer": {
          "objects": [
            {
              "label": {
                "text":
                    "Mantenga el dispositivo con el menor movimiento posible",
                "position": {"h": 1.0, "v": 0.5},
                "background": "#00FFFFFF",
                "fontColor": "#000000",
                "fontSize": 18,
                "fontStyle": "bold",
                "alignment": "center"
              }
            }
          ]
        }
      },
      "processParams": {
        "scenario": _selectedScenario,
        "multipageProcessing": true
      }
    });
  }

  addPerson() {
    var person = Person.empty();
    if (isOnWhiteList(_documentNumber)) {
      person.liveness = true;
    }
    person.birthDay = _birthDay;
    person.docNumber = _documentNumber;
    person.gnere = _genre;
    person.name = _name;
    person.portrait = _portraitBytes;
    person.municipe = MunicipeController.text;
    person.province = provinceController.text;
    person.phoneNumber = phoneNumberController.text;
    person.email = emailController.text;
    Provider.of<PersonModel>(context, listen: false).add(person);
  }

  Widget getButton() {
    if (activeStep == 3) {
      return const MyButton(title: "Finalizar");
    } else {
      return const MyButton(title: "Continuar");
    }
  }

  Widget getBottomButtons() {
    if (activeStep == 0) {
      return GestureDetector(
          onTap: () {
            setState(() {
                    activeStep++;
                  });
          },
          child: getButton());
    } else if (activeStep == 3) {
      return Column(
        children: [
          GestureDetector(
              onTap: () {
                Navigator.popAndPushNamed(context, '/register_assitant');
              },
              child: const MyIconButton(title: "Asistente de Registro")),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
              onTap: () {
                setState(() {
                      activeStep++;
                      activeStep++;
                    }
                  }
                  activeStep++;
                    }
                  }
                });
              },
              child: getButton())
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    activeStep--;
                  });
                },
                child: const MyButton(
                  title: "Volver",
                  isGrey: true,
                  margin: 12,
                )),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                    activeStep++;
                    activeStep++;
                  }
                  activeStep++;
                  }
                });
              },
              child: const MyButton(
                title: "Continuar",
                margin: 12,
              ),
            ),
          )
        ],
      );
    }
  }

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              const MyBackButton(
                title: "Asistente de Registro",
                hasBottomDivider: false,
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text(
                  "Pasos",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    AnotherStepper(
                      stepperList: [
                        StepperData(
                            iconWidget: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: getActiveColor(0)),
                        )),
                        StepperData(
                            iconWidget: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: getActiveColor(1)),
                        )),
                        StepperData(
                            iconWidget: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: getActiveColor(2)),
                        )),
                        StepperData(
                            iconWidget: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: getActiveColor(3)),
                        ))
                      ],
                      stepperDirection: Axis.horizontal,
                      iconWidth: 80,
                      iconHeight: 10,
                      barThickness: 0,
                      activeIndex: activeStep,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(""),
                          _name.isEmpty
                              ? const Text(
                                  "1",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )
                              : SvgPicture.asset(
                                  _name.isNotEmpty
                                      ? "lib/images/check_icon.svg"
                                      : "lib/images/x_mark_icon.svg",
                                  width: 20,
                                  height: 20,
                                  color: _name.isNotEmpty
                                      ? Colors.green
                                      : Colors.red,
                                ),
                          const Text(""),
                          isAnythingEmpty()
                              ? const Text("2",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                              : SvgPicture.asset(
                                  "lib/images/check_icon.svg",
                                  width: 20,
                                  height: 20,
                                  color: Colors.green,
                                ),
                          const Text(""),
                          isAnythingEmpty() ||
                                  _name.isEmpty ||
                                  _documentNumber.isEmpty
                              ? const Text("3",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                              : SvgPicture.asset(
                                  "lib/images/check_icon.svg",
                                  width: 20,
                                  height: 20,
                                  color: Colors.green,
                                ),
                          const Text(""),
                          const Text("4",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 2,
                color: Color(0xFFDDDDDD),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxHeight: 380.0, minHeight: 380),
                  child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          border:
                              Border.all(color: Color(0xFFDDDDDD), width: 2.0)),
                      child: getActiveStepWidget()),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              getBottomButtons()
            ],
          ),
        ));
  }
}
