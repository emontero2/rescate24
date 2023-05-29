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

String _liveness = "nil";
String _similarity = "nil";
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
var image1 = new Regula.MatchFacesImage();
var image2 = new Regula.MatchFacesImage();
var img1 = null;
var img2 = null;
bool isFinish = false;

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
      isLivenessOk: _liveness == "passed" && _similarity != "error",
      isCaptureDocumentOk: _name.isNotEmpty && _docImageBytes != null,
    );
  } else if (activeStep == 3 && isFinish) {
    return Container();
  } else {
    return Container();
  }
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
  return activeStep == active ? Colors.green : Colors.grey;
}

class _RegisterAsistantState extends State<RegisterAsistant> {
  var stepperData = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
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
    const EventChannel('flutter_document_reader_api/event/database_progress')
        .receiveBroadcastStream()
        .listen((progress) => print("Downloading database: $progress%"));
    const EventChannel('flutter_document_reader_api/event/completion')
        .receiveBroadcastStream()
        .listen((jsonString) => handleCompletion(
            DocumentReaderCompletion.fromJson(json.decode(jsonString))!));
  }

  void handleCompletion(DocumentReaderCompletion completion) {
    if (completion.action == DocReaderAction.COMPLETE ||
        completion.action == DocReaderAction.TIMEOUT) {
      if (completion.results != null) {
        activeStep++;
        print(activeStep);
        displayResults(completion.results!);
        print(completion.results);
      } else {
        print("Error al leer los documentos");
      }
    } else {
      print("Error al leer los documentos");
    }
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

    for (var textField in results.textResult?.fields ?? []) {
      for (var value in textField?.values) {
        print(
            '${textField.fieldName}, value: ${value?.value}, source: ${value?.sourceType}');
      }
    }
    MunicipeController.text = municipe ?? "";
    provinceController.text = province ?? "";
    sectorController.text = sector ?? "";

    setState(() {
      _name = name?.split(" ")[0] ?? "No encontrado";
      _documentNumber = documentNumber ?? "No encontrado";
      _birthDay = birthDay ?? "No encontrado";
      _genre = genre ?? "No encontrado";
      _docImage = Image.asset('assets/images/id.png');
      _portrait = Image.asset('assets/images/portrait.png');
      if (doc != null) {
        _docImage = Image.memory(doc.data!.contentAsBytes());
        setImage(false, doc.data!.contentAsBytes(), Regula.ImageType.PRINTED);
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
  }

  Future<void> initPlatformState() async {
    print("Initializing...");
    print(await DocumentReader.prepareDatabase("Full"));

    ByteData byteData = await rootBundle.load("assets/regula.license");
    print(await DocumentReader.initializeReader({
      "license": base64.encode(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes)),
      "delayedNNLoad": true
    }));
    print("Ready");
    Regula.FaceSDK.init().then((json) {
      var response = jsonDecode(json);
      if (!response["success"]) {
        print("Init failed: ");
        print(json);
      }
    });

    List<List<String>> scenarios = [];
    var scenariosTemp =
        json.decode(await DocumentReader.getAvailableScenarios());
    //print(scenariosTemp);
    for (var i = 0; i < scenariosTemp.length; i++) {
      DocumentReaderScenario scenario = DocumentReaderScenario.fromJson(
          scenariosTemp[i] is String
              ? json.decode(scenariosTemp[i])
              : scenariosTemp[i])!;
      scenarios.add([scenario.name!, scenario.caption!]);
      print(scenariosTemp[i]);
    }
    setState(() => _scenarios = scenarios);

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

  matchFaces() {
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
        setState(() => _similarity = split!.matchedFaces.length > 0
            ? ((split.matchedFaces[0]!.similarity! * 100).toStringAsFixed(2) +
                "%")
            : "error");
      });
      print("similarity: " + _similarity);
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

  Widget getButton() {
    if (activeStep == 3 && isFinish) {
      return const MyButton(title: "Finalizar");
    } else {
      return const MyButton(title: "Continuar");
    }
  }

  liveness() => Regula.FaceSDK.startLivenessWithConfig(
          {"skipStep": Regula.LivenessSkipStep.START_STEP}).then((value) {
        var result = Regula.LivenessResponse.fromJson(json.decode(value));
        setImage(true, base64Decode(result!.bitmap!.replaceAll("\n", "")),
            Regula.ImageType.LIVE);
        setState(() => _liveness =
            result.liveness == Regula.LivenessStatus.PASSED
                ? "passed"
                : "unknown");
        if (result.exception == null ||
            result.exception?.errorCode == Regula.LivenessErrorCode.CANCELLED) {
          activeStep++;
        } else {
          liveness();
        }
      });

  Widget getBottomButtons() {
    if (activeStep == 0) {
      return GestureDetector(
          onTap: () {
            setState(() {
              if (activeStep == 3 && isFinish) {
                Navigator.pop(context);
              } else {
                if (activeStep == 0) {
                  DocumentReader.showScanner();
                } else {
                  setState(() {
                    activeStep++;
                  });
                }
              }
            });
          },
          child: getButton());
    } else if (activeStep == 4) {
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
                  if (activeStep == 4) {
                    var person = Person();
                    person.birthDay = _birthDay;
                    person.docNumber = _documentNumber;
                    person.gnere = _genre;
                    person.name = _name;
                    person.portrait = _portraitBytes;
                    person.municipe = MunicipeController.text;
                    person.province = provinceController.text;
                    person.phoneNumber = phoneNumberController.text;
                    person.email = emailController.text;
                    Provider.of<PersonModel>(context, listen: false)
                        .add(person);
                    Navigator.pop(context);
                    dispose();
                  } else {
                    if (activeStep == 0) {
                      DocumentReader.showScanner();
                    } else {
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () {
                setState(() {
                  activeStep--;
                });
              },
              child: const MyButton(
                title: "Volver",
                isGrey: true,
              )),
          GestureDetector(
              onTap: () {
                setState(() {
                  if (activeStep == 1 && !isAnythingEmpty() ||
                      activeStep == 2 ||
                      activeStep == 3) {
                    activeStep++;
                  }
                });
              },
              child: getButton())
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
      body: Column(
        children: [
          const MyBackButton(
            title: "Asistente de Registro",
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: const Text(
              "Pasos",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
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
                      Text(""),
                      _liveness == "nil"
                          ? Text(
                              "1",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )
                          : SvgPicture.asset(
                              _liveness == "passed"
                                  ? "lib/images/check_icon.svg"
                                  : "lib/images/x_mark_icon.svg",
                              width: 20,
                              height: 20,
                              color: _liveness == "passed"
                                  ? Colors.green
                                  : Colors.red,
                            ),
                      Text(""),
                      _name.isEmpty
                          ? Text("2",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))
                          : SvgPicture.asset(
                              "lib/images/check_icon.svg",
                              width: 20,
                              height: 20,
                              color: Colors.green,
                            ),
                      Text(""),
                      isAnythingEmpty()
                          ? Text("3",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))
                          : SvgPicture.asset(
                              "lib/images/check_icon.svg",
                              width: 20,
                              height: 20,
                              color: Colors.green,
                            ),
                      Text(""),
                      Text("4",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
              ],
            ),
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
                      border: Border.all(color: Colors.grey, width: 2.0)),
                  child: getActiveStepWidget()),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          getBottomButtons()
        ],
      ),
      bottomNavigationBar: const MyBottomBar(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
