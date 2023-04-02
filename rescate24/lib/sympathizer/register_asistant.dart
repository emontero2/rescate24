import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_document_reader_api/document_reader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:im_stepper/stepper.dart';
import 'package:rescate24/components/my_button.dart';
import 'package:rescate24/sympathizer/step1.dart';
import 'package:rescate24/sympathizer/step2.dart';
import 'package:rescate24/sympathizer/step3.dart';
import 'package:rescate24/sympathizer/step_finish.dart';
import 'package:rescate24/sympathizer/step_result.dart';
import 'package:flutter_face_api/face_api.dart' as Regula;

import '../components/my_back_button.dart';
import '../components/my_bottom_bar.dart';

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
String _name = "";
Image _portrait = Image.asset("lib/images/portrait.png");
Image _docImage = Image.asset("lib/images/id.png");
List<List<String>> _scenarios = [];
String _selectedScenario = "DocType";
Uint8List? _portraitBytes = null;
Uint8List? _docImageBytes = null;

Widget getActiveStepWidget() {
  if (activeStep == 0) {
    return Step1();
  } else if (activeStep == 1) {
    return Step2();
  } else if (activeStep == 2) {
    return StepResult(
      name: _name.isNotEmpty ? _name.split(" ")[0] : "No encontrado",
      last_name: _name.isNotEmpty ? _name.split(" ")[1] : "No encontrado",
      doc_image: _portraitBytes,
    );
  } else if (activeStep == 3) {
    return Step3(
      MunicipeController: MunicipeController,
      provinceController: provinceController,
      sectorController: sectorController,
      phoneNumberController: phoneNumberController,
      phoneNumberResidenceController: phoneNumberController,
      emailController: emailController,
    );
  } else {
    return StepFinish(
      isLivenessOk: _liveness == "passed",
      isCaptureDocumentOk: _name.isNotEmpty && _docImageBytes != null,
    );
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

class _RegisterAsistantState extends State<RegisterAsistant> {
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
      print("Error al leer los documentos");
    } else {
      activeStep++;
      displayResults(completion.results!);
    }
  }

  displayResults(DocumentReaderResults results) async {
    var name = await results
        .textFieldValueByType(EVisualFieldType.FT_SURNAME_AND_GIVEN_NAMES);
    var doc = await results
        .graphicFieldImageByType(EGraphicFieldType.GF_DOCUMENT_IMAGE);
    var portrait =
        await results.graphicFieldImageByType(EGraphicFieldType.GF_PORTRAIT);
    setState(() {
      _name = name ?? "";
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
    print(scenariosTemp);
    for (var i = 0; i < scenariosTemp.length; i++) {
      DocumentReaderScenario scenario = DocumentReaderScenario.fromJson(
          scenariosTemp[i] is String
              ? json.decode(scenariosTemp[i])
              : scenariosTemp[i])!;
      scenarios.add([scenario.name!, scenario.caption!]);
    }
    setState(() => _scenarios = scenarios);

    DocumentReader.setConfig({
      "functionality": {
        "videoCaptureMotionControl": true,
        "showCaptureButton": true
      },
      "customization": {
        "showResultStatusMessages": true,
        "showStatusMessages": true
      },
      "processParams": {"scenario": _selectedScenario}
    });
  }

  setImage(bool first, Uint8List? imageFile, int type) {
    if (imageFile == null) return;
    // setState(() => _similarity = "nil");
    if (first) {
      //image1.bitmap = base64Encode(imageFile);
      //image1.imageType = type;
      setState(() {
        //img1 = Image.memory(imageFile);
        _liveness = "nil";
      });
    } else {
      //image2.bitmap = base64Encode(imageFile);
      //image2.imageType = type;
      //setState(() => img2 = Image.memory(imageFile));
    }
  }

  Widget getButton() {
    if (activeStep == 4) {
      return const MyButton(title: "Finalizar");
    } else {
      return const MyButton(title: "Continuar");
    }
  }

  liveness() => Regula.FaceSDK.startLiveness().then((value) {
        var result = Regula.LivenessResponse.fromJson(json.decode(value));
        setImage(true, base64Decode(result!.bitmap!.replaceAll("\n", "")),
            Regula.ImageType.LIVE);
        setState(() => _liveness =
            result.liveness == Regula.LivenessStatus.PASSED
                ? "passed"
                : "unknown");
      });

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
            title: "Asistente de Registro",
          ),
          SizedBox(
            height: 20,
          ),
          NumberStepper(
            numbers: [1, 2, 3, 4],
            enableNextPreviousButtons: false,
            enableStepTapping: false,
            activeStep: activeStep,
            onStepReached: (index) {
              setState(() {
                activeStep = index;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 420.0),
              child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey, width: 2.0)),
                  child: getActiveStepWidget()),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          activeStep == 0 || activeStep == 4
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      if (activeStep == 4) {
                        Navigator.pop(context);
                      } else {
                        if (activeStep == 0) liveness();
                        print(activeStep);
                        activeStep++;
                      }
                    });
                  },
                  child: getButton())
              : Row(
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
                            if (activeStep == 4) {
                              Navigator.pop(context);
                              dispose();
                            } else {
                              if (activeStep == 1) {
                                DocumentReader.showScanner();
                              } else if (isAnythingEmpty()) {
                                print("Algunos de tus campos esta vacio");
                              } else {
                                activeStep++;
                              }
                            }
                          });
                        },
                        child: getButton())
                  ],
                )
        ],
      ),
      bottomNavigationBar: MyBottomBar(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    activeStep = 0;
  }
}
