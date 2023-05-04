import 'package:flutter/cupertino.dart';

class CustomStepper extends StatefulWidget {
  const CustomStepper(
      {Key? key, required this.activeStep, required this.dotCount})
      : super(key: key);
  final int activeStep;
  final int dotCount;

  @override
  _CustomStepperState createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  int _dotCount = 2;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dotCount = widget.dotCount;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        Container();
      },
      scrollDirection: Axis.horizontal,
      itemCount: _dotCount,
    );
  }
}
