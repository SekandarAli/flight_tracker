// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flutter/material.dart';

class PickDate extends StatefulWidget {
  const PickDate({Key? key}) : super(key: key);

  @override
  State<PickDate> createState() => _PickDateState();
}

class _PickDateState extends State<PickDate> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        selectDate(context);
      },

      child:  Row(
        children: [
          Icon(Icons.calendar_month, color: ColorsTheme.textColor),
          SizedBox(width: 5),
          Text(
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
            // DateFormat.yMMMEd().format(DateTime.now()),
            style: ThemeTexts.textStyleValueGrey,
          )
        ],
      ),
    );
  }

  selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
      helpText: "Select Date",
      initialEntryMode: DatePickerEntryMode.calendar,
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
  }
}



/// //////////////// By Flight Code Date  /////////////////////

class PickDateFlightCode extends StatefulWidget {
  const PickDateFlightCode({Key? key}) : super(key: key);

  @override
  State<PickDateFlightCode> createState() => _PickDateFlightCodeState();
}

class _PickDateFlightCodeState extends State<PickDateFlightCode> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        selectDate(context);
      },

      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: ColorsTheme.primaryColor),
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_month, color: ColorsTheme.black),
            SizedBox(width: 20),
            Text(
              "Departing ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
              // DateFormat.yMMMEd().format(DateTime.now()),
              style: ThemeTexts.textStyleValueGrey,
            )
          ],
        ),
      ),
    );
  }

  selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
      helpText: "Select Date",
      initialEntryMode: DatePickerEntryMode.calendar,
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
  }
}
