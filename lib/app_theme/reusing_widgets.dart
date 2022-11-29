// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flutter/material.dart';

class ReusingWidgets {
  /// TAP BAR ///
  static Widget tapBarText({
    required String text,
  }) {
    return Text(text,
      style: ThemeTexts.textStyleTitle2,
    );
  }

  /// TAP BAR ///


  /// Airlines TAP BAR ///


  Widget airlineTapBar({
    required Function() onTap,
    required BuildContext context,
    required String text,
    required Color textColor,
    required Color borderColor,
    required double borderWidth,
  }) {
    return InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: borderColor,
                  width: borderWidth,
                )
              )
          ),
          alignment: Alignment.center,
          child: Text(
            text,
              style: ThemeTexts.textStyleTitle2.copyWith(color: textColor,fontWeight: FontWeight.normal)
          ),
        ));
  }


  /// Airlines TAP BAR ///

  //
  // /// SEARCH BAR
  //
  //
  // static Widget SearchTextFormField(
  //     {required BuildContext context,
  //       required TextEditingController controller,
  //       required String hintText}) {
  //   return TextFormField(
  //     controller: controller,
  //     decoration:  InputDecoration(
  //       icon: Icon(Icons.person),
  //       hintText: hintText,
  //       labelText: 'Name *',
  //     ),
  //     onSaved: (String? value) {
  //       // This optional block of code can be used to run
  //       // code when the user saves the form.
  //     },
  //     validator: (String? value) {
  //       return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
  //     },
  //   );
  // }
  //
  // ///  SEARCH BAR



  /// SEARCH BAR


  static InputDecoration SearchTextFormField(
      {
        required String hintText}) {
    return InputDecoration(
      prefixIcon: InkWell(
        onTap: () {
          // Navigator.pop(context);
        },
        child: Icon(
          Icons.search,
          size: 22,
          color: Colors.grey,
        ),
      ),
      // labelText: labelText,
      // suffixIcon: suffixIcon,
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      hintText: hintText,
      filled: true,
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, width: .5),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, width: .5),
        borderRadius: BorderRadius.all(
          Radius.circular(2),
        ),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      errorStyle: ThemeTexts.textStyleTitle2,
      hintStyle: ThemeTexts.textStyleTitle2.copyWith(color: Colors.grey),
      labelStyle: ThemeTexts.textStyleTitle2,
      floatingLabelStyle: ThemeTexts.textStyleTitle2,
    );
  }

  ///  SEARCH BAR





  /// BY ROUTE ///

  static Widget byRouteContainer({
    required String departureTitle,
    required String arrivalTitle,
    required BuildContext context,
    required Function() onTapDepartureTitle,
    required Function() onTapArrivalTitle,
    required TextStyle depStyle,
    required TextStyle arrStyle,
    required Function() onTapClearDepartureTitle,
    required Function() onTapClearArrivalTitle,
    required bool clearIconDeparture,
    required bool clearIconArrival,
    required Function() onTapSwapIcon,
  }) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.19,
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: (){
                    onTapDepartureTitle();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.flight_takeoff, color: ColorsTheme.black),
                      SizedBox(width: 20),
                      Text(
                        departureTitle.length > 20 ? '${departureTitle.substring(0, 20)}...' : departureTitle,
                        style: depStyle,
                      ),
                      clearIconDeparture == true ? IconButton(onPressed: (){
                        onTapClearDepartureTitle();
                      }, icon: Icon(Icons.clear)) : Container()
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Divider(
                    // endIndent: 200,
                    thickness: 1,
                  ),
                ),
                InkWell(
                  onTap: (){
                    onTapArrivalTitle();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.flight_land, color: ColorsTheme.black),
                      SizedBox(width: 20),
                      Text(
                        // arrivalTitle,
                        arrivalTitle.length > 20 ? '${arrivalTitle.substring(0, 20)}...' : arrivalTitle,
                        style: arrStyle,
                      ),
                      clearIconArrival == true ? IconButton(onPressed: (){
                        onTapClearArrivalTitle();
                      }, icon: Icon(Icons.clear)) : Container()
                    ],
                  ),
                ),
              ],
            ),
            IconButton(
                onPressed: () {
                  onTapSwapIcon();
                },
                icon: Icon(
                  Icons.swap_vert,
                  size: 30,
                ))
          ],
        ));
  }

  static Widget optionalAirlineContainer({
    required String airlineTitle,
    required BuildContext context,
    required Function() onTapAirlineOptional,
    required TextStyle airlineStyle,
  }) {
    return Container(
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
        ),
        child: InkWell(
          onTap: (){
            onTapAirlineOptional();
          },
          child: Row(
            children: [
              Icon(Icons.line_style_outlined, color: ColorsTheme.black),
              SizedBox(width: 20),
              Text(
                airlineTitle,
                style: airlineStyle,
              )
            ],
          ),
        ));
  }

  static Widget hideAirlineText({
    required Function() onTap,
    required String text,
    required IconData icon,
  }) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: ColorsTheme.white),
            Text(
              text.toUpperCase(),
              style: ThemeTexts.textStyleTitle3,

            )
          ],
        ),
      ),
    );
  }

  static Widget searchButton({
    required Function() onPress,
    required BuildContext context,
    required String text,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(3),
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          onPress();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsTheme.buttonColor,
          padding: EdgeInsets.all(15),
          textStyle: TextStyle(
              // fontSize: 20,
              fontWeight: FontWeight.normal),
        ),
        child: Text(
          text,
          style: ThemeTexts.textStyleTitle2,
        ),
      ),
    );
  }
          /// BY ROUTE ///


               /// BY FLIGHT CODE ///



  static Widget byFlightCodeContainer({
    required String flightCodeText,
    required BuildContext context,
    required Function() onTapFlightCodeText,
    required TextStyle flightCodeStyle,
    required bool clearIcon,
    required Function() onTapClearIcon,
  }) {
    return GestureDetector(
      onTap: (){
        onTapFlightCodeText();
      },
      child: Container(
          height: MediaQuery.of(context).size.height * 0.17,
          margin: EdgeInsets.all(0),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.all(
              Radius.circular(3),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.numbers, color: ColorsTheme.black),
              SizedBox(width: 20),
              Text(
                flightCodeText,
                style: flightCodeStyle,
              ),
              clearIcon == true ? IconButton(onPressed: (){
                onTapClearIcon();
              }, icon: Icon(Icons.clear)) : Container()
            ],
          )),
    );
  }

/// BY FLIGHT CODE ///


/// Airport Detail ///

  Widget searchModuleTabBar({
    required Function() onTap,
    required BuildContext context,
    required String text,
    required Color textColor,
    required Color borderColor,
    required double borderWidth,
  }) {
    return InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
              color: ColorsTheme.primaryColor,
              border: Border(
                  bottom: BorderSide(
                    color: borderColor,
                    width: borderWidth,
                  )
              )
          ),
          alignment: Alignment.center,
          child: Text(
              text,
              style: ThemeTexts.textStyleTitle3.copyWith(color: textColor,fontWeight: FontWeight.w500)
          ),
        ));
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
      {
        required BuildContext context,
        required String text,
      }){
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(text),
            duration: Duration(milliseconds: 1500)));
  }

  Future<String?> dialogueBoxSimple({
  required BuildContext context,
  required String titleText,
  required String hintText,
  required TextEditingController textEditingController,

}) => showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titleText),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width/2,
                child: TextFormField(
                  controller: textEditingController,
                  maxLength: 10,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                    counterText: "",
                    hintText: hintText,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.black,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              )],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: () {
                  Navigator.of(context).pop(textEditingController.text.toString());
                },
                    child: Text('DONE')),
              ],
            ),
          ],
        );
      });



}
