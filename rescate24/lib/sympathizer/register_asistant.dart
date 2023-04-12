import 'dart:convert';
import 'dart:typed_data';

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
String _lastName = "";
String _genre = "";
String _birthDay = "";
String _documentNumber = "";
Image _portrait = Image.asset("lib/images/portrait.png");
Image _docImage = Image.asset("lib/images/id.png");
List<List<String>> _scenarios = [];
String _selectedScenario = "Ocr";
Uint8List? _portraitBytes = null;
Uint8List? _docImageBytes = null;
var image1 = new Regula.MatchFacesImage();
var image2 = new Regula.MatchFacesImage();
var img1 = null;
var img2 = null;

Widget getActiveStepWidget() {
  if (activeStep == 0) {
    return const Step1();
  } else if (activeStep == 1) {
    return const Step2();
  } else if (activeStep == 2) {
    return StepResult(
      name: _name,
      last_name: _lastName,
      doc_image: _portraitBytes,
      docNumber: _documentNumber,
      birthDay: _birthDay,
      genre: _genre,
    );
  } else if (activeStep == 3) {
    return Step3(
      MunicipeController: MunicipeController,
      provinceController: provinceController,
      sectorController: sectorController,
      phoneNumberController: phoneNumberController,
      phoneNumberResidenceController: phoneNumberResidenceController,
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
      if (completion.results != null) {
        activeStep++;
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
    var name =
        await results.textFieldValueByType(EVisualFieldType.FT_FIRST_NAME);
    var lastName =
        await results.textFieldValueByType(EVisualFieldType.FT_LAST_NAME);
    var genre = await results.textFieldValueByType(EVisualFieldType.FT_SEX);
    var documentNumber =
        await results.textFieldValueByType(EVisualFieldType.FT_DOCUMENT_NUMBER);
    var birthDay =
        await results.textFieldValueByType(EVisualFieldType.FT_DATE_OF_BIRTH);
    var doc = await results
        .graphicFieldImageByType(EGraphicFieldType.GF_DOCUMENT_IMAGE);
    var portrait =
        await results.graphicFieldImageByType(EGraphicFieldType.GF_PORTRAIT);
    print("name: $name");
    setState(() {
      _name = name ?? "No encontrado";
      _lastName = lastName ?? "No encontrado";
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

  matchFaces() {
    if (image1.bitmap == null ||
        image1.bitmap == "" ||
        image2.bitmap == null ||
        image2.bitmap == "") return;
    setState(() => _similarity = "Processing...");
    var request = new Regula.MatchFacesRequest();
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
        activeStep++;
      });

  Widget getBottomButtons() {
    if (activeStep == 0) {
      return GestureDetector(
          onTap: () {
            setState(() {
              if (activeStep == 4) {
                Navigator.pop(context);
              } else {
                if (activeStep == 0) {
                  liveness();
                } else {
                  print(activeStep);
                  activeStep++;
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
                dispose();
              },
              child: const MyIconButton(title: "Asistente de Registro")),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
              onTap: () {
                setState(() {
                  if (activeStep == 4) {
                    Navigator.pop(context);
                  } else {
                    if (activeStep == 0) {
                      liveness();
                    } else {
                      print(activeStep);
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
                  if (activeStep == 4) {
                    Navigator.pop(context);
                    dispose();
                  } else {
                    if (activeStep == 1) {
                      DocumentReader.showScanner();
                    } else if (activeStep == 2) {
                      var person = Person();
                      person.birthDay = _birthDay;
                      person.docNumber = _documentNumber;
                      person.gnere = _genre;
                      person.name = _name;
                      person.lastName = _lastName;
                      person.portrait = _portraitBytes;
                      Provider.of<PersonModel>(context, listen: false)
                          .add(person);
                      activeStep++;
                    } else if (activeStep == 3 && isAnythingEmpty()) {
                      print("Algunos de tus campos esta vacio");
                    } else {
                      activeStep++;
                    }
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
            child: Text(
              "Pasos",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          DotStepper(
            shape: Shape.pipe,
            dotCount: 4,
            spacing: 60,
            tappingEnabled: false,
            indicatorDecoration: const IndicatorDecoration(color: Colors.green),
            activeStep: activeStep,
            onDotTapped: (tappedDotIndex) => activeStep = tappedDotIndex,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _liveness == "nil"
                    ? Text(
                        "1",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    : SvgPicture.asset(
                        _liveness == "passed"
                            ? "lib/images/check_icon.svg"
                            : "lib/images/x_mark_icon.svg",
                        width: 20,
                        height: 20,
                        color:
                            _liveness == "passed" ? Colors.green : Colors.red,
                      ),
                _name.isEmpty
                    ? Text("2",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold))
                    : SvgPicture.asset(
                        "lib/images/check_icon.svg",
                        width: 20,
                        height: 20,
                        color: Colors.green,
                      ),
                isAnythingEmpty()
                    ? Text("3",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold))
                    : SvgPicture.asset(
                        "lib/images/check_icon.svg",
                        width: 20,
                        height: 20,
                        color: Colors.green,
                      ),
                Text("4",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
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
            height: 20,
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
    activeStep = 0;
  }
}
