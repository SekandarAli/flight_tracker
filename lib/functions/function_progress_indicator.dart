// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flutter/material.dart';

class FunctionProgressIndicator extends StatefulWidget {
  const FunctionProgressIndicator({Key? key}) : super(key: key);

  @override
  State<FunctionProgressIndicator> createState() =>
      _FunctionProgressIndicatorState();
}

class _FunctionProgressIndicatorState extends State<FunctionProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    // return RadialAxis(
    //     showLabels: false,
    //     showTicks: false,
    //     startAngle: 180,
    //     endAngle: 0,
    //     radiusFactor: 0.7,
    //     canScaleToFit: true,
    //     axisLineStyle: AxisLineStyle(
    //     thickness: 0.1,
    //     color: const Color.fromARGB(30, 0, 169, 181),
    // thicknessUnit: GaugeSizeUnit.factor,
    // cornerStyle: CornerStyle.startCurve,
    // ),
    // pointers: [
    // RangePointer(
    // value: 12.0,
    // width: 0.1,
    // sizeUnit: GaugeSizeUnit.factor,
    // cornerStyle: CornerStyle.bothCurve)
    // ]);

    return CircularProgressIndicator(
      backgroundColor: ColorsTheme.primaryColor,
      valueColor: AlwaysStoppedAnimation(Colors.grey),
      strokeWidth: 10,
      semanticsLabel: "Loading",
      semanticsValue: "Loading",
    );
  }
}
